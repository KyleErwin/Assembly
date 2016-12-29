segment .text
	global 		pseudoRC

pseudoRC:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;		SOMETHING TO DUE WITH THE STACK 	;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	push 	rbp
	mov		rbp, rsp
	sub 	rsp, 32
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;		GET THE GIVEN PARAMETER VARAIBLES 	;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	firstNumber	 	equ 0
	secondNumber 	equ 8
	thirdNumber 	equ 16

	;Save firstNumber parameter
	mov 	[rsp + firstNumber], rdi

	;Save secondNumber parameter
	mov 	[rsp + secondNumber], rsi

	;Save thirdNumber parameter
	mov 	[rsp + thirdNumber], rdx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;				DIVIDE 	 			   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov 	rax, [rsp + firstNumber]
	mov 	rbx, [rsp + secondNumber]	

	mov		rdx, 0
	div 	rbx 

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;	COMPARE REMAINDER TO THIRD NUMBER  		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Remainder is still stored in rdx 
	mov 	rbx, [rsp + thirdNumber]	

	cmp 	rdx, rbx
	jz		returnOne

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;				RETURN ZERO 		   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	xor 	eax, eax ; to return 0
	leave
	ret

returnOne:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;				RETURN ONE 			   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov 	eax, 1
	leave
	ret