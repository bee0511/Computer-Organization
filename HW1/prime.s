.data
msg1:	.asciiz "Enter the number n = "
msg2:	.asciiz " is a prime"
msg3:	.asciiz " is not a prime, the nearest prime is "
space:  .asciiz " "
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
  		move    $a1, $v0      	# store input in $a1 (set arugument n of procedure prime)
# jump to procedure prime
  		jal prime
		move $t0, $v0		# save return value in t0 (because v0 will be used by system call) 
		bne $t0, $zero, print_is_prime #if prime(n) is 1, go to print_is_prime
# not prime, print msg3
		move $a0, $a1		
		li $v0, 1		# call system call: print integer
		syscall 			# run the syscall
		li      $v0, 4		# call system call: print string
		la      $a0, msg3	# load address of string into $a0
		syscall                 	# run the syscall
#go to for loop
		addi $s0, $zero, 1	# set i = 1
		addi $s1, $zero, 0	# set flag = 0
loop_main:
		addi $sp, $sp, -4
		sw $a1, 0($sp)		# store n
		sub $a1, $a1, $s0	# set $a1 = n - i
		jal prime		# goto procedure prime
		addi $ra, $ra, 12	# make $ra link to the line after print_n_minus_i
		move $t1, $v0		# save return value to t1
		bne $t1, $zero, print_n_minus_i # if prime(n - i) == 1 goto print_n_minus_i_or_n_add_i
		lw $a1, 0($sp)		# restore $a1 to n
		add $a1, $a1, $s0	# set $a1 = n + i
		jal prime		# goto procedure prime
		addi $ra, $ra, 12	# make $ra link to the line after print_n_add_i
		move $t1, $v0		# save return value to t1
		bne $t1, $zero, print_n_add_i # if prime(n + i) == 1 goto print_n_minus_i_or_n_add_i
		lw $a1, 0($sp)		# restore $a1 to n
		addi $sp, $sp, 4		# restore $sp
		bne $s1, $zero, exit_loop_main #if flag == 1, end the loop	
		addi $s0, $s0, 1		# i++
		j loop_main

print_n_minus_i:
		move $a0, $a1		# load n-i  into $a0
		li $v0, 1		# call system call: print integer
		syscall			# run the syscall
		li      $v0, 4		# call system call: print string
		la      $a0, space	# load address of string into $a0
		syscall                 	# run the syscall
		addi $s1, $zero, 1	# flag = 1
		jr $ra
print_n_add_i:
		move $a0, $a1		# load n+i  into $a0
		li $v0, 1		# call system call: print integer
		syscall			# run the syscall
		addi $s1, $zero, 1	# flag = 1
		jr $ra
exit_loop_main:	
		li $v0, 10		# call system call: exit
  		syscall			# run the syscall

#-------print the result of procedure prime on the console interface (when return value is 1)------
print_is_prime:
		move $a0, $a1	
		li $v0, 1		# call system call: print integer
		syscall 			# run the syscall
		
		li	$v0, 4		# call system call: print string
		la	$a0, msg2	# load address of string into $a0
		syscall                 	# run the syscall
   
		li $v0, 10		# call system call: exit
  		syscall			# run the syscall
#--------end of main function (when n is prime)----------------------------------------------------
#------------------------- procedure prime -----------------------------
# load argument n in a1, return value in v0. 
.text
prime:		
		addi $sp, $sp, -4
		sw $s0, 0($sp) 		# save $s0
		addi $t0, $zero, 0
		beq $a1, $t0, not_prime	#if(n == 0) goto not_prime(return 0)
  		addi $t0, $zero, 1
  		beq $a1, $t0, not_prime	#if(n == 1) go to not_prime(return 0)
		addi $s0, $zero, 2 	# int i = 2
		mul $t0, $s0, $s0	# $t0 = i * i
		slt $t1, $a1, $t0	# if i * i > n -> $t1 = 1. if i * i <= n -> $t1 = 0. 
		beq $t1, $zero, prime_loop # if i * i <= n go to prime_loop
		addi $v0, $zero, 1	# it is prime, set v0 to 1
		lw $s0, 0($sp)		# load $s0
		addi $sp, $sp, 4
  		jr $ra                 	# return to the caller

not_prime:
		lw $s0, 0($sp)
		addi $sp, $sp, 4
		addi $v0, $zero, 0
		jr $ra
		
prime_loop:	
		mul $t0, $s0, $s0	# $t0 = i * i
		slt $t1, $a1, $t0	# if i * i > n -> $t1 = 1. if i * i <= n -> $t1 = 0.
		bne $t1, $zero, exit_prime_loop #if i * i > n go to exit_prime_loop(return 1)
		div $a1, $s0		
		mfhi $t2			# t2 = n % i
		beq $t2, $zero, not_prime #if( n % i == 0) go to not_prime(return 0)
		addi $s0, $s0, 1		# i++
		j prime_loop	
		
exit_prime_loop:
		lw $s0, 0($sp)
		addi $sp, $sp, 4
		addi $v0, $zero, 1
		jr $ra
#----------------------End of procedure prime--------------------------
