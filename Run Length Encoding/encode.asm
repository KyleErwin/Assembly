segment .data
	output:			dq "%c%i", 0
	new_line		db 0x0a, 0
	fuck: 			dq "fuuuuck", 0
	
	extern printf
segment .text
	global encode

encode:
	;An assembly function to 
	;	1. Accepts a string of length 15
	;	2. Encodes the String using Run Length Encoding;
	;	3. Outputs the encoded String to the terminal;
	;And is called by a c program 
	
	push rbp
	;This is our first character that we will use
	
	mov 	r15, rdi ;Our input
	mov 	r14, [r15] ;Our oletter that we will compare first with 
	
	mov 	r8, 0 ;Our character counter
	mov 	r9, 0 ;Our loop counter 


while:
	mov 	r13, [r15 + r8] ;This is our current character
	cmp 	r13b, 0x00
	je 		endWhile
	inc 	r8

	
	;Check if our character is repeated
	;If so we'll increment the character counter
	;If not we save the number and reset it
	cmp 	r14b, r13b
	jnz 	newCharacter
	inc 	r9 	
	jmp 	while	

newCharacter:
	mov 	rdi, output
	mov 	rsi, r14
	mov 	rdx, r9
	mov 	rax, 2
	call	printf

	mov 	r14, r13;New previous character
	mov 	r9, 1 ;Reset the character count
	
	jmp 	while	

endWhile:
	;get the last character
	mov 	rdi, output
	mov 	rsi, r14
	mov 	rdx, r9
	mov 	rax, 2
	call	printf

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;			PRINT NEW LINE			   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rdi, new_line
	call printf

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;					EXIT			   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;exit the program
	xor 	eax, eax
	pop 	rbp
	ret
	