package main

import "fmt"

func main() {
	// va 0x1000 pte 0x21FD1417 pa 0x87F45000 perm 0x17
	pte := 0x21FD1417
	ppn := pte >> 10
	// 44位 12 + 16 + 16
	ppn &= 0x3F_4F_4F
	fmt.Println(fmt.Sprintf("%x", ppn))
	va := 0x1000
	pa := (ppn << 12) | (va & 0x3F)
	fmt.Println(fmt.Sprintf("%x", pa))
}
