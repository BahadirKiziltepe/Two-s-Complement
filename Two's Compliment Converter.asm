    	.data
space:	.asciiz " "
nextL: 	.asciiz "\n"
enter:  .asciiz "Enter 32 bit binary: "
wrong:  .asciiz "\nInput mismatch!\n"
output:	.asciiz "Your 32-bit sign/magnitude binary's Two's Complement is "
input:  .space 132

  	.text
main:
   	la $a0, enter
  	la $v0, 4
  	syscall

    	li $v0, 8  #get a 32 bit number
    	la $a0, input
    	li $a1, 132
    	syscall
            
    	li $t7, 0 #set $t7 to 31, counter
    	li $t6, 33 #set $t6 to 33, check limit
    	li $t1, 1  #set $t1 to 1, check if 1
    	li $t0, 0  #set $t0 to 0, check if 0
    	
checkLimit: #check if the number is more than 32 bits, if more, let user enter the input one more time
	lbu $t3, input($t6)
	beq $t3, 10, fail
	
	la $a0, output
    	li $v0, 4
    	syscall

checkSign: #check if positive or negative
	lbu $t3, input($t7)
	beq $t3, 48, displayAsItIs #if positive, display the number as it is
    	beq $t3, 49, changeSign #if negative, change the sign and apply Two's Complement
    	
changeSign: #changes sign if entered number is negative
	li $t5, 48
    	sb $t5, input($t7)
    
checkBits: #check if 32 bits, if less, let user enter the input one more time
    	lbu $t3, input($t7)
    
    	beq $t7, 32, checked
    	beq $t3, 10, fail
    	beq $t3, 0, fail
    
    	beq $t3, 48, zeroMode
    	beq $t3, 49, oneMode
    
zeroMode: #0 -> 1
    	li $t5, 49
    	sb $t5, input($t7)

    	addi $t7, $t7, 1
    	j checkBits
    
oneMode: #1 -> 0
    	li $t5, 48
    	sb $t5, input($t7)
    
    	addi $t7, $t7, 1
    	j checkBits
    
fail: #if user failed to enter a corect input
    	la $a0, wrong
    	li $v0, 4
    	syscall
    
    	j main

checked: #analyzing the input ends here
	la $a0, nextL
	li $v0, 4
	syscall

	li $t7, 31
	lbu $t3, input($t7)
	
	beq $t3, 48, addToZero #check if the last number is zero
    	beq $t3, 49, addToOne #check if the last number is one
    	
addToZero: #add 1 to 0
	li $t5, 49
    	sb $t5, input($t7)
    	
    	li $t7, 0
    	j display

addToOne: #add 1 to 1
    	li $t5, 48
    	sb $t5, input($t7)
    	
    	subi $t7, $t7, 1
    	lbu $t3, input($t7)
    	beq $t3, 48, addToZero
    	beq $t3, 49, addToOne
    	
    	li $t7, 0
    	j display
    	
display: #start displaying
	lbu $t3, input($t7)
	beq $t7, 32, done
    
    	beq $t3, 48, displayZero
    	beq $t3, 49, displayOne
    	
displayZero: #display zero
    	li $a0, 0
    	li $v0, 1
    	syscall

    	addi $t7, $t7, 1
    	j display

displayOne: #display one
    	li $a0, 1
    	li $v0, 1
    	syscall
    
    	addi $t7, $t7, 1
    	j display

displayAsItIs: #display as it is if number is positive
	lbu $t3, input($t7)
	
	beq $t7, 32, done
	
	beq $t3, 48, displayZeroAsItIs
    	beq $t3, 49, displayOneAsItIs
    	
displayZeroAsItIs: #display zero
    	li $a0, 0
    	li $v0, 1
    	syscall

    	addi $t7, $t7, 1
    	j displayAsItIs

displayOneAsItIs: #display one
    	li $a0, 1
    	li $v0, 1
    	syscall
    
    	addi $t7, $t7, 1
    	j displayAsItIs

done: #program ends
    	la $v0, 10
    	syscall
