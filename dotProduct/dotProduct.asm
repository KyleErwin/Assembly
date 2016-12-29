segment .data
	fmt db "The dot product of (%.2f,%.2f) and (%.2f,%.2f) is: (%.2f)", 0xa, 0

segment .text
	global 		dotProduct
	extern 		printf

	;An assembly function to 
	;	1. Accepts 6 oating point inputs (X1,X2,Xnorm,Y1,Y2,Ynorm)
	;	2. Normalize these inputs by dividing each coordinate with the vector's norm.
	;	3. Calculate and display the dot product of the two normalised vectors.
	;And is called by a c program 

dotProduct:
	push rbp
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;		MAKE IT TWO DECIMEL PLACES		 	;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	movss 		xmm15, xmm0
	cvtss2sd	xmm0, xmm15
	movss 		xmm15, xmm1
	cvtss2sd	xmm1, xmm15
	movss 		xmm15, xmm2
	cvtss2sd	xmm2, xmm15
	movss 		xmm15, xmm3
	cvtss2sd	xmm3, xmm15
	movss 		xmm15, xmm4
	cvtss2sd	xmm4, xmm15
	movss 		xmm15, xmm5
	cvtss2sd	xmm5, xmm15

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;		STORE THE INPUTS FOR LATER 			;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	movsd 	xmm10, xmm0		;X1 parameter is xmm0
	movsd 	xmm11, xmm1 	;X2 parameter is xmm1
	movsd 	xmm12, xmm2 	;Xnorm parameter is xmm2

	movsd 	xmm13, xmm3 	;Y1 parameter is xmm3
	movsd 	xmm14, xmm4 	;Y2 parameter is xmm4
	movsd 	xmm15, xmm5 	;Ynorm parameter is xmm5

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;			NORMALIZE THE INPUTS 	 		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;We're going to normalise the X1 and X2 varaibles by dividing them by Xnorm
	divsd 	xmm0, xmm2
	divsd 	xmm1, xmm2

	;Same thing with the Y inputs
	divsd 	xmm3, xmm5
	divsd 	xmm4, xmm5

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;			CALCULATE DOT PRODUCT 	 		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;X1 * Y1 stored in xmm0
	mulsd 	xmm0, xmm3	

	;X2 * Y2 stored in xmm1
	mulsd 	xmm1, xmm4

	;Add the two, stored in xmm0
	addsd 	xmm0, xmm1

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;			CALL PRINTF WITH RESULT  		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Store the result, overwrite Ynorm since we don't need it
	movsd 	xmm15, xmm0

	;Move the format of the output
	mov 	rdi, fmt
	mov 	rax, 5

	;"The dot product of (X1,X2)
	movsd 	xmm0, xmm10
	movsd 	xmm1, xmm11

	;and (Y1,Y2)
	movsd 	xmm2, xmm13
	movsd 	xmm3, xmm14

	;is: (result)".
	movsd 	xmm4, xmm15

	call 	printf
	pop 	rbp
	mov 	rax, 1
	ret