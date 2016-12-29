segment .data
	input:	db 0

	;New line string
	newLine:    db "\n", 0x0a
	
segment .text
	global _start
	
_start:
	;Get input
	mov		rax, 0
	mov		rdi, 0
	mov		rdx, 2
	mov		rsi, input
	syscall

	;use rcx as the counter. We set it do 0
	mov     rbx, 1
	
	;start of the while loop
while:
    cmp 	rbx, 12
	jg      end_while
	inc 	rbx		;increase the counter
	
	;output the digit
	mov		rax, 1
	mov		rdi, 1
	mov		rdx, 1
	mov		rsi, input
	syscall
	
	movzx rax, byte [input]
	cmp		rax, 'z'
	je		end_while
	cmp		rax, '9'
	je		becomeCharacter
	jne		increment
	
becomeCharacter:
	add		rax, 40
	mov		[input], rax
	jmp		while

increment:
    ;increase the input to the next consecutive value
    add     rax, 1
    
    ;update the varaible
	mov		[input], rax
	
    ;increase the input to the next consecutive value
	jmp     while

end_while:
	
	;output new line
	mov 	r8, 0x0a
	mov 	[newLine], r8
	mov		rax, 1
	mov		rdi, 1
	mov		rdx, 1
	mov		rsi, newLine
	syscall
	
	;exit the program
	mov		rax, 60
	xor		rdi, rdi
	syscall
