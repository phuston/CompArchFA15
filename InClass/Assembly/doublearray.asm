la $t0, array1

addi $t1, $zero, 3

LOOP:
	beq  $t1, $zero, END
	addi $t1, $t1, -1
	sll  $t2, $t1, 2
	lw   $t3, array1($t2)
	sll  $t3, $t3, 1
	sw   $t3, array1($t2)
	
END: 
	j LOOP


# Pre-populate array data in memory using .data section
.data 
array1:
0x00000001	      #element0
0x00000002	      #element1
0x00000003	      #element2
