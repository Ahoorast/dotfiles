package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

var keys = []string{
	"bale",
	"kheir",
	"areh",
	"na",
}

func cor(coms []int) bool {
	if len(coms) == 0 {
		return true
	}
	nxt := -1
	if coms[0] == 0 {
		nxt = 1
	} else if coms[0] == 2 {
		nxt = 3
	} else {
		return false
	}
	fnd := -1
	for i, com := range coms {
		if com == nxt {
			fnd = i
			break
		}
	}
	if fnd == -1 {
		return false
	}
	return cor(coms[1:fnd]) && cor(coms[fnd+1:])
}

func main() {
	reader := bufio.NewReader(os.Stdin)
	code, _ := reader.ReadString('\n')
	var coms []int
	for len(code) > 0 {
		indx := len(code)
		tp := -1
		for i, com := range keys {
			nxt := strings.Index(code, com)
			if nxt != -1 && indx > nxt {
				indx = nxt
				tp = i
			}
		}
		if indx == len(code) {
			fmt.Println("NO")
			return
		}
		coms = append(coms, tp)
		code = code[indx+len(keys[tp]):]
	}
	if !cor(coms) {
		fmt.Println("NO")
		return
	}
	fmt.Println("YES")
}
