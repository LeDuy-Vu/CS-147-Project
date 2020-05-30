#	 Purpose: test if function div.php can handle 0/0 and return NaN
#  input: 	dividend = 0  and divisor = 0
#  output:  encoding and value of NaN in Half precsion (0x00007FFF)

.data
			Z:				.float        0.0
		  newline:	.asciiz    		"\n"	
.text
			l.s     	$f12, 		Z
			l.s     	$f13, 		Z
			jal       div.php     			# C=0/0 = NaN in PHP       

			mov.s     $f12,     $f0     # f12 = NaN in PHP 

   	  jal       cvt.h.php  
			move   		$a0, 			$v0     # move C to $a0

			li        $v0,  		34
			syscall           					# print  encoding of NaN in half precision (Answer: 0x00007FFF)

			la        $a0,  		newline
			li        $v0,  		4
			syscall           					# print  newline

			li        $v0,  		2
			syscall           					# print  NaN in PHP 	(Answer: +NaN )

EXIT:
			li        $v0,  		10
			syscall           					# exit
