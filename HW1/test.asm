.data
msg1:	.asciiz "Enter the number n = "
msg2:	.asciiz " is a prime"
msg3:	.asciiz " is not a prime, the nearest prime is "
space:  .asciiz " "
.text
.globl main
main:
		li $t0 0xaaaaaaaa
		li $t1 0x33333333
		nor $t0,$t0,$zero
		li $v0, 10		# call system call: exit
  		syscall			# run the syscall
