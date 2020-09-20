	.data
arr:	.space 48
size:	.word 12
space:	.asciiz "\n"
minNum:	.asciiz "The Min number of the array is "
locate:	.asciiz " and it is Located at "
	
	.text
main:
	lw $t1, size
	mul $t2, $t1, 4
	
loop:
	li $a1, 100
	li $v0, 42
	syscall
	
	sw $a0, arr($t0)
	addi $t0, $t0, 4
	beq $t2, $t0, reset1
	j loop

reset1:
	li $t0, 0
	la $a2, arr

display:
	li $v0, 1
	lw $a0, arr($t0)
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	addi $t0, $t0, 4
	beq $t2, $t0, reset2
	j display
	
reset2:
	li $t0, 0
	la $a2, arr
	
	lw $t7, arr($t0)
	addi $t0, $t0, 4
	
findMin:
	lw $t6, arr($t0)
	slt $t5, $t7, $t6
	
	beqz $t5, setMin
	addi $t0, $t0, 4
	beq $t2, $t0, end
	j findMin
	
setMin:
	lw $t7, arr($t0)
	addi $t0, $t0, 4
	move $t4, $t0
	j findMin
	
end:
	la $a0, minNum
	li $v0, 4
	syscall

	move $a0, $t7
	li $v0, 1
	syscall
	
	la $a0, locate
	li $v0, 4
	syscall
	
	div $t4, $t4, 4
	move $a0, $t4
	li $v0, 1
	syscall

	li $v0, 10
	syscall