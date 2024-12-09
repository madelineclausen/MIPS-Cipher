.include "hw2_clausenm.asm"

.globl main

# Data Section
.data
# codeseq can contain ANYTHING before the function call
codeseq: .word 250, 353, 343, 513, 249, 35, 454, 226, 254, 472, 151, 236
ciphertext: .asciiz "i am a man of fortune, and i must seek my fortune"
message: .asciiz "iamtim" 

strLabel1: .asciiz "Function returned: "
endline: .asciiz "\n"

# Program 
.text
main:

    # load the arguments
    la $a0, ciphertext
    la $a1, codeseq
    la $a2, message
    jal encodeNullCipher

    # save the return value
    move $t0, $v0   

    #print label
    la $a0, strLabel1
    li $v0, 4
    syscall

    #print return value
    move $a0, $t0
    li $v0, 1
    syscall

    #print newline
    la $a0, endline
    li $v0, 4
    syscall

    # Write loop to print out the codeseq array or check manually in the memory pane of MARS

    #quit program
    li $v0, 10
    syscall

