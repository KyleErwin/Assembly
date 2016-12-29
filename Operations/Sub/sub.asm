segment .data
	value1:	db "", 0
	value2:	db "", 0
	diff:	db "", 0
	
segment .bss
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
	mov		rax, [value1]
	sub		rax, "0"
	
	;convert value2 to decimal
	mov		rbx, [value2]
	sub		rbx, "0"
	
	;subtract value1 from value2
	sub		rbx, rax
	
	;convet back to ascii
	add		rbx, "0"
	mov		[diff], rbx
	
	;output result back to the console
	mov		rax, 1
	mov		rdi, 1
	mov		rdx, 1
	mov		rsi, diff
	syscall
	
	;output new line
	mov		rdx, 2
	lea		rsi, [newLine]
	syscall
	
	;exit the program
	mov		rax, 60
	xor		rdi, rdi
	syscall
