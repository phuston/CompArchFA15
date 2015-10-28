addi $a0, $zero, 10
addi $t1, $zero, 0

loop:
	add $t1, $a0, $t1
	subi $a0, $a0, 1
	beqz $a0, breakloop
	j loop
	
breakloop:
	add $v0, $zero, $t1

