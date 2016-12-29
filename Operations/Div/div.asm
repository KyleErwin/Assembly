segment .data
	value1:	dw "", 0
	value2:	dw "", 0
	quotient:	dw "", 0
	
	;New line string
	newLine:    db 0x0a
	
segment .text
	global _start
	
_start:
	;Get value1
	mov		rax, 0
	mov		rdi, 0
	mov		rdx, 2
	mov		rsi, value1
	syscall
	
	;Get value2 
	mov		rax, 0
	mov		rdi, 0
	mov		rdx, 2
	mov		rsi, value2
	syscall
	
	;convert value1 to decimal
	mov		bl, [value1]
	sub		bl, "0"
	mov		[value1], bl
	
	;convert value2 to decimal
	mov		al, [value2] ;the dividend
	sub		al, "0"
	mov		[value2], al
	
	;do the calculation
	mov		rdx, 0
	idiv	bl
	add		al, "0"
	mov		[quotient], al
	
	;output result back to the console
	mov		rax, 1
	mov		rdi, 1
	mov		rdx, 1
	mov		rsi, quotient
	syscall
	
	;output new line
	mov		rdx, 2
mov		rsi, newLine
	syscall
	
	
	;exit the program
	mov		rax, 60
	xor		rdi, rdi
	syscall