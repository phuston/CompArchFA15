addi $t0, $zero, 6 # N
addi $t1, $zero, 1 # f_prev
addi $t2, $zero, 1 # f_curr

BEGIN: 
beq $t0, 2, END # need to start computing at f_2 -> already defined f_0 and f_1
	add $t3, $t2, $t1 # temp sum of previous two
	add $t1, $zero, $t2
	add $t2, $zero, $t3
	addi $t0, $t0, -1
	j BEGIN

END:
addi $v0, $t3, 0