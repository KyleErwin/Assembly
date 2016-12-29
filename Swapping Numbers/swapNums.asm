segment .data
	fmt db "The correct order is %.2f, %.2f, %.2f", 0xa, 0
segment .text
	global 		swapNums
	extern 		printf

	;An assembly function to 
	;	1. Accept references to 3 foating point inputs.
	;	2. The method must rearrange the numbers from smallest to largest.
	;And is called by a c program 

swapNums:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;		 		GET PARAMETERS 			 	;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	push 	rbp
	movss 	xmm0, [rdi]
	movss 	xmm1, [rsi]
	movss 	xmm2, [rdx]

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;					SORT		 	 		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;We need to do four comparisons, we'll compare the 1st 
	;number in our list with the 2nd. Swap if necessary. Compare 2nd
	;with 3rd. Swap if necessary. Compare 1st with 3rd. 
	;Swap if necessary. And lastly compare the 1st and 2nd once more

compareFirstAndSecond:
	ucomisd 	xmm0, xmm1
	ja 	swapFirstAndSecond
	jb 	compareSecondAndThird

swapFirstAndSecond:
	movsd 	xmm15, xmm0
	movsd 	xmm0, xmm1
	movsd 	xmm1, xmm15

compareSecondAndThird:
	ucomisd 	xmm1, xmm2
	ja 	swapSecondAndThird
	jb 	compareFirstAndThird

swapSecondAndThird:
	movsd 	xmm15, xmm1
	movsd 	xmm1, xmm2
	movsd 	xmm2, xmm15

compareFirstAndThird:
	ucomisd 	xmm0, xmm2
	ja 	swapFirstAndThird
	jb 	compareFirstAndSecond2

swapFirstAndThird:
	movsd 	xmm15, xmm0
	movsd 	xmm0, xmm2
	movsd 	xmm2, xmm15

compareFirstAndSecond2:
	ucomisd 	xmm0, xmm1
	ja 	swapFirstAndSecond2
	jb 	return

swapFirstAndSecond2:
	movsd 	xmm15, xmm0
	movsd 	xmm0, xmm1
	movsd 	xmm1, xmm15

return:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;					RETURN					;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	movss 	[rdi], xmm0
	movss 	[rsi], xmm1
	movss 	[rdx], xmm2
	pop 	rbp
	ret