.text
.globl  mul.php
mul.php:
	# input: float  A and B in $f12, $f13
	# output: php C = A * B in $f0
	add $sp, $sp, -4
	sw $ra,	($sp)		# input A is in $f12 
	jal cvt.php.s		# Convert A to PHP
	mov.s $f2, $f0		# move A to $f2
	mov.s $f12, $f13	# move B to cvt.php.s input position
	jal cvt.php.s		# Convert B to PHP
	mul.s $f12, $f2, $f0	# C = A * B
	jal cvt.php.s		# convert C to PHP
	lw $ra,	($sp)
	add $sp, $sp, 4
	jr $ra