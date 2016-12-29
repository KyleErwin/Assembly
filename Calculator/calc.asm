segment .data
	inputFirst8:	dq "", 0
	inputLast8:	    dq "", 0

	firstNumber:	dq "", 0
	secondNumber:	dq "", 0

	operator:	    dq "", 0

	result:         dq "", 0
	remainder:      dq "", 0

	sign:         	dq "", 0

	outputTemp:	    dq "", 0
	output:	        dq "", 0
	output2:        dq "", 0

	ERROR:          db "ERROR"

segment .bss
	;New line string
	newLine:    db 0x0a
    remainderOutput  resb 32     ;Array to output remainder from
	
segment .text
	global _start
	
	;An assembly calculator to accept two six digit 
	;numbers seperated by the operator function
	;
	;[6 digit operand][space][operation][space][6 digit operand][space][newline]

_start:
	;Initialise varaibles for future use
	mov 	rax, 0
	mov 	[firstNumber], rax
	mov 	[secondNumber], rax

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;					INPUT 	 		   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;Get inputFirst8
	mov		rax, 0
	mov		rdi, 0
	mov		rdx, 17
	mov		rsi, inputFirst8
	syscall

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;				FIRST NUMBER 		   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;Here we will get the number
	;We set r9 to be our counter for our loop
	mov 	r9, 0

whileFirstNumber:
	cmp		r9, 6
	jge		endWhileFirstNumber

	;Get each number byte by byte 
	movzx 	rax, byte [inputFirst8 + r9]
	mov 	r10, rax

	;output result back to the console
	;mov 	[outputTemp], rax
	;mov		rax, 1
	;mov		rdi, 1
	;mov		rdx, 2
	;mov		rsi, outputTemp
	;syscall

	;Convert the ascii byte to decimal
	mov 	rax, r10
	sub 	rax, '0'
	add		rax, 0

	;Multiply by 10 x number of times to get the correct value 
	;we'll set r8 as our counter for this innner loop
	;we set r8 to r9 and we will increment our way up to 5
	;this will give us the correct value.
	cmp 	rax, 0
	jz		endConvertFirstNumber

	mov 	r8, r9
	mov 	r10, 5
convertFirstNumber:
	cmp		r10, r8
	jle		endConvertFirstNumber

	mov 	rbx, 10
	mul 	rbx

	inc 	r8
	jmp 	convertFirstNumber
endConvertFirstNumber:

	add 	[firstNumber],rax

	inc		r9
	jmp 	whileFirstNumber

endWhileFirstNumber:

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;				GET OPERATOR 		   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;Here we will get the the operator	
	;Increment r9 to ignore the space
	inc 	r9	
	movzx 	rax, byte [inputFirst8 + r9]
	mov 	[operator], rax
	;output the operator to the console
	;mov 	[outputTemp], rax
	;mov		rax, 1
	;mov		rdi, 1
	;mov		rdx, 2
	;mov		rsi, outputTemp
	;syscall

	;Time to get the second number
	;we inc r9 as opposed to setting it to 0 because 
	;we need to ignore the space after the operator and
	;if we set it to zero we would just be getting the first number
	

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;				SECOND NUMBER 		   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	inc 	r9
	inc 	r9

whileSecondNumber:
	cmp		r9, 15
	jge		endWhileSecondNumber

	;Get each number byte by byte 
	movzx 	rax, byte [inputFirst8 + r9]
	mov 	r10, rax

	;output result back to the console
	;mov 	[outputTemp], rax
	;mov		rax, 1
	;mov		rdi, 1
	;mov		rdx, 2
	;mov		rsi, outputTemp
	;syscall

	;Convert the ascii byte to decimal
	mov 	rax, r10
	sub 	rax, '0'
	add		rax, 0

	;Multiply by 10 x number of times to get the correct value 
	;we'll set r8 as our counter for this innner loop
	;we set r8 to r9 and we will increment our way up to 16
	;this will give us the correct value.

	cmp 	rax, 0
	jz		endConvertSecondNumber

	mov 	r8, r9
	mov 	r10, 14
convertSecondNumber:
	cmp		r10, r8
	jle		endConvertSecondNumber 	

	mov 	rbx, 10
	mul 	rbx

	inc 	r8
	jmp 	convertSecondNumber
endConvertSecondNumber:

	add 	[secondNumber],rax

	inc		r9
	jmp 	whileSecondNumber

endWhileSecondNumber:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;			CHECK WHICH OPERATION 			;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov 	rax, [operator]

	;Is it add?
	cmp 	rax, 43
	jz 		addOperation 

	;Is it minus?
	cmp 	rax, 45
	jz 		minusOperation 

	;Is it multiply?
	cmp 	rax, 42
	jz 		multiplyOperation 

	;Is it divide?
	cmp 	rax, 47
	jz 		divideOperation 	

	Jmp 	error

addOperation:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;					ADD 			   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov 	rax, 0
	mov 	[result], rax

	mov 	rax, [firstNumber]
	add 	[result], rax

	mov 	rax, [secondNumber]	
	add 	[result], rax
	
	jmp 	outputSign

minusOperation:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;				MINUS 			   			;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov 	rax, 0
	mov 	[result], rax

	mov 	rax, [secondNumber]
	mov 	rbx, [firstNumber]

	sub 	rbx, rax

	mov 	[result], rbx

	jmp 	outputSign

multiplyOperation:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;				MULTIPLY 			   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov 	rax, 0
	mov 	[result], rax

	mov 	rax, [firstNumber]
	mov 	rbx, [secondNumber]	

	mul 	rbx

	add 	[result], rax
	
	jmp 	outputSign

divideOperation:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;				DIVIDE 	 			   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov 	rax, 0
	mov 	[result], rax

	mov 	rax, [firstNumber]
	mov 	rbx, [secondNumber]	

	mov		rdx, 0
	div 	rbx 

	add 	[result], rax
	mov 	[remainder], rdx
	
	jmp 	outputSign

outputSign:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;				OUTPUT SIGN 		   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov 	rax, [result]
	cmp 	rax, 0         

	;Jump to the + output if the sign flag is not set
	jge 	outputPlus

	;Output -
outputMinus:
	mov     r8, 45
    mov     [sign], r8
    mov     rax, 1
    mov     rdi, 1
    mov     rdx, 1
    mov     rsi, sign
    syscall
    jmp 	convertTOOutput
    ;Output +
outputPlus:
    mov     r8, 43
    mov     [sign], r8
    mov     rax, 1
    mov     rdi, 1
    mov     rdx, 1
    mov     rsi, sign
    syscall


convertTOOutput:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;			CONVERT TO OUTPUT		   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	mov 	rax, [result]

	;If thee result is negative we make it positve because a negative 
	;number would cause overflow and give us the inncorrect output
	cmp		rax, 0
	jge 	positeNumber
	neg 	rax

positeNumber:
	;Set r9 as our counter
	mov 	r9, 0
whileConvertTOOutput:
	cmp 	r9, 12
	jge 	endWhileConvertTOOutput

	;get the mudula 10
	mov		rdx, 0
	mov 	rbx, 10
	div 	rbx       ; Divides rax by rbx. DX = remainder and AX = quotaint

	;convet back to ascii
	add		dx, '0'

	mov 	[output + r9], dx

	inc 	r9
	jmp 	whileConvertTOOutput
endWhileConvertTOOutput:

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;			OUTPUT THE RESULT 		   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Set r9 as our counter
    mov 	r9, 11

whileOutput:
	cmp		r9, 0
	jl		endWhileOutput

	;Get each number byte by byte 
	movzx 	rax, byte [output + r9]
	mov 	r10, rax

	;output result back to the console
	mov 	[outputTemp], rax
	mov		rax, 1
	mov		rdi, 1
	mov		rdx, 2
	mov		rsi, outputTemp
	syscall

	dec		r9
	jmp 	whileOutput
endWhileOutput:

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;			OUTPUT THE " r "		   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;output " r " to the console
	mov 	rax, [operator]
	cmp 	rax, 47
	jnz		finish

	mov 	rax, " r "
	mov 	[outputTemp], rax

	mov		rax, 1
	mov		rdi, 1
	mov		rdx, 2
	mov		rsi, outputTemp
	syscall

	mov 	rax, " "
	mov 	[outputTemp], rax

	mov		rax, 1
	mov		rdi, 1
	mov		rdx, 2
	mov		rsi, outputTemp
	syscall

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;	CONVERT THE REMAINDER TO OUPUT	   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov 	rax, [remainder]            
    mov 	r9, 10                     
    mov 	r8, 0                     
    
convertRemainderTOOutput:
    xor 	rdx, rdx
    div 	r9

    add 	rdx, '0'
    mov 	[remainderOutput + r8], rdx
    
    cmp 	rax, 0                      
    je		outputRemainder
    
    inc 	r8
    jmp 	convertRemainderTOOutput

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;			OUTPUT THE REMAINDER	   		;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
outputRemainder:
    cmp 	r8, 0                  
    jl 		finish
    
    mov 	rax, [remainderOutput + r8] 
    mov 	[outputTemp], rax
    mov 	rax, 1
    mov 	rdi, 1
    mov 	rsi, outputTemp
    mov 	rdx, 1
    syscall

    dec 	r8
    jmp 	outputRemainder
error:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;					ERROR		   			;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov 	rax, 1
    mov 	rdi, 1
    mov 	rdx, 5
    mov 	rsi, ERROR
    syscall

finish:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;				NEW LINE		   			;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;output new line
    mov     r8, 0x0a
    mov     [newLine], r8
    mov     rax, 1
    mov     rdi, 1
    mov     rdx, 1
    mov     rsi, newLine
    syscall
	
	;exit the program
	mov		rax, 60
	xor		rdi, rdi
	syscall
