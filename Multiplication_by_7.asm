	.data
enter:	.asciiz "Enter a number "
m:	.word 0
seven:	.word 7
first:	.asciiz "Result of the first way of multiplication by 7 is "
second:	.asciiz "\nResult of the second way of multiplication by 7 is "
finish:	.asciiz "\nDONE!"

	.text
main:
	la $a0, enter
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
firstWay:
	la $a0, first
	li $v0, 4
	syscall

	mul $t1, $t0, 7
	
	move $a0, $t1
	li $v0, 1
	syscall

	la $a0, second
	li $v0, 4
	syscall
	
secondWay:
	
	lw $t1, seven
	mult $t1, $t0
	mfhi $t2
	mflo $v0
	move $a0, $v0
	li $v0, 1
	syscall
	
done:
	la $a0, finish
	li $v0, 4
	syscall

	li $v0, 10
	syscall