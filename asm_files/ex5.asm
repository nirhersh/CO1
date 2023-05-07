.global _start

.section .text
_start:
    leaq (new_node), %r8 # r8 is the pointer to the new node
    movq root(%rip), %rbx # rbx is the pointer to the root of the tree
    cmpq $0, %rbx
    je _empty_tree_HW1
    movq (%r8), %rax # rax holds the value of new node
_search_placement_HW1:
    cmpq %rax, (%rbx) # new_node < current_node
    je _finish_HW1 # new_node value is already in the tree
    ja _left_son_HW1
    jb _right_son_HW1

_left_son_HW1:
    cmpq $0, 8(%rbx) # check if left son exists
    je _no_left_son_HW1
    movq 8(%rbx), %rbx # move to left son
    jmp _search_placement_HW1 

_no_left_son_HW1:
    movq %r8, 8(%rbx) # set new node as left son
    jmp _finish_HW1

_right_son_HW1:
    cmpq $0, 16(%rbx) # check if right son exists
    je _no_right_son_HW1
    movq 16(%rbx), %rbx
    jmp _search_placement_HW1

_no_right_son_HW1:
    movq %r8, 16(%rbx) # set new node as right son
    jmp _finish_HW1

_empty_tree_HW1:
    movq %r8, root(%rip) # set new node as the root

_finish_HW1:
