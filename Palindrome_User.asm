PRINT MACRO S
    MOV AH, 09H
    LEA DX, S
    INT 21H
ENDM    

DATA SEGMENT
    STRING1 DB 50H DUP ('$')
    PAL DB 00H
    COUNT DW 00H
    MSG1 DB 0DH, 0AH,'IT IS A PALINDROME$'
    MSG2 DB 0DH, 0AH,'IT IS NOT A PALINDROME$'
    MSG DB 'ENTER A STRING:$'
    TEMPMSG DB 0DH, 0AH, 'STRING INPUTED$'  
DATA ENDS

EXTRA SEGMENT
    STRING2 DB 50H DUP (?)
EXTRA ENDS
CODE SEGMENT
    ASSUME CS:CODE, DS: DATA, ES: EXTRA
    START: MOV AX, DATA
           MOV DS, AX
           MOV AX, EXTRA
           MOV ES, AX
           
           PRINT MSG
           MOV AH, 01H
           LEA SI, STRING1
           MOV CX, 0000H
     LOOP1:
           INT 21H
           CMP AL, 0DH,
           JZ STOP1
           MOV [SI], AL
           INC SI
           INC CX
           JMP LOOP1         
    STOP1: PRINT TEMPMSG
           MOV COUNT, CX
           
           LEA SI, STRING1
           LEA DI, STRING2
           ADD DI, COUNT
           SUB DI, 0001H
           
     BACK: CLD
           LODSB
           STD
           STOSB
           LOOP BACK
           
           LEA SI, STRING1
           LEA DI, STRING2
           MOV CX, COUNT
           
           CLD
           REPE CMPSB
           JNZ SKIP
           INC PAL
           PRINT MSG1
           JMP SKIP2
     SKIP: PRINT MSG2
    SKIP2: MOV AH, 4CH
           INT 21H
END START           
CODE ENDS  