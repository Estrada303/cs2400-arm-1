		;		ARM Programming Assignment #1: 16 bit multiplier
		;
		;		Write a 16-bit multiplier, meaning numbers that have their high 16 bits set to 0.
		;		Use the standard shift-and-add operation.
		;		Note that we cannot address half-words here. We can only address words and bytes (B).
		;		Use the two numbers as an example but write it so it works for any two 16-bit numbers.
		;		Write the result in the provided "fill" word.
		;		Indicate if there was a high-bit carry using the provided "fill" word.
		
		;		Your code here
		
numbers	DCD		0b1100101010010001, 0b1111010101000011
result	FILL		4
carry	FILL		4
main
		mov		r0, #0		;counter will go to 16
		adr		r1, numbers	;get address for numbers into r1
		ldr		r2, [r1], #4	;get first value
		ldr		r3, [r1]		;get second value
		mov		r4, #1		;move 1 into r4, r4 to be used as mask
loop		and		r5, r3, r4	;and the mask and value in r3
		mov		r6, #0		;move 0 to r6
		cmp		r5, r6		;compare aganst the result of the and operation
		addgt	r7, r7, r2	;if the compare was greater the zero add r7 and r2
		lsl		r4, r4, #1	;shift the mask bits to the left one
		lsl		r2, r2, #1	;shift r2 bits to left
		mov		r8, #1		;move 1 into r8
		add		r0, r0, r8	;increment counter
		mov		r8, #16		;move max amount of times nedded for loop to iterate
		cmp		r0, r8		;compare to see if counter has reached 16
		blt		loop 		;branch back to loop
		mov		r2, #255		;next 2 lines create a mask to save lower bits
		lsl		r2, r2, #8
		add		r2, r2, #255
		and		r6, r7, r2	;r6 will hold lowere 16 bits
		lsl		r2, r2, #16	;shift masks to left for high carry bits
		and		r5, r7, r2	;r5 will carry all high bits 16-31
		lsr		r5, r5, #16	;rotate 0s in lowere bits
		adr		r1, result	;get the address for result in r1
		str		r6, [r1] 	     ;store result into memory
		adr		r1, carry		;get address for carry loaded
		str		r5, [r1]		;store high end carry bits
		end
