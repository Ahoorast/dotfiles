package cache

import (
	_ "maps"
)

type CacheEntry struct {
	RTL int
	val CacheVal
}

type CacheKey struct {
	key string
}

type Cache struct {
	m map[CacheKey]CacheEntry
}

type CacheServerConnection struct {
	cache *Cache
}

func InitCache() *Cache {
	cache := &Cache{make(map[CacheKey]CacheEntry)}
	return cache
}

func (cache *Cache) handleRequest(req CacheRequest, client string) CacheResponse {
	if req.Request == "Set" {
		RTL := req.RTL
		if RTL == 0 {
			RTL = -1
		}
		entry := CacheEntry{RTL, req.Val}
		key := CacheKey{req.Key}
		cache.m[key] = entry
		return CacheResponse{}
	}
	key := CacheKey{req.Key}
	entry := cache.m[key]
	if entry.RTL != -1 {
		if entry.RTL == 0 {
			return CacheResponse{}
		}
		cache.m[key] = CacheEntry{entry.RTL - 1, entry.val}
	}
	return CacheResponse{Val: entry.val}
}

func (cache *Cache) listen(serverConn *CacheServerConnection, clientConn *CacheClientConnection, client string) {
	for {
		select {
		case req := <-clientConn.snd:
			clientConn.rcv <- cache.handleRequest(req, client)
		}
	}
}

func (cache *Cache) Connect(name string) *CacheClientConnection {
	request := make(chan CacheRequest)
	response := make(chan CacheResponse)
	//https://knowyourmeme.com/memes/trade-offer
	serverConn := &CacheServerConnection{}
	clientConn := &CacheClientConnection{
		snd: request,
		rcv: response,
	}
	go cache.listen(serverConn, clientConn, name)
	//cache.connsMutex.Lock()
	//cache.conns = append(cache.conns, serverConn)
	//cache.connsMutex.Unlock()
	return clientConn
}
