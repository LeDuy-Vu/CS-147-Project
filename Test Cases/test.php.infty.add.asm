#  Purpose: Test add.php for the case of larest_PHP + 1 
#  input: 	A = largest_PHP, B = 1
#  output:  C = A+B = infinity in PHP (0x00007c00)

.data
     	A:        .float   			65504
			B:				.float        1.0
		  newline:	.asciiz    		"\n"	
.text
			l.s     	$f12, 		A
			l.s     	$f13, 		B
			jal       add.php     			# C=A+B = infty     

			mov.s     $f12,     $f0

   	  jal       cvt.h.php  
			move   		$a0, 			$v0     # move C to $a0

			li        $v0,  		34
			syscall           					# print  encoding (Answer: 0x00007C00)

			la        $a0,  		newline
			li        $v0,  		4
			syscall           					# print  newline

			li        $v0,  		2
			syscall           					# print  float 	(Answer: +Infinity)

EXIT:
			li        $v0,  		10
			syscall           					# exit
