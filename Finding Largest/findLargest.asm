segment .data

segment .text
	global 		findLargest
	extern 		printf

	;An assembly function to 
	;	1. Accepts twenty integers.
	; 	2. Find and return the largest integer.
	;And is called by a c program 

findLargest:
	push 	rbp 	; Create stack frame
	mov 	rbp, rsp
	mov 	rax, [rbp + 16]

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;				FIND LARGEST		 		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;First we will look at the 6 default registers 
	;to find the largest amongst them.

	;1st parameter is our max value
	mov 	r15, rdi

	;Compare max value with 2nd parameter
	;We move the value to r15 if its bigger
	;cmovle = move if less than or equal to zero
	cmp 	r15, rsi
	cmovle 	r15, rsi 	

	;Compare max value with 3rd parameter
	cmp 	r15, rdx
	cmovle 	r15, rdx 

	;Compare max value with 4th parameter
	cmp 	r15, rcx
	cmovle 	r15, rcx 

	;Compare max value with 5th parameter
	cmp 	r15, r8
	cmovle 	r15, r8 

	;Compare max value with 6th parameter
	cmp 	r15, r9
	cmovle 	r15, r9 

	;Here we look at the remainder of the varaibles in the stack
	;The 7th parameter will be 16 bits offset of the base pointer 
	;As we increment the counter we'll increase the offset by 8 bits


	mov 	rcx, 2 	;Counter
	mov 	r8, 0
while:
	cmp 	rcx, 16
	jge 	return

	mov 	rax, [rbp + (8 * rcx)] 	;Offset 
	inc 	rcx

	cmp 	r15, rax 
	cmovle 	r15, rax 

	jmp 	while

return:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;					RETURN					;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov 	rax, r15
	leave
	ret