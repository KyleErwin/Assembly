segment .data
	val1:	db "", 0
	val2:	db "", 0
	;New line string
	newLine:    db "\n", 0x0a
segment .text
	global _start
	
_start:
	;read val1 in from the console
	mov		rax, 0
	mov		rdi, 0
	mov		rdx, 2
	mov		rsi, val1
	syscall
	
	;read val2 in from the console
	mov		rax, 0
	mov		rdi, 0
	mov		rdx, 2
	mov		rsi, val2
	syscall
	
	;output result back to the console
	mov		eax, 1
	mov		edi, 1
	mov		edx, 1
	mov		rsi, val2
	syscall
	
	;output new line to the console
	mov     eax, 1
    mov     edi, 1
    mov     edx, 1 ; The number of characters
    lea     rsi,[newLine]
    syscall
	
	;output result back to the console
	mov		eax, 1
	mov		edi, 1
	mov		edx, 1
	mov		rsi, val1
	syscall
	
	;output new line to the console
	mov     eax, 1
    mov     edi, 1
    mov     edx, 1 ; The number of characters
    lea     rsi,[newLine]
    syscall
	
	;exit the program
	mov		eax, 60
	xor		edi, edi
	syscall
