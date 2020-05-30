.data
	POS_INF:	.word 0x7F800000	# positive infinity for half precision
	SMALLEST:	.word 0x38800000	# smallest positive normal half precision number (2^-14)
						# in single precision form

.text
.globl cvt.h.php

# Convert to half precision from php
# Input: a php number in $f12
# Output: a true half precision number in $v0
cvt.h.php:
	mfc1 $t0, $f12			# copy php to t0
	lw $t6, POS_INF			# load positive infinity to t6, used to isolate exponent
	move $t7, $0			# make t7 all 0, t7 contains the converted half precision
	
	# paste sign bit
	srl $t1, $t0, 31		# isolate sign bit, paste to t1
	sll $t1, $t1, 15		# move sign bit to proper position for half precision
	or $t7, $t7, $t1		# paste sign bit into t7
	
	and $t1, $t0, $t6		# isolate exponent
	beq $t1, $t6, Special_Numbers	# if exponent is all 1, then it is infinity or NaN
	
	beq $t1, $0, Fraction		# if exponent = 0, handle fraction next
	
	abs.s $f12, $f12		# get absolute value of php
	l.s $f1, SMALLEST		# load SMALLEST into f1
	c.lt.s $f12, $f1		# compare php and smallest positive normal half precision
	bc1f Normal_Numbers		# if php is bigger than the limit, treat it as normal number
	
	move $v0, $t7			# otherwise, exponent and fraction bits of half precision are all 0
	jr $ra
	
Special_Numbers:			# handle infinity and NaN
	ori $t7, $t7, 0x00007C00	# paste max sign bits into half precision
	j Fraction			# jump to fraction part
	
Normal_Numbers:				# handle exponent part of normal numbers
	sll $t1, $t0, 1			# clear sign bit
	srl $t1, $t1, 24		# clear fraction bits
	subi $t1, $t1, 127		# minus biased exponent of single precision
	addi $t1, $t1, 15		# plus biased exponent of half precision
	sll $t1, $t1, 10		# move exponent bits to proper position for half precision
	or $t7, $t7, $t1		# paste exponent bits into t7

Fraction:				# paste fraction bits into half precision
	sll $t0, $t0, 9			# clear sign and exponent bits of php
	srl $t0, $t0, 22		# move fraction bits to proper position for half precision (last 10 bits)
	or $v0, $t7, $t0		# paste fraction bits and paste final result into v0
	jr $ra
