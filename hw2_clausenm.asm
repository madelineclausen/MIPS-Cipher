# Madeline Clausen
# clausenm

.text

countSpecial:
    li $t0, 0
    li $t1, 0
loopCountSpecial:
    lb $t2, ($a0)
    addi $a0, $a0, 1
    beqz $t2, returnCountSpecial
    bge $t2, 33, punctuation1
    beq $t2, 32, loopCountSpecial
    addi $t1, $t1, 1
    j loopCountSpecial
punctuation1:
    bge $t2, 48, punctuation2
    addi $t0, $t0, 1
    j loopCountSpecial
punctuation2:
    ble $t2, 57,loopCountSpecial
    bge $t2, 65, punctuation3
    addi $t0, $t0, 1
    j loopCountSpecial
punctuation3:
    bge $t2, 91, punctuation4
    j loopCountSpecial
punctuation4:
    bge $t2, 97, punctuation5
    addi $t0, $t0, 1
    j loopCountSpecial
punctuation5:
    bge $t2, 123, punctuation6
    j loopCountSpecial 
punctuation6:
    beq $t2, 127, loopCountSpecial
    addi $t0, $t0, 1
    j loopCountSpecial
returnCountSpecial:
    move $v0, $t0
    move $v1, $t1
    jr $ra


replace:
    beqz $a1, errorReplace
    bge $a1, 128, errorReplace
    bge $a2, 128, errorReplace
    li $t0, 0
    addi $a0, $a0, -1
loopReplace:
    addi $a0, $a0, 1
    lb $t1, ($a0)
    beqz $t1, returnReplace
    bne $t1, $a1, loopReplace
    addi $t0, $t0, 1
    sb $a2, ($a0)
    j loopReplace
errorReplace:
    li $t0, -1
returnReplace:
    move $v0, $t0
    jr $ra


isMul2:
    blez $a1, returnIsMul2
    bltz $a2, returnIsMul2
    bge $a2, 30, returnIsMul2
    li $t0, 1
    sllv $t0, $t0, $a2
    li $t1, 0
loopIsMul2:
    bge $t1, $a1, returnIsMul2
    lw $t2, ($a0)
    bltz $t2, returnIsMul2
    addi $a0, $a0, 4
    div $t2, $t0
    mfhi $t2
    beqz $t2, checkDoneIsMul2
    addi $t1, $t1, 1
    j loopIsMul2
checkDoneIsMul2:
    addi $a0, $a0, 4
    lw $t2, ($a0)
    beqz $t2, doneIsMul2
    bltz $t2, returnIsMul2
    j checkDoneIsMul2
returnIsMul2:
    li $t1, -1
doneIsMul2:
    move $v0, $t1
    jr $ra




countFactor:
    blez $a1, doneCountFactor
    blez $a2, doneCountFactor
    li $t0, 0
    li $t1, -1
loopCountFactor:
    addi $t1, $t1, 1
    bge $t1, $a1, returnCountFactor
    lw $t2, ($a0)
    addi $a0, $a0, 4
    div $t2, $a2
    mfhi $t3
    beqz $t3, evenlyDivisible
    li $t3, 0x80000000
    sw $t3, ($a3)
    addi $a3, $a3, 4
    j loopCountFactor
evenlyDivisible:
    mflo $t3
    sw $t3, ($a3)
    addi $a3, $a3, 4
    addi $t0, $t0, 1
    j loopCountFactor
doneCountFactor:
    li $t0, -1
returnCountFactor:
    move $v0, $t0
    jr $ra
    

findLenStrings:
    blez $a1, doneFindLenStrings
    li $t0, 0 
    li $t1, 0 
    li $t2, -1 
    li $t3, -1
    li $t4, -1
loopFindLenStrings:
    addi $t2, $t2, 1
    bge $t2, $a1, returnFindLenStrings
    li $t5, 0 
    li $t6, 0
    lw $s0, ($a0)
innerLoopFindLenStrings:
    lb $s1, ($s0)
    beqz $s1, byteIsNull
    addi $t6, $t6, 1
    addi $s0, $s0, 1
    j innerLoopFindLenStrings
byteIsNull:
    beqz $t2, firstElement
    blt $t6, $t3, stringLessThan
    bgt $t6, $t4, stringGreaterThan
    addi $a0, $a0, 4
    j loopFindLenStrings
firstElement:
    move $t4, $t6
    move $t1, $t2
    move $t3, $t6
    move $t0, $t2
    addi $a0, $a0, 4
    j loopFindLenStrings
stringGreaterThan:
    move $t4, $t6
    move $t1, $t2
    addi $a0, $a0, 4
    j loopFindLenStrings
stringLessThan:
    move $t3, $t6
    move $t0, $t2
    addi $a0, $a0, 4
    j loopFindLenStrings
doneFindLenStrings:
    li $t0, -1
    li $t1, -1
returnFindLenStrings:
    move $v0, $t0
    move $v1, $t1
    jr $ra


encodeNullCipher:
    li $s0, -1
    move $t0, $a0
    move $t1, $a2
    lb $t2, ($a0)
    beqz $t2, returnEncodeNullCipher
    lb $t2, ($a2)
    beqz $t2, returnEncodeNullCipher
    li $s1, 0
    addi $s0, $s0, 1
    move $s2, $a1
    li $t4, 0
loopEncodeNullCipher:    
    lb $t2, ($t0) 
    lb $t3, ($t1) 
    beqz $t2, returnEncodeNullCipher
    beq $t2, 32, foundNewWord
    beq $s1, 1, alreadyFoundWord
    addi $t4, $t4, 1
    beq $t2, $t3, foundLetter
    addi $t0, $t0, 1
    j loopEncodeNullCipher
foundLetter:
    sw $t4, ($s2)
    addi $s0, $s0, 1
    li $s1, 1
alreadyFoundWord:
    lb $t2, ($t0) 
    beqz $t2, returnEncodeNullCipher
    beq $t2, 32, foundNewWord
    addi $t0, $t0, 1
    j alreadyFoundWord
foundNewWord:
    bnez $s1, continueFoundNewWord
    addi $t1, $t1, -1
    li $t5, 0
    sw $t5, ($s2)
continueFoundNewWord:
    addi $s2, $s2, 4
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    li $t4, 0
    li $s1, 0
    j loopEncodeNullCipher
returnEncodeNullCipher:
    bnez $s1, returnEncodeNullCipher2
    li $t5, 0
    sw $t5, ($s2)
returnEncodeNullCipher2:
    move $v0, $s0
    jr $ra
