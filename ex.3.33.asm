.data
        A:        	.float     3.984375E-1
				B:    		 	.float     3.4375E-1
				C:    		 	.float     1.771E3
    newline:      	.asciiz    "\n"
.text
        l.s     		$f12,     	B
        l.s     		$f13,     	C
        #   No need to convert A, B and C to PHP here
        #   since mul.php will convert them to PHP first
        jal     		add.php              	 		# result  C=A+B saved in $f0 in PHP format
        l.s     		$f12,     	A          	  # put A in $f12
        mov.s   		$f13,     	$f0         	# put B+C in $f13 in PHP format
        jal     		add.php              	 		# result A+(B+C) saved in $f0 in PHP format

        mov.s   		$f12,     	$f0         	# put A+(B+C) in $f12 in PHP format
        li      		$v0,      	2           	# print decimal value of sum (Answer; 1771.0)
        syscall
        la      		$a0,    		newline
        li      		$v0,    		4
        syscall

        jal      		cvt.h.php      	 					#  PHP --> Half
        move  			$a0,      	$v0   				#  half-precision C in $a0
        li         	$v0,      	 34
        syscall                       				#  print half-precision encoding of C
																							#	 Answer; 0x000066eb
EXIT:
        li         	$v0,      	 10
        syscall                       				#  exit
			

