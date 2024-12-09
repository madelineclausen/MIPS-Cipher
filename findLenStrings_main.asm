.include "hw2_clausenm.asm"

.globl main

# Data Section
.data
array: .word  str_foo, str_hello, str_abc, str_b, str_c
len: .word 5

strLabel1: .asciiz "Function returned: ("
comma: .asciiz ", "
paren: .asciiz ")\n"

str_foo: .asciiz "Abc"
str_hello: .asciiz "HeLLO!"
str_abc: .asciiz "B"
str_b: .asciiz "FOO"
str_c: .asciiz "Boo"

# Program 
.text
main:
    # load the value into the argument register
    la $a0, array
    la $a1, len
    lw $a1, 0($a1)

    # call the function
    jal findLenStrings

    # save the return value
    move $t8, $v0
    move $t9, $v1

    # print string
    li $v0, 4
    la $a0, strLabel1
    syscall

    #print first return value
    move $a0, $t8
    li $v0, 1
    syscall

    #print comma
    la $a0, comma
    li $v0, 4
    syscall

    #print second return value
    move $a0, $t9
    li $v0, 1
    syscall

    #print closing paren
    la $a0, paren
    li $v0, 4
    syscall

    # Exit the program
    li $v0, 10
    syscall
