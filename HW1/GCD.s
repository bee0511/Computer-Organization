.data
msg1:	.asciiz "Enter first number: "
msg2:	.asciiz "\nEnter second number: "
msg3:	.asciiz "\nThe GCD is: "

.text
.globl main
#------------------------- main -----------------------------
main:
# print msg1 on the console interface
		li      $v0, 4		# call system call: print string
		la      $a0, msg1	# load address of string into $a0
		syscall                 	# run the syscall
 
# read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		move    $a1, $v0      	# store input in $a1 (set arugument a of procedure GCD)
  		
 # print msg1 on the console interface
		li      $v0, 4		# call system call: print string
		la      $a0, msg2	# load address of string into $a0
		syscall                 	# run the sycall
		
 # read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		move    $a2, $v0      	# store input in $a2 (set arugument b of procedure GCD)
  		
# jump to procedure GCD
  		jal GCD
		move $t0, $v0		# save return value in t0 (because v0 will be used by system call) 

# print msg3 on the console interface
		li      $v0, 4		# call system call: print string
		la      $a0, msg3	# load address of string into $a0
		syscall                 	# run the syscall

# print the result of procedure GCD on the console interface
		move $a0, $t0	
		li $v0, 1		# call system call: print integer
		syscall 			# run the syscall
   
		li $v0, 10		# call system call: exit
  		syscall			# run the syscall
  		
#------------------------- procedure GCD -----------------------------
# load argument a, b in a1, a2, respectively. Return value in v0. 
.text
GCD:	
  		addi $sp, $sp, -12   	# adjust stack for 3 items
 		sw $ra, 0($sp)         	# save the return address
  		sw $a1, 4($sp)         	# save the argument a
  		sw $a2, 8($sp)         	# save the argument b
  		div $a1, $a2
  		mfhi $t0  		# temp for the a % b
  		bne $t0, $zero, L1    	# if a % b != 0 go to L1
		move $v0, $a2         	# if a % b == 0, return b
  		addi $sp, $sp, 12      	# restore stack pointer
  		jr $ra                 	# return to the caller

L1:
		move $a1, $a2		# let a = b
  		move $a2, $t0		# let b = a % b
  		jal GCD			# return GCD (b, a % b)
   		lw $ra, 0($sp)        	# return from GCD, restore return address
  		lw $a1, 4($sp)         	# restore a
  		lw $a2, 8($sp)         	# restore b
  		addi $sp, $sp, 12      	# restore stack pointer
  		jr $ra                 	# return to the caller
