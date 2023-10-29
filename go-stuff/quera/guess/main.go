package main

import "fmt"

func GuessMyNumber(game Game) string {
	l, r := 1, 361
	for l+1 < r {
		mid := (l + r) >> 1
		res := game.CheckNumber(mid)
		if res == "CORRECT" {
			return fmt.Sprintf("Your Number was %d", mid)
		}
		if res == "My Number is Greater" {
			l = mid
		} else {
			r = mid
		}
	}
	return fmt.Sprintf("Your Number was %d", l)
}
