# purpose:	test function mul.php for C=NaN*1.0 = NaN
#  input: 	A=NaN and B=1.0
#  output:  C = A*B = 	+NaN (encoding:   0x00007FFF)

.data
			A:				.word         0xFFFFFFFF
			B:				.float        1.0
		  newline:	.asciiz    		"\n"	
.text
			l.s     	$f12, 		A
			l.s     	$f13, 		B

			jal       	mul.php     			# C=A*B = NaN in PHP     
			mov.s     	$f12,     $f0

   	  jal       cvt.h.php  
			move   		$a0, 			$v0     # move C to $a0

			li        $v0,  		34
			syscall           					# print encoding of C (Answer: 0x00007E00  or any number between 0x00007C01 and 0x00007FFF, inclusively)
			                            

			la        $a0,  		newline
			li        $v0,  		4
			syscall           					# print  newline

			li        $v0,  		2
			syscall           					# print  C=A*B in PHP 	(Answer: +NaN )

EXIT:
			li        $v0,  		10
			syscall           					# exit
