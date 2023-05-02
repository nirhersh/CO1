.global _start

.section .text
_start:
    movq $array1, %rax # %rax is the address of current element in array 1
    movq $array2, %rbx # %rbx is the address of current element in array 2
    movq $mergedArray, %rdi # %rdi is the current element in the merged array
    movq $0, %rcx # counter

_loop_HW1:
    movl (%rax), %esp #%esp is the element in array 1
    movl (%rbx), %ebp # ebp is the element in array 2
    cmpl $0, %esp
    je _array1_finished_HW1
    jmp _run_through_array1_HW1

_continue_HW1:
    cmpl $0, %ebp
    jne _run_through_array2_HW1

_ready_to_compare_HW1:
    lea (%rdi, %rcx, 4), %r10
    cmpl %esp, %ebp
    ja _copy_from_array2_HW1
    jb _copy_from_array1_HW1
    # array1=array2
    movl %esp, (%r10)
    lea 4(%rax), %rax
    lea 4(%rbx), %rbx
    inc %rcx
    jmp _loop_HW1

_copy_from_array1_HW1:
    movl %esp, (%r10)
    inc %rcx
    lea 4(%rax), %rax
    jmp _loop_HW1

_copy_from_array2_HW1:
    movl %ebp, (%r10)
    inc %rcx
    lea 4(%rbx), %rbx
    jmp _loop_HW1
    
_array1_finished_HW1:
    cmpl $0, %ebp
    je _finish_HW1
    jmp _continue_HW1


_run_through_array1_HW1:
    lea 4(%rax), %r15
    movl (%r15), %esi
    cmpl %esi, %esp
    jne _continue_HW1
    movq %r15, %rax
    jmp _run_through_array1_HW1
    
_run_through_array2_HW1:
    lea 4(%rbx), %r15
    movl (%r15), %esi
    cmpl %esi, %ebp
    jne _ready_to_compare_HW1
    movq %r15, %rbx
    jmp _run_through_array2_HW1

_finish_HW1:
    lea (%rdi, %rcx, 4), %r10
    movl $0, (%r10)
    