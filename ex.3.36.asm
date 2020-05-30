.data
        A:        	.float     3.41796875E-3
				B:    		 	.float     4.150390625E-3
				C:    		 	.float     1.05625E2
    newline:      	.asciiz    "\n"
.text
        l.s     		$f12,     	B
        l.s     		$f13,     	C
        #   No need to convert A, B and C to PHP here
        #   since mul.php will convert them to PHP first
        jal     		mul.php              	 		# result  C=A*B saved in $f0 in PHP format
        l.s     		$f12,     	A          	  # put A in $f13
        mov.s   		$f13,     	$f0         	# put B*C in $f12 in PHP format
        jal     		mul.php              	 		# result A*(B*C) saved in $f0 in PHP format

        mov.s   		$f12,     	$f0         	# put A*(B*C) in $f12 in PHP format
        li      		$v0,      	2           	# print decimal value (Answer: 0.001499176)
        syscall
        la      		$a0,    		newline
        li      		$v0,    		4
        syscall

        jal      		cvt.h.php      	 					#  PHP --> Half
        move  			$a0,      	$v0   				#  half-precision C in $a0
        li         	$v0,      	 34
        syscall                       				#  print half-precision encoding of C
																							#	 Answer: 0x00001624
EXIT:
        li         	$v0,      	 10
        syscall                       				#  exit
			

