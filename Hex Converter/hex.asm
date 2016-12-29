segment .data
    input:      dq  0
    first:     dq  0
    second:        dq  0
    decimal:    dw  0
    quotient:   dw "", 0
    ;New line string
    newLine:    dw "\n", 0x0a
    
segment .text
    global _start
    
_start:
    ;read input in from the console
    mov     rax, 0
    mov     rdi, 0
    mov     rdx, 2
    mov     rsi, input
    syscall
    
    movzx rax, byte [input]
    cmp     rax, 'a'
    jl      isFirstDigit
    jge     isFirstCharacter
    
isFirstCharacter:
    sub rax, 'a'
    add rax, 10
    jmp addFirst

isFirstDigit:
    sub rax, '0'
    add rax, 0
    jmp addFirst

addFirst:
    mov rbx, 16
    imul rbx
    
    add [second], rax
    
    movzx rax, byte [input + 1]
    cmp     rax, 'a'
    jl      isSecondDigit
    jge     isSecondCharacter
    
isSecondCharacter:
    sub rax, 'a'
    add rax, 10
    jmp addSecond

isSecondDigit:
    sub rax, '0'
    add rax, 0
    jmp addSecond

addSecond:  
    add [first], rax

    mov rbx, [second]
    add rax, rbx
    mov [decimal], rax
    
    ;output the ASCII equivalent
    mov     rax, 1
    mov     rdi, 1
    mov     rdx, 1
    mov     rsi, decimal
    syscall
    
        ;output new line
    mov     r8, 0x0a
    mov     [newLine], r8
    mov     rax, 1
    mov     rdi, 1
    mov     rdx, 1
    mov     rsi, newLine
    syscall
    
    ;bitwise NOT operation to the input hex value.
    mov rax, [decimal]
    not al

    
    ;convert value1 to decimal
    mov     bl, 2
    
    ;do the calculation
    idiv    bl
    mov     [quotient], al
    
    ;output the ASCII equivalent
    mov     rax, 1
    mov     rdi, 1
    mov     rdx, 1
    mov     rsi, quotient
    syscall
    
    ;output new line
    mov     r8, 0x0a
    mov     [newLine], r8
    mov     rax, 1
    mov     rdi, 1
    mov     rdx, 1
    mov     rsi, newLine
    syscall

exit:
    ;exit the program
    mov     rax, 60
    xor     rdi, rdi
    syscall