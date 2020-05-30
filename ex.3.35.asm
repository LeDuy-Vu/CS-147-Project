.data
        A:        	.float     3.41796875E-3
				B:    		 	.float     4.150390625E-3
				C:    		 	.float     1.05625E2
    newline:      	.asciiz    "\n"
.text
        l.s     		$f12,     	A
        l.s     		$f13,     	B
        #   No need to convert A, B and C to PHP here
        #   since mul.php will convert them to PHP first
        jal     		mul.php              	 		# result  C=A*B saved in $f0 in PHP format
        mov.s   		$f12,     	$f0         	# put A*B in $f12 in PHP format
        l.s     		$f13,     	C          	  # put C in $f13
        jal     		mul.php              	 		# result (A*B)*C saved in $f0 in PHP format

        mov.s   		$f12,     	$f0         	# put (A*B)*C in $f12 in PHP format
        li      		$v0,      	2           	# print decimal value (Answer: 0.0 or 0.0014982224 if denorm is considered.)
        syscall
        la      		$a0,    		newline
        li      		$v0,    		4
        syscall

        jal      		cvt.h.php      	 					#  PHP --> Half
        move  			$a0,      	$v0   				#  half-precision C in $a0
        li         	$v0,      	 34
        syscall                       				#  print half-precision encoding of C
																							#	 Answer: 0x00000000 (or 0x00001623 if denorm is considered.)

EXIT:
        li         	$v0,      	 10
        syscall                       				#  exit
			

