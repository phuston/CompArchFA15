addi $t0, $zero, 0 # index into array, forward
addi $t1, $zero, 20 # length of array times 4
addi $t2, $t1, -4 # index into array, backward

LOOP:
ble $t2, $t0, DONE
lw $t3, array($t0) # load
lw $t4, array($t2)
sw $t3, array($t2) # switch
sw $t4, array($t0)
addi $t0, $t0, 4 # update counters
addi $t2, $t2, -4
j LOOP

DONE:

.data
array:
0x1
0x42
0x31
0x14
0x35