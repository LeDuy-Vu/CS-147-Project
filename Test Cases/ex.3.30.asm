.data
	A:	.float -8.0546875
	B:	.float -0.179931640625  # -1.79931640625 x10^–1
	newline:.asciiz "\n"

.text
	l.s $f12, A
	l.s $f13, B
	# No need to convert A and B to PHP here
	# since mul.php will convert floats to PHP first
	jal mul.php	# put C = A * B in $f0
        mov.s $f12, $f0 # put C in $f12
        li $v0, 2	# print decimal value of C (answer: 1.4492188)

	syscall
	la $a0,	newline
	li $v0,	4
	syscall

	jal cvt.h.php	# PHP --> Half
	move $a0, $v0	# half-precision C in $a0
	li $v0, 34	# print half-precision encoding of C
	syscall		# answer: 0x00003dcc

EXIT:
	li $v0,	10
	syscall