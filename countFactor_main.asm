.include "hw2_clausenm.asm"

.globl main

# Data Section
.data
array: .word 1,2,3,4
len: .word -4
k: .word 1
factors: .word 200,201,202,203,204,205,206,207  # factors can contain ANYTHING before the function call

strLabel1: .asciiz "Function returned: "
endline: .asciiz "\n"

# Program 
.text
main:

    # load the arguments
    la $a0, array
    la $a1, len
    lw $a1, 0($a1)
    la $a2, k
    lw $a2, 0($a2)
    la $a3, factors

    # call the function
    jal countFactor

    # save the return value
    move $t8, $v0

    #print label
    la $a0, strLabel1
    li $v0, 4
    syscall

    #print return value
    move $a0, $t8
    li $v0, 1
    syscall

    #print newline
    la $a0, endline
    li $v0, 4
    syscall

    # Write loop to print out the factor array or check manually in the memory pane of MARS
 
    #quit program
    li $v0, 10
    syscall

