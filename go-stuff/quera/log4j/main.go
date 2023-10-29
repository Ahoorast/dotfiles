package main

import (
	"sync"
)

func Hack(start string) []string {
	finalResult := []string{}

	tempResult := Retrieve(start)
	finalResult = append(finalResult, tempResult...)
	var wg sync.WaitGroup
	for _, v := range tempResult {
		wg.Add(1)
		go func(v string) {
			finalResult = append(finalResult, Hack(v)...)
			wg.Done()
		}(v)
	}
	wg.Wait()
	return finalResult
}
