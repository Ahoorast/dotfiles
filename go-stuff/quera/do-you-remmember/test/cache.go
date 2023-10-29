package cache

import (
	_ "maps"
	"sync"
	"time"
)

type CacheEntry struct {
	RTL int
	val CacheVal
}

type CacheKey struct {
	key string
}

type Cache struct {
	conns      []*CacheServerConnection
	connsMutex sync.Mutex
	m          map[CacheKey]CacheEntry
}

type CacheServerConnection struct {
	req chan CacheRequest
}

func InitCache() *Cache {
	cache := &Cache{
		conns: make([]*CacheServerConnection, 0),
	}

	go func() {
		for {
			time.Sleep(10 * time.Millisecond)

			cache.connsMutex.Lock()
			for _, conn := range cache.conns {
				select {
				case req := <-conn.req:
					switch req.Request {
					case "Set":
						cache.set(req.Key, req.Val, req.RTL)
						conn.rcv <- CacheRequest{}
					case "Get":
						val, ok := cache.get(req.Key)
						if ok {
							conn.req <- CacheRequest{
								Val: val,
							}
						} else {
							conn.req <- CacheRequest{}
						}
					}
				default:
				}
			}
			cache.connsMutex.Unlock()
		}
	}()

	return cache
}

func (cache *Cache) Connect(name string) *CacheClientConnection {
	request := make(chan CacheRequest)

	serverConn := &CacheServerConnection{
		req: request,
	}

	cache.connsMutex.Lock()
	cache.conns = append(cache.conns, serverConn)
	cache.connsMutex.Unlock()

	clientConn := &CacheClientConnection{
		snd: request,
		rcv: make(chan CacheResponse),
	}

	go func() {
		for {
			res := <-clientConn.rcv
			if res.Msg == "done" {
				return
			}
		}
	}()

	return clientConn
}

func (cache *Cache) set(key string, val CacheVal, RTL int) {
	if RTL == 0 {
		RTL = -1
	}
	entry := CacheEntry{RTL, val}
	cacheKey := CacheKey{key}
	cache.m[cacheKey] = entry
}

func (cache *Cache) get(key string) (CacheVal, bool) {
	cacheKey := CacheKey{key}
	entry := cache.m[cacheKey]
	if entry.RTL != -1 {
		if entry.RTL == 0 {
			return entry.val, false
		}
		cache.m[cacheKey] = CacheEntry{entry.RTL - 1, entry.val}
	}
	return entry.val, true
}
