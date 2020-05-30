#	 Purpose: Test div.php for the case of 1/0 = infinity 
#  input: 	A=1, B=0 
#  output:  C=A/B = infinity (encoding 0x00007c00)

.data
     	A:        .float   			1
			B:				.float        0.0
		  newline:	.asciiz    		"\n"	
.text
			l.s     	$f12, 				A
			l.s     	$f13, 				B
			jal       div.php     			# C=A/B = infinity     

			mov.s     $f12,     		$f0

   	  jal       cvt.h.php  
			move   		$a0, 					$v0     # move C to $a0

			li        $v0,  				34
			syscall           					# print  encoding (Answer: 0x00007C00)

			la        $a0,  				newline
			li        $v0,  				4
			syscall           					# print  newline

			li        $v0,  		2
			syscall           					# print  float 	(Answer: +Infinity)

EXIT:
			li        $v0,  		10
			syscall           					# exit
