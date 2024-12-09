.include "hw2_clausenm.asm"

.globl main

# Data Section
.data
array: .word 7,9,11,-3,5,-7,11,-21
.word 100
array_len: .word 8
n: .word 3
strLabel1: .asciiz " isMul2("
comma: .asciiz ", "
strLabel2: .asciiz ") returned "
endline: .asciiz "\n"

# Program 
.text
main:

    # load the arguments
    la $a0, array
    la $a1, array_len
    lw $a1, 0($a1)
    la $a2, n
    lw $a2, 0($a2)

    # call the function
    jal isMul2

    # save the return values
    move $t8, $v0

    #print label
    la $a0, strLabel1
    li $v0, 4
    syscall

    #print argument value - array address in hex
    la $a0, array
    li $v0, 34
    syscall

    #print comma
    la $a0, comma
    li $v0, 4
    syscall

    #print argument value - len in decimal
    la $a0, array_len
    lw $a0, 0($a0)
    li $v0, 1
    syscall

    #print comma
    la $a0, comma
    li $v0, 4
    syscall

    #print argument value - n in decimal
    la $a0, n
    lw $a0, 0($a0)
    li $v0, 1
    syscall

    #print label2
    la $a0, strLabel2
    li $v0, 4
    syscall

    #print return value1
    move $a0, $t8
    li $v0, 1
    syscall

    #print closing paren
    la $a0, endline
    li $v0, 4
    syscall
 
    #quit program
    li $v0, 10
    syscall

