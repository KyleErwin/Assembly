segment .data
	value1:		db "", 0
	value2:		db "", 0
	product:	dq "", 0
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
	
	mov 	rax, [value2]
	sub 	rax, "0"
	mov 	[value2], rax
	mov 	rbx, [value1]
	sub 	rbx, "0"
	
	;multiplies value1 by value2
	mul		rbx
	
	;add 3
	add		rax, 3
	
	;convet back to ascii
	add		rax, "0"
	mov		[product], rax
	
	
	;output result back to the console
	mov		rax, 1
	mov		rdi, 1
	mov		rdx, 1
	mov		rsi, product
	syscall
	
	;output new line
	mov		rdx, 2
	mov		rsi, newLine
	syscall
	

	;exit the program
	mov		rax, 60
	xor		rdi, rdi
	syscall
