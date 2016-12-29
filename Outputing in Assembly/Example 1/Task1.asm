segment .data
	input:	db "", 0x0a
	;New line string
	newLine:    db "\n", 0x0a
	
segment .text
	global _start
	
_start:
	;read input in from the console
	mov		eax, 0
	mov		edi, 0
	mov		edx, 12 ; The number of characters
	mov		rsi, input
	syscall
	
	;output result back to the console
	mov		eax, 1
	mov		edi, 1
	mov		edx, 12
	mov		rsi, input
	syscall
	
	;output new line to the console
	mov     eax, 1
    mov     edi, 1
    mov     edx, 0 ; The number of characters
    lea     rsi,[newLine]
    syscall
	
	;exit the program
	mov		eax, 60
	xor		edi, edi
	syscall
