.data
	A:	.float -0.15625 # Single Precision
	newline:.asciiz "\n"

.text
	l.s $f12, A
	jal cvt.php.s		# Single --> PHP
	mov.s $f12, $f0
	jal show.value
	jal cvt.h.php		# PHP --> Half 

	jal show.encoding

EXIT:
	li $v0, 10
	syscall

show.value:
	mfc1 $a0, $f0
	li $v0, 2		# print the decimal value of A
	syscall			# ANSWER: -0.15625

	la $a0, newline
	li $v0, 4
	syscall			# print newline
	jr $ra

show.encoding:
	move $a0, $v0
	li $v0, 34		# print encoding in HEX
	syscall			# ANSWER: 0x0000b100
	la $a0, newline
	li $v0, 4
	syscall			# print newline
	jr $ra