     1                                 %line 1+1 calc.asm
     2                                 [segment .data]
     3 00000000 0000000000000000        inputFirst8: dq "", 0
     4 00000008 0000000000000000        inputLast8: dq "", 0
     5                                 
     6 00000010 0000000000000000        firstNumber: dq "", 0
     7 00000018 0000000000000000        secondNumber: dq "", 0
     8                                 
     9 00000020 0000000000000000        operator: dq "", 0
    10                                 
    11 00000028 0000000000000000        result: dq "", 0
    12 00000030 0000000000000000        remainder: dq "", 0
    13                                 
    14 00000038 0000000000000000        sign: dq "", 0
    15                                 
    16 00000040 0000000000000000        outputTemp: dq "", 0
    17 00000048 0000000000000000        output: dq "", 0
    18 00000050 0000000000000000        output2: dq "", 0
    19                                 
    20 00000058 4552524F52              ERROR: db "ERROR"
    21                                 
    22                                 [segment .bss]
    23                                 
    24 00000000 0A                      newLine: db 0x0a
    25 00000001 <gap>                   remainderOutput resb 32
    26                                 
    27                                 [segment .text]
    28                                 [global _start]
    29                                 
    30                                 
    31                                 
    32                                 
    33                                 
    34                                 
    35                                 _start:
    36                                 
    37 00000000 48C7C000000000          mov rax, 0
    38 00000007 48890425[00000000]      mov [firstNumber], rax
    39 0000000F 48890425[00000000]      mov [secondNumber], rax
    40                                 
    41                                 
    42                                 
    43                                 
    44                                 
    45                                 
    46 00000017 48C7C000000000          mov rax, 0
    47 0000001E 48C7C700000000          mov rdi, 0
    48 00000025 48C7C211000000          mov rdx, 17
    49 0000002C 48C7C6[00000000]        mov rsi, inputFirst8
    50 00000033 0F05                    syscall
    51                                 
    52                                 
    53                                 
    54                                 
    55                                 
    56                                 
    57                                 
    58 00000035 49C7C100000000          mov r9, 0
    59                                 
    60                                 whileFirstNumber:
    61 0000003C 4983F906                cmp r9, 6
    62 00000040 7D45                    jge endWhileFirstNumber
    63                                 
    64                                 
    65 00000042 490FB681[00000000]      movzx rax, byte [inputFirst8 + r9]
    66 0000004A 4989C2                  mov r10, rax
    67                                 
    68                                 
    69                                 
    70                                 
    71                                 
    72                                 
    73                                 
    74                                 
    75                                 
    76                                 
    77 0000004D 4C89D0                  mov rax, r10
    78 00000050 4883E830                sub rax, '0'
    79 00000054 4883C000                add rax, 0
    80                                 
    81                                 
    82                                 
    83                                 
    84                                 
    85 00000058 4883F800                cmp rax, 0
    86 0000005C 741C                    jz endConvertFirstNumber
    87                                 
    88 0000005E 4D89C8                  mov r8, r9
    89 00000061 49C7C205000000          mov r10, 5
    90                                 convertFirstNumber:
    91 00000068 4D39C2                  cmp r10, r8
    92 0000006B 7E0D                    jle endConvertFirstNumber
    93                                 
    94 0000006D 48C7C30A000000          mov rbx, 10
    95 00000074 48F7E3                  mul rbx
    96                                 
    97 00000077 49FFC0                  inc r8
    98 0000007A EBEA                    jmp convertFirstNumber
    99                                 endConvertFirstNumber:
   100                                 
   101 0000007C 48010425[00000000]      add [firstNumber],rax
   102                                 
   103 00000084 49FFC1                  inc r9
   104 00000087 EBB1                    jmp whileFirstNumber
   105                                 
   106                                 endWhileFirstNumber:
   107                                 
   108                                 
   109                                 
   110                                 
   111                                 
   112                                 
   113                                 
   114 00000089 49FFC1                  inc r9
   115 0000008C 490FB681[00000000]      movzx rax, byte [inputFirst8 + r9]
   116 00000094 48890425[00000000]      mov [operator], rax
   117                                 
   118                                 
   119                                 
   120                                 
   121                                 
   122                                 
   123                                 
   124                                 
   125                                 
   126                                 
   127                                 
   128                                 
   129                                 
   130                                 
   131                                 
   132                                 
   133                                 
   134 0000009C 49FFC1                  inc r9
   135 0000009F 49FFC1                  inc r9
   136                                 
   137                                 whileSecondNumber:
   138 000000A2 4983F90F                cmp r9, 15
   139 000000A6 7D45                    jge endWhileSecondNumber
   140                                 
   141                                 
   142 000000A8 490FB681[00000000]      movzx rax, byte [inputFirst8 + r9]
   143 000000B0 4989C2                  mov r10, rax
   144                                 
   145                                 
   146                                 
   147                                 
   148                                 
   149                                 
   150                                 
   151                                 
   152                                 
   153                                 
   154 000000B3 4C89D0                  mov rax, r10
   155 000000B6 4883E830                sub rax, '0'
   156 000000BA 4883C000                add rax, 0
   157                                 
   158                                 
   159                                 
   160                                 
   161                                 
   162                                 
   163 000000BE 4883F800                cmp rax, 0
   164 000000C2 741C                    jz endConvertSecondNumber
   165                                 
   166 000000C4 4D89C8                  mov r8, r9
   167 000000C7 49C7C20E000000          mov r10, 14
   168                                 convertSecondNumber:
   169 000000CE 4D39C2                  cmp r10, r8
   170 000000D1 7E0D                    jle endConvertSecondNumber
   171                                 
   172 000000D3 48C7C30A000000          mov rbx, 10
   173 000000DA 48F7E3                  mul rbx
   174                                 
   175 000000DD 49FFC0                  inc r8
   176 000000E0 EBEA                    jmp convertSecondNumber
   177                                 endConvertSecondNumber:
   178                                 
   179 000000E2 48010425[00000000]      add [secondNumber],rax
   180                                 
   181 000000EA 49FFC1                  inc r9
   182 000000ED EBB1                    jmp whileSecondNumber
   183                                 
   184                                 endWhileSecondNumber:
   185                                 
   186                                 
   187                                 
   188                                 
   189 000000EF 488B0425[00000000]      mov rax, [operator]
   190                                 
   191                                 
   192 000000F7 4883F82B                cmp rax, 43
   193 000000FB 7419                    jz addOperation
   194                                 
   195                                 
   196 000000FD 4883F82D                cmp rax, 45
   197 00000101 7447                    jz minusOperation
   198                                 
   199                                 
   200 00000103 4883F82A                cmp rax, 42
   201 00000107 746D                    jz multiplyOperation
   202                                 
   203                                 
   204 00000109 4883F82F                cmp rax, 47
   205 0000010D 0F848B000000            jz divideOperation
   206                                 
   207 00000113 E985020000              Jmp error
   208                                 
   209                                 addOperation:
   210                                 
   211                                 
   212                                 
   213 00000118 48C7C000000000          mov rax, 0
   214 0000011F 48890425[00000000]      mov [result], rax
   215                                 
   216 00000127 488B0425[00000000]      mov rax, [firstNumber]
   217 0000012F 48010425[00000000]      add [result], rax
   218                                 
   219 00000137 488B0425[00000000]      mov rax, [secondNumber]
   220 0000013F 48010425[00000000]      add [result], rax
   221                                 
   222 00000147 E98E000000              jmp outputSign
   223                                 
   224                                 minusOperation:
   225                                 
   226                                 
   227                                 
   228 0000014C 48C7C000000000          mov rax, 0
   229 00000153 48890425[00000000]      mov [result], rax
   230                                 
   231 0000015B 488B0425[00000000]      mov rax, [secondNumber]
   232 00000163 488B1C25[00000000]      mov rbx, [firstNumber]
   233                                 
   234 0000016B 4829C3                  sub rbx, rax
   235                                 
   236 0000016E 48891C25[00000000]      mov [result], rbx
   237                                 
   238 00000176 EB65                    jmp outputSign
   239                                 
   240                                 multiplyOperation:
   241                                 
   242                                 
   243                                 
   244 00000178 48C7C000000000          mov rax, 0
   245 0000017F 48890425[00000000]      mov [result], rax
   246                                 
   247 00000187 488B0425[00000000]      mov rax, [firstNumber]
   248 0000018F 488B1C25[00000000]      mov rbx, [secondNumber]
   249                                 
   250 00000197 48F7E3                  mul rbx
   251                                 
   252 0000019A 48010425[00000000]      add [result], rax
   253                                 
   254 000001A2 EB39                    jmp outputSign
   255                                 
   256                                 divideOperation:
   257                                 
   258                                 
   259                                 
   260 000001A4 48C7C000000000          mov rax, 0
   261 000001AB 48890425[00000000]      mov [result], rax
   262                                 
   263 000001B3 488B0425[00000000]      mov rax, [firstNumber]
   264 000001BB 488B1C25[00000000]      mov rbx, [secondNumber]
   265                                 
   266 000001C3 48C7C200000000          mov rdx, 0
   267 000001CA 48F7F3                  div rbx
   268                                 
   269 000001CD 48010425[00000000]      add [result], rax
   270 000001D5 48891425[00000000]      mov [remainder], rdx
   271                                 
   272 000001DD EBFE                    jmp outputSign
   273                                 
   274                                 outputSign:
   275                                 
   276                                 
   277                                 
   278 000001DF 488B0425[00000000]      mov rax, [result]
   279 000001E7 4883F800                cmp rax, 0
   280                                 
   281                                 
   282 000001EB 7D2D                    jge outputPlus
   283                                 
   284                                 
   285                                 outputMinus:
   286 000001ED 49C7C02D000000          mov r8, 45
   287 000001F4 4C890425[00000000]      mov [sign], r8
   288 000001FC 48C7C001000000          mov rax, 1
   289 00000203 48C7C701000000          mov rdi, 1
   290 0000020A 48C7C201000000          mov rdx, 1
   291 00000211 48C7C6[00000000]        mov rsi, sign
   292 00000218 0F05                    syscall
   293 0000021A EB2B                    jmp convertTOOutput
   294                                 
   295                                 outputPlus:
   296 0000021C 49C7C02B000000          mov r8, 43
   297 00000223 4C890425[00000000]      mov [sign], r8
   298 0000022B 48C7C001000000          mov rax, 1
   299 00000232 48C7C701000000          mov rdi, 1
   300 00000239 48C7C201000000          mov rdx, 1
   301 00000240 48C7C6[00000000]        mov rsi, sign
   302 00000247 0F05                    syscall
   303                                 
   304                                 
   305                                 convertTOOutput:
   306                                 
   307                                 
   308                                 
   309                                 
   310 00000249 488B0425[00000000]      mov rax, [result]
   311                                 
   312                                 
   313                                 
   314 00000251 4883F800                cmp rax, 0
   315 00000255 7D01                    jge positeNumber
   316 00000257 48F7D8                  neg rax
   317                                 
   318                                 positeNumber:
   319                                 
   320 0000025A 49C7C100000000          mov r9, 0
   321                                 whileConvertTOOutput:
   322 00000261 4983F90C                cmp r9, 12
   323 00000265 7D20                    jge endWhileConvertTOOutput
   324                                 
   325                                 
   326 00000267 48C7C200000000          mov rdx, 0
   327 0000026E 48C7C30A000000          mov rbx, 10
   328 00000275 48F7F3                  div rbx
   329                                 
   330                                 
   331 00000278 6683C230                add dx, '0'
   332                                 
   333 0000027C 66418991[00000000]      mov [output + r9], dx
   334                                 
   335 00000284 49FFC1                  inc r9
   336 00000287 EBD6                    jmp whileConvertTOOutput
   337                                 endWhileConvertTOOutput:
   338                                 
   339                                 
   340                                 
   341                                 
   342                                 
   343 00000289 49C7C10B000000          mov r9, 11
   344                                 
   345                                 whileOutput:
   346 00000290 4983F900                cmp r9, 0
   347 00000294 7C34                    jl endWhileOutput
   348                                 
   349                                 
   350 00000296 490FB681[00000000]      movzx rax, byte [output + r9]
   351 0000029E 4989C2                  mov r10, rax
   352                                 
   353                                 
   354 000002A1 48890425[00000000]      mov [outputTemp], rax
   355 000002A9 48C7C001000000          mov rax, 1
   356 000002B0 48C7C701000000          mov rdi, 1
   357 000002B7 48C7C202000000          mov rdx, 2
   358 000002BE 48C7C6[00000000]        mov rsi, outputTemp
   359 000002C5 0F05                    syscall
   360                                 
   361 000002C7 49FFC9                  dec r9
   362 000002CA EBC2                    jmp whileOutput
   363                                 endWhileOutput:
   364                                 
   365                                 
   366                                 
   367                                 
   368                                 
   369 000002CC 488B0425[00000000]      mov rax, [operator]
   370 000002D4 4883F82F                cmp rax, 47
   371 000002D8 0F85DC000000            jnz finish
   372                                 
   373 000002DE 48C7C020722000          mov rax, " r "
   374 000002E5 48890425[00000000]      mov [outputTemp], rax
   375                                 
   376 000002ED 48C7C001000000          mov rax, 1
   377 000002F4 48C7C701000000          mov rdi, 1
   378 000002FB 48C7C202000000          mov rdx, 2
   379 00000302 48C7C6[00000000]        mov rsi, outputTemp
   380 00000309 0F05                    syscall
   381                                 
   382 0000030B 48C7C020000000          mov rax, " "
   383 00000312 48890425[00000000]      mov [outputTemp], rax
   384                                 
   385 0000031A 48C7C001000000          mov rax, 1
   386 00000321 48C7C701000000          mov rdi, 1
   387 00000328 48C7C202000000          mov rdx, 2
   388 0000032F 48C7C6[00000000]        mov rsi, outputTemp
   389 00000336 0F05                    syscall
   390                                 
   391                                 
   392                                 
   393                                 
   394                                 
   395 00000338 488B0425[00000000]      mov rax, [remainder]
   396 00000340 49C7C10A000000          mov r9, 10
   397 00000347 49C7C000000000          mov r8, 0
   398                                 
   399                                 convertRemainderTOOutput:
   400 0000034E 4831D2                  xor rdx, rdx
   401 00000351 49F7F1                  div r9
   402                                 
   403 00000354 4883C230                add rdx, '0'
   404 00000358 498990[00000000]        mov [remainderOutput + r8], rdx
   405                                 
   406 0000035F 4883F800                cmp rax, 0
   407 00000363 7403                    je outputRemainder
   408                                 
   409 00000365 49FFC0                  inc r8
   410 00000368 EBE2                    jmp convertRemainderTOOutput
   411                                 
   412                                 
   413                                 
   414                                 
   415                                 outputRemainder:
   416 0000036A 4983F800                cmp r8, 0
   417 0000036E 7C4E                    jl finish
   418                                 
   419 00000370 498B80[00000000]        mov rax, [remainderOutput + r8]
   420 00000377 48890425[00000000]      mov [outputTemp], rax
   421 0000037F 48C7C001000000          mov rax, 1
   422 00000386 48C7C701000000          mov rdi, 1
   423 0000038D 48C7C6[00000000]        mov rsi, outputTemp
   424 00000394 48C7C201000000          mov rdx, 1
   425 0000039B 0F05                    syscall
   426                                 
   427 0000039D 49FFC8                  dec r8
   428 000003A0 EBC6                    jmp outputRemainder
   429                                 error:
   430                                 
   431                                 
   432                                 
   433 000003A2 48C7C001000000          mov rax, 1
   434 000003A9 48C7C701000000          mov rdi, 1
   435 000003B0 48C7C205000000          mov rdx, 5
   436 000003B7 48C7C6[00000000]        mov rsi, ERROR
   437 000003BE 0F05                    syscall
   438                                 
   439                                 finish:
   440                                 
   441                                 
   442                                 
   443                                 
   444 000003C0 49C7C00A000000          mov r8, 0x0a
   445 000003C7 4C890425[00000000]      mov [newLine], r8
   446 000003CF 48C7C001000000          mov rax, 1
   447 000003D6 48C7C701000000          mov rdi, 1
   448 000003DD 48C7C201000000          mov rdx, 1
   449 000003E4 48C7C6[00000000]        mov rsi, newLine
   450 000003EB 0F05                    syscall
   451                                 
   452                                 
   453 000003ED 48C7C03C000000          mov rax, 60
   454 000003F4 4831FF                  xor rdi, rdi
   455 000003F7 0F05                    syscall
