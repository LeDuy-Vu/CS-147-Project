.data
	LARGEST:	.float 65504		# largest half precision
	POS_INF:	.word 0x7F800000	# positive infinity for half precision
	SMALLEST:	.float -65504		# smallest half precision
	NEG_INF:	.word 0xFF800000	# negative infinity for half precision
	POS_DENORM:	.word 0x33800000	# smallest positive normal half precision

.text
.globl cvt.php.s

# Convert to php from single
# Input: single precision number in $f12
# Output: php number in $f0
cvt.php.s:
	# check for 0
	l.s $f4, POS_DENORM		# load smallest positive normal half precision into f4
	abs.s $f3, $f12			# get absolute value of single precision
	c.lt.s $f3, $f4			# compare single precision and smallest positive normal half precision
	bc1t Zero			# if single precision is smaller than the limit, treat it as 0
	
	# check for special numbers
	mfc1 $t0, $f12			# copy php to t0
	lw $t1, POS_INF			# load positive infinity for half precision into t1
	and $t2, $t0, $t1		# clear sign and fraction bits
	beq $t1, $t2, Special_Numbers	# if sign is all 1, treat it as special number (infinity or NaN)
	
	# check for positive infinity
	l.s $f4, LARGEST		# load largest half precision into f4
	c.le.s $f12, $f4		# compare single precision and largest half precision
	bc1f Positive_Infinity		# if single precision is larger than the limit, treat it as positive infinity
	
	# check for negative infinity
	l.s $f4, SMALLEST		# load smallest half precision into f4
	c.lt.s $f12, $f4		# compare single precision and smallest half precision
	bc1t Negative_Infinity		# if single precision is smaller than the limit, treat it as negative infinity
	
	# start rounding procedure
	andi $t1, $t0, 0x00001FFF	# save extra bits for rounding (lower 13 bits), clear out all other bits
	li $t2, 0x00001000		
	beq $t1, $t2, Check_Round	# if rounding bits are 1000000000000, need further checking
	
	andi $t1, $t1, 0x00001800	# save first 2 rounding bits, clear out other bits
	beq $t1, $0, Round_Down		# if first 2 rounding bits are 00, round down
	li $t2, 0x00000800
	beq $t1, $t2, Round_Down	# if first 2 rounding bits are 01, round down
	j Round_Up			# other cases, round up

Zero:
	mtc1 $0, $f0			# output is 0
	jr $ra
	
Special_Numbers:			# handle infinity and NaN
	mov.s $f0, $f12			# output is the same as input
	jr $ra

Positive_Infinity:
	l.s $f0, POS_INF		# output is positive infinity
	jr $ra
	
Negative_Infinity:
	l.s $f0, NEG_INF		# output is negative infinity
	jr $ra
	
Check_Round:
	li $t1, 0x00002000
	and $t2, $t0, $t1		# isolate last fraction bit
	beq $t1, $t2, Round_Up		# if last fraction bit is 1, round up
					# otherwise, no rounding (round down)

Round_Down:
	andi $t0, $t0, 0xFFFFE000	# clear lower 13 rounding bits
	mtc1 $t0, $f0			# save output to f0
	jr $ra
	
Round_Up:
	andi $t0, $t0, 0xFFFFE000	# clear lower 13 rounding bits
	addi $t0, $t0, 0x00002000	# round up by plus 1 to last fraction bit
	mtc1 $t0, $f0			# save output to f0
	jr $ra
