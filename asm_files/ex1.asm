.global _start

.section .text
_start:
    movb $0, Bool
    movq $0, %rcx # rcx is the iteration number
    movq num, %rax
loop_HW1:
    rol %rax
    jb inc_HW1 # CF is 1
after_inc_HW1:
    inc %rcx
    cmpq $64, %rcx
    je finish_HW1
    jmp loop_HW1
inc_HW1:
    incb Bool
    jmp after_inc_HW1
finish_HW1: 
