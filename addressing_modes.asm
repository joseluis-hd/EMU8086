;Addressing Modes in EMU8086  
;@joseluis-hd  

ORG 100h  
        JMP start  ;Jump over variable declarations  

;Variables used in direct addressing  
var1 DB 40H  
var2 DB 50H  

;Array for indexed addressing  
arr DB 10H, 20H, 30H, 40H, 50H  

start:  
    ;Register addressing  
    MOV AL, 05H              ;Load an arbitrary value into AL  
    MOV BL, AL               ;Copy the value from AL to BL  
    ADD BL, 03H              ;Add 03H to BL  

    ;Immediate addressing  
    MOV CL, 0AH              ;Load the immediate value 0AH into CL  

    ;Direct addressing  
    MOV AL, var1             ;Load the value of var1 (40H) into AL  
    ADD AL, var2             ;Add the value of var2 (50H) to AL  

    ;Indirect register addressing  
    MOV SI, OFFSET var1      ;Load the address of var1 into SI  
    MOV AL, [SI]             ;Load the value pointed by SI (var1) into AL  

    ;Base plus index addressing  
    MOV BX, OFFSET arr       ;Load the base address of the array into BX  
    MOV SI, 02H              ;Index = 2 (third element of the array)  
    MOV AL, [BX + SI]        ;Load the value of arr[2] into AL (30H)  

    ;Register relative addressing  
    MOV BX, OFFSET arr       ;Load the base address of the array into BX  
    MOV AL, [BX + 03H]       ;Access the fourth element of the array (40H)  

    ;Base relative plus index addressing  
    MOV BX, OFFSET arr       ;Load the base address of the array into BX  
    MOV SI, 01H              ;Index = 1 (second element of the array)  
    MOV AL, [BX + SI + 01H]  ; Base + index + displacement = third element (30H)  

    ;Scaled index addressing  
    MOV BX, OFFSET arr       ;Load the base address of the array into BX  
    MOV SI, 02H              ;Index = 2 (third element)  
    ;Scale simulation (on architectures that support words/double words)  
    SHL SI, 1                ;Multiply SI by 2 (simulating word scaling)  
    MOV AL, [BX + SI]        ;Access the scaled element in the array  

    ;HLT to stop execution in a .COM file  
    HLT  
