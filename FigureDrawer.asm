#Author: Nihad Namatli
#Program Purpose: Figure Draw
#Created Date: 09.12.2023

#In .data part we write our variables and their values
.data
asterisk:	.asciiz "*"
query:		.asciiz "\nTriangle(0) or Square(1) or Pyramid(2)? "
error:		.asciiz "\nPlease choose correct number for operation!"
error2: 	.asciiz "\nHeight cant be zero"
restart:	.asciiz "\nProgram restarted again!"
#test: 		.asciiz "\nTest Passed!"
size:		.asciiz "\nWrite Height of Figure: "
newline:	.asciiz "\n"
space:		.asciiz " "

#In .text part we write our code
.text
main:
	#It will print query in .data part
	li $v0, 4
	la $a0, query
	syscall
	
	#We enter number. This number help us to draw figure.
	li $v0, 5
	syscall
	move $t0, $v0
	
	#If we enter 0 it goes to TRIANGLE function
	#If we enter 1 it goes to SQUARE function
	#If we enter 2 it goes to PYRAMID function
	beq $t0, 0, TRIANGLE
	beq $t0, 1, SQUARE
	beq $t0, 2, PYRAMID
	
	#If enetered number doesnt equal to 0 or 1 or 2 Go to Error part of code and give error message
	bne $t0, 0, ERROR
	bne $t0, 1, ERROR
	bne $t0, 2, ERROR

TRIANGLE:
	
	#It will print size created in .data part
	li $v0, 4
	la $a0, size
	syscall
	
	#Entering height of Figure
	li $v0, 5
	syscall 
	move $t1, $v0
	
	#If height equal to zero it will go to ERROR2 part of the code and give error message
	beq $t1, 0, ERROR2
	
	#t2 represent row
	li $t2, 0
	
OUTERLOOP1:
	#t3 represent column
	li $t3, 0

INNERLOOP1:
	bgeu $t3, $t2, PRINTNEWLINE #Print new line if t3 greater than t2
	
	#it will print asterisk
	li $v0, 4
	la $a0, asterisk
	syscall
	
	#t3 = t3 + 1 
	addi $t3, $t3, 1
	#check column is less than square height
	
	j INNERLOOP1

PRINTNEWLINE:
	
	#Print new line
	li $v0, 4
	la $a0, newline
	syscall
	
	#t2 = t2 + 1
	addi $t2, $t2, 1
	
	# Check if row is less than the triangle height
    	bleu $t2, $t1, OUTERLOOP1 #t2 < t1 go to OUTERLOOP
	
	#Go back main part
	j main

SQUARE:
	#It will print size created in .data part
	li $v0, 4
	la $a0, size
	syscall
	
	#Entering height of Figure
	li $v0, 5
	syscall 
	move $t1, $v0
	
	#If height equal to zero it will go to ERROR2 part of the code and give error message
	beq $t1, 0, ERROR2
	
	#t2 represent row
	li $t2, 0
OUTERLOOP2:
	#t3 represent column
	li $t3, 0

INNERLOOP2:
	#it will print asterisk
	li $v0, 4
	la $a0, asterisk
	syscall
	
	#t3 = t3 + 1 
	addi $t3, $t3, 1
	#check column is less than square height
	blt $t3, $t1, INNERLOOP2
	
	#It will print newline
	li $v0, 4
	la $a0, newline 
	syscall
	
	#t2 = t2 + 1
	addi $t2, $t2, 1
	#check row is less than square height
    	blt $t2, $t1, OUTERLOOP2
	#Go back main part
	j main

PYRAMID:
	
	#It will print size created in .data part
	li $v0, 4
	la $a0, size
	syscall
	
	#Entering height of Figure
	li $v0, 5
	syscall 
	move $t1, $v0
	
	move $s0, $v0 # height of pyramid
	move $s1, $v0
	addi $s1, $s1, -1 # number of spaces required before each line

	li $v0, 4
	la $a0, newline
	syscall
	
	li $t0, 1

PRINTROW:
	bgt $t0, $s0, EXIT
		
	# print spaces
	move $a1, $s1
	jal PRINTSPACES
	addi $s1, $s1, -1

	# print stars
	move $a1, $t0
	jal PRINTASTERISK
	addi $t0, $t0, 1

	j PRINTROW

EXIT: 
	li $v0, 10
	syscall

PRINTASTERISK:
	# print $a1 number of asterisk
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $v0, 4($sp)
	sw $a0, 8($sp)
	li $v0, 4

ASTERSIKLOOP:
	beq $a1, $zero, RETURNASTERISK
	la $a0, asterisk
	syscall
	la $a0, space
	syscall
	addi $a1, $a1, -1
	j ASTERSIKLOOP

RETURNASTERISK:
        la $a0, newline
	syscall
	lw $ra, ($sp)
	lw $v0, 4($sp)
	lw $a0, 8($sp)
	addi $sp, $sp, 12
	jr $ra

PRINTSPACES:
	# print $a1 number of spaces
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $v0, 4($sp)
	sw $a0, 8($sp)
	li $v0, 4
	la $a0, space

PRINTONEMORE:
	beq $a1, $zero, RETURNSPACES
	syscall
	addi $a1, $a1, -1
	j PRINTONEMORE

RETURNSPACES: 
	lw $ra, ($sp)
	lw $v0, 4($sp)
	lw $a0, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	
			
ERROR:
	#It will print error which created in .data part
	li $v0, 4
	la $a0, error
	syscall
	
	#It will print restart which created in .data part 
	li $v0, 4
	la $a0, restart
	syscall
	
	j main

ERROR2:
	li $v0, 4
	la $a0, error2
	syscall
	
	li $v0, 4
	la $a0, restart
	syscall

	j main
