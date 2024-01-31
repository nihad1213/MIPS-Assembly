#Purpose: Program Transform Decimal into Binary and Hexadecimal
#Author: Nihad Namatli
#Created Date: 07.12.2023

#In .data Part We Write our Variables and Their Values
.data
welcome:		.asciiz "\nPlease enter the number: "
enteredNumber:		.asciiz "\nYou entered this number: "
query:			.asciiz "\nWhat do you want to do ? (Enter 1 for decimal to binary, Enter 2 for decimal to hexadecimal): "
error:			.asciiz "\nPlease choose 1 or 2!"
restart:		.asciiz "\nProgram restarted again!"
binary:			.asciiz "\nBinary representation of your number is: "
hex:			.asciiz "\nHexadecimal representation of your number is: "
result: 		.space 32 #It is used for hexadecimal number it will writed in 8 character. 
				 #for example 315 in hexadecimal writed as a 00000315
#In .text Part We Write Our Codes

.text
main:
	#It will print welcome which created in .data part
	li $v0, 4
	la $a0, welcome
	syscall
	
	#Read Integer
	li $v0, 5
	syscall
	move $t0, $v0
	
	#It will print enteredNumber which created in .data part
	li $v0, 4
	la $a0, enteredNumber
	syscall
	
	#It will print number which we entered
	li $v0, 1
	move $a0, $t0
	syscall
	
	#It will print query which created in .data part
	li $v0, 4
	la $a0, query
	syscall
	
	#It will read integer for operation
	li $v0, 5
	syscall
	move $t1, $v0 
	
	#If we enter 1 Program convert entered number into binary
	beq $t1, 1, DECIMALtoBINARY
	#If we enter 2 Program convert entered number into hexadecimal 
	beq $t1, 2, DECIMALtoHEXADECIMAL
	
	#In these part number refers to query part
	beq $t1, 0, ERROR	#If number is equals to 0 it will show error
	slt $t0, $t1, $t1	#$t1 < $t1 $t0 = 0 else $t1 = 0
	bne $t1, $zero, ERROR	#If number greater than 2 it will show error
	
DECIMALtoBINARY:
	#It will print binary in .data part
	li $v0, 4
	la $a0, binary
	syscall 
	
	#It means $t0 = 0 + v0
	add $t1, $zero, $t0 
	li $t2, 31 
Loop: 
	#blt compare two register if entered number is zero it will go to EndLoop
	blt $t2, 0, EndLoop 
	#srlv = Shift right logical variable
	srlv $t3, $t1, $t2 
	and $t3, 1 
	li $v0, 1 
	move $a0, $t3 
	syscall 
	
	#it means $t2 = $t2 - 1 
	sub $t2, $t2, 1 
	b Loop 
	
EndLoop: 
	j main
	
DECIMALtoHEXADECIMAL:
	
	#It will print hex in .data part
	li $v0, 4
	la $a0, hex
	syscall
		
	move $t2, $t0
	
	li $t0, 8 # counter 
	la $t3, result

Loop2:
	beqz $t0, Exit 
	# branch to exit if counter is equal to zero 
	rol $t2, $t2, 4 # rotate 4 bits to the left 
	and $t4, $t2, 0xf # mask with 1111 
	ble $t4, 9, Sum # if less than or equal to nine, branch to sum 
	addi $t4, $t4, 55 # if greater than nine, add 55 
	b End 
Sum: 
	addi $t4, $t4, 48 # add 48 to result 

End: 
	sb $t4, 0($t3) # store hex digit into result 
	addi $t3, $t3, 1 # increment address counter 
	addi $t0, $t0, -1 # decrement loop counter 
	j Loop2

Exit: 
	la $a0, result 
	li $v0, 4 
	syscall
	 
	j main
	
ERROR:
	li $v0, 4
	la $a0, error
	syscall
	
	li $v0, 4
	la $a0, restart
	syscall
	
	j main
	 
	li $v0, 10
	syscall
