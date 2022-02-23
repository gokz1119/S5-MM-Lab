DATA SEGMENT
    A DB 0F5H
    B DB 84H
    SUM DB ?
    CARRY DB 00H
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    START: MOV AX, DATA
           MOV DS, AX
           
           MOV AL, A
           ADD AL, B
           JNC SKIP
           INC CARRY
    SKIP:  MOV SUM, AL
    
           MOV AH, 4CH
           MOV AL, 00H
           INT 21H
CODE ENDS
END START