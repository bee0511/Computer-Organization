.data
msg1:	.asciiz "Enter the number n = "
star:	.asciiz "*"
space:	.asciiz " "
next_line: .asciiz "\n"
.text
.globl main

main:
# print msg1 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg1			# load address of string into $a0
		syscall                 	# run the syscall
# read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		move    $a1, $v0		# store n into $a1
# int temp = (n+1)/2
  		addi $t0, $a1, 1		# $t0 is n + 1
  		addi $t1, $zero, 2	# $t1 is 2
  		div $t0, $t1
  		mflo $s0			# $s0 is temp
# if n % 2 == 0, go to L1
		div $a1, $t1
		mfhi $t2			# $t2 is n % 2
		addi $t0, $zero, 0	# $t0 is int i = 0
		beq $t2, $zero, first_outer_nested_loop	# if n % 2  == 0, go to outer_nested_loop
# if n % 2 == 1, temp-- and go to outer_nested_loop
		addi $s0, $s0, -1
		j first_outer_nested_loop
		
#--------------------start of first nested loop-------------------------		

first_outer_nested_loop:		
# get the i for second_outer_nested_loop
		addi $t3, $a1, 1		# $t3 is n + 1
		addi $t4, $zero, 2	# $t4 is 2
  		div $t3, $t4
  		mflo $t5
  		addi $t5, $t5, -1	# $t5 is (n + 1)/2 - 1
  
  		slt $t2, $t0, $s0	# if i < temp -> $t2 = 1, i >= temp -> $t2 = 0
		beq $t2, $zero, 	second_outer_nested_loop # i >= temp, go to second_outer_nested_loop

# if i < temp, do the following for loop
		addi $t1, $zero, 0	# $t1 is int j = 0
		slt $t2, $t0, $t1	# if i < j -> $t2 = 1, if i >= j -> $t2 = 0
		bne $t2, $zero, continue_first_outer_nested_loop	# i < j -> go to next for loop
		j first_print_space # i >= j -> print_space

first_print_space:
		slt $t2, $t0, $t1	# if i < j -> $t2 = 1, if i >= j -> $t2 = 0
		bne $t2, $zero, continue_first_outer_nested_loop	# i < j -> go to next for loop
		li      $v0, 4		# call system call: print string
		la      $a0, space	# load address of string into $a0
		syscall                 	# run the syscall
		addi $t1, $t1, 1		# j++
		j first_print_space

continue_first_outer_nested_loop: # i = $t0, j = $t1, n = $a1
		addi $t1, $zero, 0	# $t1 is int j = 0
# get n - i * 2
		sub $t2, $a1, $t0 # $t2 = n - i
		sub $t2, $t2, $t0 # $t2 = n - i - i = n - 2*i

		slt $t3, $t1, $t2 # $if j < n - 2*i -> $t3 = 1, otherwise, $t3 = 0
		beq $t3, $zero, print_next_line_goto_first_outer_nested_loop # if j >= n - 2*i, go to print_next_line_goto_first_outer_nested_loop
		j first_print_star
		
first_print_star:
		slt $t3, $t1, $t2 # $if j < n - 2*i -> $t3 = 1, otherwise, $t3 = 0
		beq $t3, $zero, print_next_line_goto_first_outer_nested_loop # if j >= n - 2*i, go to print_next_line_goto_first_outer_nested_loop
		li      $v0, 4		# call system call: print string
		la      $a0, star	# load address of string into $a0
		syscall                 	# run the syscall
		addi $t1, $t1, 1		# j++
		j first_print_star

print_next_line_goto_first_outer_nested_loop:
		li      $v0, 4		# call system call: print string
		la      $a0, next_line	# load address of string into $a0
		syscall                 	# run the syscall
		addi $t0, $t0, 1		# i++
		j first_outer_nested_loop
		
#--------------------end of first nested loop-------------------------

#--------------------start of second nested loop------------------------

second_outer_nested_loop: # i = $t5 = (n+1)/2 - 1, j = $t1, n - 2*i = $t2
		slt $t3, $t5, $zero # if i < 0, $t3 = 1. if i >= 0, $t3 = 0
		bne $t3, $zero, Exit # if i < 0, go to Exit
		addi $t1, $zero, 0 # $t1 = j = 0
		slt $t2, $t5, $t1	# if i < j -> $t2 = 1, if i >= j -> $t2 = 0
		bne $t2, $zero, continue_second_outer_nested_loop	# i < j -> go to next for loop
		j second_print_space

second_print_space:
		slt $t2, $t5, $t1	# if i < j -> $t2 = 1, if i >= j -> $t2 = 0
		bne $t2, $zero, continue_second_outer_nested_loop	# i < j -> go to next for loop
		li      $v0, 4		# call system call: print string
		la      $a0, space	# load address of string into $a0
		syscall                 	# run the syscall
		addi $t1, $t1, 1		# j++
		j second_print_space
		
continue_second_outer_nested_loop:	# i = $t5, j = $t1, n = $a1
		addi $t1, $zero, 0	# $t1 is int j = 0
# get n - i * 2
		sub $t2, $a1, $t5 # $t2 = n - i
		sub $t2, $t2, $t5 # $t2 = n - i - i = n - 2*i

		slt $t3, $t1, $t2 # $if j < n - 2*i -> $t3 = 1, otherwise, $t3 = 0
		beq $t3, $zero, print_next_line_goto_second_outer_nested_loop # if j >= n - 2*i, go to second_outer_nested_loop
		j second_print_star

second_print_star:
		slt $t3, $t1, $t2 # $if j < n - 2*i -> $t3 = 1, otherwise, $t3 = 0
		beq $t3, $zero, print_next_line_goto_second_outer_nested_loop # if j >= n - 2*i, go to s
		li      $v0, 4		# call system call: print string
		la      $a0, star	# load address of string into $a0
		syscall                 	# run the syscall
		addi $t1, $t1, 1		# j++
		j second_print_star

print_next_line_goto_second_outer_nested_loop:
		li      $v0, 4		# call system call: print string
		la      $a0, next_line	# load address of string into $a0
		syscall                 	# run the syscall
		addi $t5, $t5, -1		# i--
		j second_outer_nested_loop
#---------------------end of second nested loop-----------------		

Exit: 
		li $v0, 10					# call system call: exit
  		syscall						# run the syscall