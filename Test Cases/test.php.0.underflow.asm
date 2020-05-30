# Purpose:  Test function cvt.php.s for converting very small single precision numbers
# Input: 		A single precison  number < smallest positive PHP number 	
# Output:   The converted PHP 		(0) (Encoding: 0x00000000)
#
.data

			underflow:			.word     	0x33000000     # 2^-25 # 2.9802322E-8
		  newline:				.asciiz    	"\n"	
.text
			l.s     	$f12, 		underflow
      jal				cvt.php.s       	#  convert A to PHP

			mov.s     $f12,     $f0
   	  jal       cvt.h.php  

			move   		$a0, 			$v0     # move A to $a0
			li        $v0,  		34
			syscall           					# print  encoding  (Answer: 0x00000000)

			la        $a0,  		newline
			li        $v0,  		4
			syscall           					# print  newline

			li        $v0,  		2
			syscall           					# print  float 		(Answer: 0.0)

EXIT:
			li        $v0,  		10
			syscall           					# exit
