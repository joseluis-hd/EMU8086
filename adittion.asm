org 100h
    MOV AL, 04h
    MOV BL, 05h
    ADD AL, BL   ; AX = AX + BX
    
    MOV AX, 0404h
    MOV BX, 0505h
    ADD AX, BX   ; AX = AX + BX
   
ret
