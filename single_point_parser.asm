;  Executable name : calculator_v2
;  Version         : 1.0
;  Created date    : 11/02/2016
;  Last update     : 11/02/2016
;  Author          : Johan Ribom
;  Description     : A simple calculator that uses float numbers.
;
;  Run it this way:
;	calculator_v2  
;
;  Build using these commands:
;    nasm -f elf -g -F stabs calculator_v2.asm
;    ld -o calculator_v2 calculator_v2.o
;
section .data

    firstvalue  dd 123.11111
    secondvalue dd 10.0
    ten dq 10.0
    extra dd 0xA
    sign db ' '
    printString db '00000000.', 0xA
    printStringLen equ $-sign

section .bss
    
    thirdvalue resq 1
    exponent resb 1
    integerPart resd 1
    fractionPart resd 1
    fractionPartInteger resd 1

section .text
	global _start

_start:
        
        mov dword eax, [firstvalue]
        shl eax, 1
        jc SetNegative
        mov byte [sign], ' '
        jmp GetExponent

SetNegative:
        mov byte [sign], '-'

GetExponent: 
        mov dword [extra], eax
        mov byte ah, [extra + 3]
        sub ah, 0x7F
        mov [exponent], ah
        mov dword eax, [extra]
        mov dword [fractionPart], eax
        shl dword [fractionPart], 0x8
        mov dword [integerPart], 0x1

        mov ecx, 0
        mov cl, [exponent]
        cmp cl, 0
        jl NegativeLoop
        jg PositiveLoop
        jmp FixFractionPart


NegativeLoop:
        cmp cl, 0
        je FixFractionPart
        inc cl
        rcr dword [integerPart], 0x1
        rcr dword [fractionPart], 0x1
        jmp NegativeLoop

PositiveLoop:
        cmp cl, 0
        je FixFractionPart
        dec cl
        rcl dword [fractionPart], 0x1
        rcl dword [integerPart], 0x1
        jmp PositiveLoop


FixFractionPart: 
        mov dword [fractionPartInteger], 0
        mov ecx, 0
FractionLoop:
        cmp ecx, 23
        je FractionLoopDone
        inc ecx
        shl dword [fractionPart], 1
        jnc FractionLoop
        push ecx
        mov ebx, 1
SmallLoop:
        cmp ecx, 0
        je SmallLoopDone
        dec ecx 
        shl ebx, 1
        jmp SmallLoop
SmallLoopDone:
        pop ecx
        mov eax, 0x3B9ACA00
        mov edx, 0
        idiv ebx
        add [fractionPartInteger], eax
        jmp FractionLoop

FractionLoopDone:

ConvertNumberToString:
        mov eax, [integerPart]
        mov edx, 0
        mov ecx, 0
        mov ebx, 0xB
        push ebx
        mov ebx, 0xA
ConvertLoop:
        idiv ebx
        add edx, 0x30
        push edx
        mov edx, 0
        cmp eax, 0
        jne ConvertLoop

PopInteger:
        pop edx
        cmp edx, 0xB
        je CheckIfDone
        mov byte [printString + ecx], dl
        inc ecx
        jmp PopInteger

CheckIfDone:
        cmp ecx, 9
        je NoDot
        mov byte [printString + ecx], 0x2E        
        push 0xB
        mov eax, [fractionPartInteger]
        mov edx, 0
PushLoop:        
        idiv ebx
        push edx
        cmp eax, 0
        je FracLoop
        mov edx, 0
        jmp PushLoop

FracLoop:
        cmp ecx, 9
        je RoundCorrect
        inc ecx
        pop edx
        cmp edx, 0xB
        je  RoundCorrect
        add edx, 0x30
        mov byte [printString + ecx], dl
        jmp FracLoop
AddSpace:
        mov byte [printString + ecx], 0x30
        push edx

RoundCorrect:
        pop edx
        cmp edx, 0xB
        je Print
        mov byte bl, [printString + ecx]
        cmp bl, 0x5
        jl PopLoop
        dec ecx
        mov byte bl, [printString + ecx]
        inc bl
        cmp bl, 0x3A
        jne PopLoop

        mov byte [printString + ecx], 0x30
RoundNext:
        dec ecx
        mov byte bl, [printString + ecx]
        cmp bl, 0x2E
        je RoundNext
        inc bl
        cmp bl, 0x3A
        je CarryOver
        mov byte [printString + ecx], bl 
        jmp PopLoop

CarryOver:
        mov byte [printString + ecx], 0x30
        jmp RoundNext



PopLoop:
        pop edx
        cmp edx, 0xB
        jne PopLoop
        jmp Print

NoDot:
        mov byte [printString + 9], 0x20
Print:
        mov byte [sign + printStringLen - 1], 0xA

        mov eax, 4
        mov ebx, 1
        mov ecx, sign
        mov edx, printStringLen
        int 0x80

        mov eax, 1
        mov ebx, 0
        int 0x80