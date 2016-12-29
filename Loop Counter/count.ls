     1                                 %line 1+1 count.asm
     2                                 [segment .data]
     3 00000000 00                      input: db 0
     4                                 
     5                                 
     6 00000001 5C6E0A                  newLine: db "\n", 0x0a
     7                                 
     8                                 [segment .text]
     9                                 [global _start]
    10                                 
    11                                 _start:
    12                                 
    13 00000000 48C7C000000000          mov rax, 0
    14 00000007 48C7C700000000          mov rdi, 0
    15 0000000E 48C7C202000000          mov rdx, 2
    16 00000015 48C7C6[00000000]        mov rsi, input
    17 0000001C 0F05                    syscall
    18                                 
    19                                 
    20 0000001E 48C7C301000000          mov rbx, 1
    21                                 
    22                                 
    23                                 while:
    24 00000025 4883FB0C                cmp rbx, 12
    25 00000029 7F52                    jg end_while
    26 0000002B 48FFC3                  inc rbx
    27                                 
    28                                 
    29 0000002E 48C7C001000000          mov rax, 1
    30 00000035 48C7C701000000          mov rdi, 1
    31 0000003C 48C7C201000000          mov rdx, 1
    32 00000043 48C7C6[00000000]        mov rsi, input
    33 0000004A 0F05                    syscall
    34                                 
    35 0000004C 480FB60425[00000000]      movzx rax, byte [input]
    36 00000055 4883F87A                cmp rax, 'z'
    37 00000059 7422                    je end_while
    38 0000005B 4883F839                cmp rax, '9'
    39 0000005F 7400                    je becomeCharacter
    40 00000061 750C                    jne increment
    41                                 
    42                                 becomeCharacter:
    43 00000063 4883C028                add rax, 40
    44 00000067 48890425[00000000]      mov [input], rax
    45 0000006F EBB2                    jmp while
    46                                 
    47                                 increment:
    48                                 
    49 00000071 4883C001                add rax, 1
    50                                 
    51                                 
    52 00000075 48890425[00000000]      mov [input], rax
    53                                 
    54                                 
    55 0000007D EBA4                    jmp while
    56                                 
    57                                 end_while:
    58                                 
    59                                 
    60 0000007F 49C7C00A000000          mov r8, 0x0a
    61 00000086 4C890425[00000000]      mov [newLine], r8
    62 0000008E 48C7C001000000          mov rax, 1
    63 00000095 48C7C701000000          mov rdi, 1
    64 0000009C 48C7C201000000          mov rdx, 1
    65 000000A3 48C7C6[00000000]        mov rsi, newLine
    66 000000AA 0F05                    syscall
    67                                 
    68                                 
    69 000000AC 48C7C03C000000          mov rax, 60
    70 000000B3 4831FF                  xor rdi, rdi
    71 000000B6 0F05                    syscall
