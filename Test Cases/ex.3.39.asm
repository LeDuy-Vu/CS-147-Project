# Ex3.39 (A*B) + (A*C) 
.data
        A:        	.float     1.666015625E0
				B:    		 	.float     1.9760E4
				C:    		 	.float     -1.9744E4
    newline:      	.asciiz    "\n"
.text
        l.s     		$f12,     	A
        l.s     		$f13,     	C
        #   No need to convert A, B and C to PHP here
        #   since mul.php will convert them to PHP first
        jal     		mul.php           				# result  A*C saved in $f0 in PHP format
				mov.s       $f1,        $f0 					# result  A*C saved in $f1 

        l.s     		$f12,     	A
        l.s     		$f13,     	B
        jal     		mul.php           				# result  A*B saved in $f0 in PHP format

        mov.s   		$f12,     	$f0   				# put (A*B) in $f12 in PHP format
        mov.s   		$f13,     	$f1   				# put (A*C) in $f13 in PHP format
        jal     		add.php           				# sum saved in $f0 in PHP format

        mov.s   		$f12,     	$f0   				# move sum to $f12 
        li      		$v0,      	2     				# print decimal value of sum (Answer: 32.0)
        syscall
        la      		$a0,    		newline
        li      		$v0,    		4
        syscall

        jal      		cvt.h.php      	 					#  PHP --> Half
        move  			$a0,      	$v0   				#  half-precision C in $a0
        li         	$v0,      	 34
        syscall                       				#  print half-precision encoding of C
																							#	 Answer: 0x00005000
EXIT:
        li         	$v0,      	 10
        syscall                       				#  exit
			

