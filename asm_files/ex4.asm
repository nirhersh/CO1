.global _start

.section .text
_start:
    movq head(%rip), %rdi # rdi is the pointer to the current element in the linked list
    movq Source(%rip), %rsi # rsi is the address of source
    movq $0, %rbp
    movl Value(%rip), %ebp # ebp is the int Value
    movq $0, %rax # rax is the pointer to the node prev to value in the find value loop
    movq $0, %rbx # rbx is the pointer to the node after value
    movq $0, %rcx # rcx is the pointer to the node prev to source
    movq 4(%rsi), %rdx # rdx is the pointer to the node after source
    
    cmpq $0, %rdi
    je _finish_HW1 # linked list is empty
    cmpq $0, %rsi
    je _finish_HW1

_find_prev_source_loop_HW1:
    cmpq %rdi, %rsi # source has no prev
    je _find_value_loop_HW1
    cmpq $0, %rdi # source is not found in the list - nothing to do
    je _finish_HW1
    cmpq 4(%rdi), %rsi # if next = Source
    je _found_prev_source_HW1
    movq 4(%rdi), %rdi
    jmp _find_prev_source_loop_HW1
    
_found_prev_source_HW1:
    movq %rdi, %rcx
    movq $head, %rdi # restore head pointer
    jmp _find_value_loop_HW1

# By this point, we have: source, prev_source, next_source

_find_value_loop_HW1:
    cmpl (%rdi), %ebp
    je _switch_HW1
    movq %rdi, %rax # update prev to value
    movq 4(%rdi), %rdi
    cmpq $0, %rdi
    je _finish_HW1 # reached the end - value not found in list
    jmp _find_value_loop_HW1

# By this point, we also have: Value, Next value (in value.next), prev value

_switch_HW1:
    movq 4(%rdi), %rbx # update next of value
    cmpq head(%rip), %rsi # if source = head, set: head=value
    je _source_is_head_HW1
    cmpq Value(%rip), %rdi # if value = head, set: head=source
    je _value_is_head_HW1


_source_is_head_HW1:
    movq %rdi, head(%rip)
    jmp _update_prev_source_HW1

_value_is_head_HW1:
    movq %rsi, head(%rip)
    jmp _update_prev_source_HW1

_update_prev_source_HW1:
    # prev source needs to point to value
    cmpq $0, %rcx
    je _update_source_HW1
    cmpq %rdi, %rcx
    je _prev_source_is_value_HW1
    movq %rdi, 4(%rcx)
    jmp _update_source_HW1

_prev_source_is_value_HW1:
    # value needs to point to next_source
    movq %rdx, 4(%rdi)

_update_source_HW1:
    # source need to point to next_value
    cmpq %rbx, %rsi
    je _source_is_next_value_HW1
    movq %rbx, 4(%rsi)
    jmp _update_prev_value_HW1

_source_is_next_value_HW1:
    # source needs to point to value
    movq %rdi, 4(%rsi)
    jmp _update_prev_value_HW1

_update_prev_value_HW1:
    # prev_value needs to point to source if its not him!
    cmpq $0, %rax
    je _update_value_HW1
    cmpq %rsi, %rax
    je _prev_value_is_source_HW1
    movq %rsi, 4(%rax)
    jmp _update_value_HW1

_prev_value_is_source_HW1:
    jmp _update_value_HW1

_update_value_HW1:
    # value needs to point to next_source
    cmpq %rdx, %rdi
    je _next_source_is_value_HW1 # value needs to point to source
    movq %rdx, 4(%rdi)
    jmp _finish_HW1

_next_source_is_value_HW1:
    movq %rsi, 4(%rdi)

_finish_HW1:
