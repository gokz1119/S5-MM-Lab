DATA SEGMENT
    MSG1 DB 0DH, 0AH, "Please enter the First number: $"
    MSG2 DB 0DH, 0AH, "Please enter the Second number: $"
    MSG3 DB 0DH, 0AH, "Sum = $"
    MSG4 DB 0DH, 0AH, "Carry = $"
    
    A DW ?
    B DW ?
    SUM DW ?
    CARRY DB 00H
    
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    START: MOV AX, DATA
           MOV DS, AX
           MOV AH, 09H
           LEA DX, MSG1
           INT 21H
           LEA SI, A
           CALL GETNUM
           MOV [SI+1], AL
           CALL GETNUM
           MOV [SI], AL
           
           MOV AH, 09H
           LEA DX, MSG2
           INT 21H
           LEA SI, B
           CALL GETNUM
	       MOV [SI+1], AL
           CALL GETNUM
	       MOV [SI], AL
           
           MOV AX, A
           ADD AX, B
           JNC SKIP
           INC CARRY
     SKIP: MOV SUM, AX
     
           MOV AH, 09H
           LEA DX, MSG3
           INT 21H
           LEA SI, SUM
	   INC SI
           CALL PUTNUM
           DEC SI
           CALL PUTNUM
           
           MOV AH, 09H
           LEA DX, MSG4
           INT 21H
           LEA SI, CARRY
           CALL PUTNUM
           
           MOV AH, 4CH
           INT 21H
           
     PROC GETNUM
        PUSH CX
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        CMP AL, 09H
        JLE G1
        SUB AL, 07H
        
        G1: MOV CL, 04H
            ROL AL, CL
        
        MOV CH, AL
        
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        CMP AL, 09H
        JLE G2
        SUB AL, 07H
        
        G2: ADD AL, CH
        
        POP CX
        RET
     ENDP GETNUM
     
     PROC PUTNUM
        PUSH CX
        MOV AL, [SI]
        AND AL, 0F0H
        MOV CL, 04H
        ROL AL, CL
        ADD AL, 30H
        CMP AL, 39H
        JLE P1
        ADD AL, 07H
        
        P1: MOV AH, 02H
            MOV DL, AL
            INT 21H
        
        MOV AL, [SI]
        AND AL, 0FH
        ADD AL, 30H
        CMP AL, 39H
        JLE P2
        ADD AL, 07H
        
        P2: MOV AH, 02H
            MOV DL, AL
            INT 21H
        
        POP CX
        RET
     ENDP PUTNUM
CODE ENDS
END START