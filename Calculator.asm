#Author: Nihad Namatli
#File Name: Calculator.asm
#Purpose: Simple Calculator

.data
welcome:		.asciiz "                ******Calculator******\n"
program:		.asciiz "\nPlease select number for operation (1->Add, 2->Subtract, 3->Multiply, 4->Divide): "
number1:		.asciiz "\nPlease enter the first number: "
number2:		.asciiz "\nPlease enter the second number: "
result:			.asciiz "\nThe Result is: "
error1:			.asciiz "\nPlease restart program again!"
error2:			.asciiz "\nCannot be divided by zero!"
warning:		.asciiz "\nThe answer will be negative!"


.text
main:
	#INTRODUCTION PART
	
	#Print "welcome" string 
	li $v0, 4
	la $a0, welcome
	syscall
	
	#Print "program" string 
	li $v0, 4
	la $a0, program
	syscall
	
	#Read integer
	li $v0, 5
	syscall
	move $t1, $v0
	
	
	#IF ElSE PART
	
	beq  $t1, 1, ADD     	# if we write 1 it add numbers
	beq  $t1, 2, SUB	# if we write 2 it subtract numbers
	beq  $t1, 3, MUL	# if we write 3 it multiply numbers
	beq  $t1, 4, DIV	# if we write 4 it divide numbers
	
	slt  $t0,$t1,$t1      
	bne  $t1,$zero,ERROR1    #This part check the entered number. If number greater than 4, program show error1 message.
	
	ADD:
		#Print "number1" string
		li $v0, 4
		la $a0, number1
		syscall
		
		#Read integer
		li, $v0, 5
		syscall
		move $s0, $v0
		
		#Print "number2" string
		li $v0, 4
		la $a0, number2
		syscall
		
		#Read integer
		li, $v0, 5
		syscall
		move $s1, $v0
		
		#Add two number
		add $s2, $s1, $s0
		
		#Print "result" string
		li $v0, 4
		la $a0, result
		syscall
		
		#Save number
		li $v0, 1
		move $a0, $s2
		syscall
		
		#Finis ADD part
		j Exit
	
	SUB:
		#Print "number1" string
		li $v0, 4
		la $a0, number1
		syscall
		
		#Read integer
		li, $v0, 5
		syscall
		move $s0, $v0
		
		#Print "number2" string
		li $v0, 4
		la $a0, number2
		syscall
		
		#Read integer
		li, $v0, 5
		syscall
		move $s1, $v0
		
		slt  $t1,$s0,$s1      
		bne  $t1,$zero,WARNING  
			
		#Subtract two number
		sub $s2, $s0, $s1
		
		#Print "result" string
		li $v0, 4
		la $a0, result
		syscall
		
		#Save number
		li $v0, 1
		move $a0, $s2
		syscall
		
		#Finis SUB part
		j Exit
		
	MUL:
		#Print "number1" string
		li $v0, 4
		la $a0, number1
		syscall
		
		#Read integer
		li, $v0, 5
		syscall
		move $s0, $v0
		
		#Print "number2" string
		li $v0, 4
		la $a0, number2
		syscall
		
		
		#Read integer
		li, $v0, 5
		syscall
		move $s1, $v0
		
		#Multiple two number
		mul $s2, $s0, $s1
		
		#Print "result" string
		li $v0, 4
		la $a0, result
		syscall
		
		#Save number
		li $v0, 1
		move $a0, $s2
		syscall
		
		#Finis MUL part
		j Exit
		
	DIV:
		#Print "number1" string
		li $v0, 4
		la $a0, number1
		syscall
		
		#Read integer
		li, $v0, 5
		syscall
		move $s0, $v0
		
		#Print "number2" string
		li $v0, 4
		la $a0, number2
		syscall
		
		#Read integer
		li, $v0, 5
		syscall
		move $s1, $v0
		
		beq  $s1, 0, ERROR2  #if $s1 equals to 0 it "goes" ERROR2 part of the code
		
		#Divide two number
		div $s2, $s0, $s1
		
		#Print "result" string
		li $v0, 4
		la $a0, result
		syscall
		
		#Save number
		li $v0, 1
		move $a0, $s2
		syscall
		
		#Finis DIV part
		j Exit
		
	ERROR1:
		#Error mesage for entered number
		li $v0, 4
		la $a0, error1
		syscall
		
	ERROR2: 
		#Error mesage for number which equals to zero
		li $v0, 4
		la $a0, error2
		syscall
		
	WARNING:
		#Warning mesage for negative result
		li $v0, 4
		la $a0, warning
		syscall	
	Exit:	
	
		li $v0, 10		#End Program
		syscall			