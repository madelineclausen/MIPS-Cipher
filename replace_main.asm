.include "hw2_clausenm.asm"

.globl main

# Data Section
.data
strLabel: .asciiz "str \""
quote: .asciiz "\"
becomes: .asciiz " becomes \""
endquote: .asciiz "\"\n"
errstr: .asciiz " is unmodified due to argument error"

str: .asciiz "Funny Bunny"
from: .ascii "F"
to: .ascii "A"

# Program
.text
main:
    #print Label string
    la $a0, strLabel
    li $v0, 4
    syscall

    #print string
    la $a0, str
    li $v0, 4
    syscall

    #print Label string
    la $a0, quote
    li $v0, 4
    syscall

    # load the arguments
    la $a0, str
    la $a1, from
    lbu $a1, ($a1)
    la $a2, to
    lbu $a2, ($a2)

    # call the function
    jal replace

	bltz $v0, error

    #print Label string
    la $a0, becomes
    li $v0, 4
    syscall

    #print modified string
    la $a0, str
    li $v0, 4
    syscall

    #print newline
    la $a0, endquote
    li $v0, 4
    syscall

    #quit program
    li $v0, 10
    syscall

error:
    #print modified string
    la $a0, errstr
    li $v0, 4
    syscall
	

    #quit program
    li $v0, 10
    syscall
