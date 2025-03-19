;Suma de numeros de 3 digitos
;@joseluis-hd 
.model small
.stack
.data
    msg1 db "Ingrese el primer numero de 3 digitos: $"
    msg2 db "Ingrese el segundo numero de 3 digitos: $"
    result_msg db "Resultado = $"
    num1 db 3 dup(?)
    num2 db 3 dup(?)
    sum_result db 4 dup(0), '$' ;Cuatro espacios para la posible cifra con acarreo

.code
main PROC
    ;Configurar segmento de datos
    MOV AX, @data
    MOV DS, AX
    
    ;Mostrar mensaje 1
    MOV DX, OFFSET msg1
    MOV AH, 09h
    INT 21h
    
    ;Leer primer numero
    MOV SI, OFFSET num1
    MOV CX, 3
input1:
    MOV AH, 01h
    INT 21H
    MOV [SI], AL
    INC SI
    LOOP input1
    
    ;Salto de línea
    MOV DL, 0Dh
    MOV AH, 02h
    INT 21h
    MOV DL, 0Ah
    INT 21h
    
    ;Mostrar mensaje 2
    MOV DX, OFFSET msg2
    MOV AH, 09h
    INT 21h
    
    ;Leer segundo numero
    MOV SI, OFFSET num2
    MOV CX, 3
input2:
    MOV AH, 01h
    INT 21H
    MOV [SI], AL
    INC SI
    LOOP input2
    
    ;Salto de línea
    MOV DL, 0Dh
    MOV AH, 02h
    INT 21h
    MOV DL, 0Ah
    INT 21h
    
    ;Realizar la suma (convertir de ASCII a numeros y viceversa)
    MOV SI, OFFSET num1 + 2    ;Apuntar al ultimo dígito del primer numero
    MOV DI, OFFSET num2 + 2    ;Apuntar al ultimo dígito del segundo numero
    MOV BX, OFFSET sum_result + 3 ; Apuntar al ultimo lugar del resultado
    MOV CH, 0  ; Acarreo

add3:
    MOV AL, [SI]  ;Obtener digito del primer numero
    SUB AL, 30h   ;Convertir de ASCII a numero
    MOV DL, [DI]  ;Obtener dígito del segundo numero
    SUB DL, 30h   ;Convertir de ASCII a número
    ADD AL, DL    ;Sumar los digitos
    ADD AL, CH    ;Anadir acarreo previo
    CMP AL, 10
    JB no_carry
    SUB AL, 10
    MOV CH, 1  ;Acarreo
    JMP store_digit

no_carry:
    MOV CH, 0  ;Sin acarreo

store_digit:
    ADD AL, 30h   ;Convertir de numero a ASCII
    MOV [BX], AL  ;Almacenar en el resultado
    DEC SI
    DEC DI
    DEC BX
    CMP SI, OFFSET num1 - 1
    JNE add3
    
    ;Si hay un acarreo final, añadir '1' al principio
    CMP CH, 1
    JNE print_result
    MOV BYTE PTR [BX], '1'
    
print_result:
    ;Mostrar salto de línea
    MOV DL, 0Dh
    MOV AH, 02h
    INT 21h
    MOV DL, 0Ah
    INT 21h
    
    ;Mostrar el mensaje de resultado
    MOV DX, OFFSET result_msg
    MOV AH, 09h
    INT 21h
    
    ;Mostrar el resultado
    LEA DX, sum_result
    MOV AH, 09h
    INT 21h
    
    ;Salir del programa
    MOV AH, 4Ch
    INT 21H
    
main ENDP
END
