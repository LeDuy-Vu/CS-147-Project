.data
	A:	.float 8.625E1
	B:	.float -4.875E0
	newline:.asciiz "\n"
.text
	l.s $f12, A
        l.s $f13, B
        # No need to convert A and B to PHP here
        # since mul.php will convert them to PHP first
        jal div.php	# result  C = A / B saved in $f0 in PHP format
        mov.s $f12, $f0	# put C in $f12
        li $v0, 2	# print decimal value of C (answer: -17.6875)
        syscall
        la $a0, newline
        li $v0, 4
        syscall

        jal cvt.h.php	# PHP --> Half
        move $a0, $v0	# half-precision C in $a0
        li $v0, 34
        syscall		# print half-precision encoding of C
        		# answer: 0x0000cc6c
EXIT:
        li $v0, 10
        syscall		# exit