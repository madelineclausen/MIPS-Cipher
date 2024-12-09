.include "hw2_clausenm.asm"

.globl main

# Data Section
.data
strLabel: .asciiz "countSpecial of \""
qoute: .asciiz "\" returns ("
comma: .asciiz ","
endparen: .asciiz ")\n"

str: .asciiz "~What's\thappening??" 
str2: .byte '*', '\r', '1', '\n', '2', '\t', '3', '\b', '4', '\f', '5', 0x0B, '6', 0x0F, '+', '\0'

# Program 
.text
main:

    # load the arguments
    la $a0, str2

    # call the function
    jal countSpecial

    # save the return value
    move $t0, $v0
    move $t1, $v1

    #print Label string
    la $a0, strLabel
    li $v0, 4
    syscall

    #print string
    la $a0, str
    li $v0, 4
    syscall

    #print Label string
    la $a0, qoute
    li $v0, 4
    syscall
    
    #print return values
    move $a0, $t0
    li $v0, 1
    syscall

    la $a0, comma
    li $v0, 4
    syscall

    move $a0, $t1
    li $v0, 1
    syscall

    la $a0, endparen
    li $v0, 4
    syscall

    #quit program
    li $v0, 10
    syscall

