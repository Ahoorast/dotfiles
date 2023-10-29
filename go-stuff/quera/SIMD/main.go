package main

import (
	"sync"
)

func Solution(f func(uint8) uint8, inp uint32) uint32 {
	// TODO
	var res uint32
	var wg sync.WaitGroup
	for i := 0; i < 4; i++ {
		block := uint8(inp >> (8 * i))
		wg.Add(1)
		go func(i int) {
			res |= uint32(f(block)) << (8 * i)
			wg.Done()
		}(i)
	}
	wg.Wait()
	return res
}
