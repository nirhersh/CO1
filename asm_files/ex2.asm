.global _start

.section .text
_start:
    movl $0, %ecx # counter
    movq $destination, %rdx # rdx hold the address of destination
    movq $source, %rbx # rbx hold the address of source
    cmpl $0, num
    jge _positive_HW1
    jl _negative_HW1

_positive_HW1:
    #cmpq %rbx, %rdx # check if dest is bigger than source
    #jge _source_before_dest_HW1
_loop_1_HW1:
    cmpl num, %ecx
    je _finish_HW1
    movb (%rbx, %rcx), %al # temp for byte to copy
    leaq (%rdx, %rcx), %r9 # r9 holds the address to copy
    movb %al, (%r9)
    inc %ecx
    jmp _loop_1_HW1

_source_before_dest_HW1:
    movl num, %ecx
    cmpl $0, %ecx
_loop_2_HW1:
    je _finish_HW1
    movb (%rbx, %rcx), %al
    leaq (%rdx, %rcx), %r9 # r9 holds the address to copy
    movb %al, (%r9)
    dec %ecx
    jmp _loop_2_HW1

_negative_HW1:
    movl num, %edx
    movl %edx, destination

_finish_HW1:
