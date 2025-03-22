;File Manager
;@joseluis-hd
org 100h
jmp inicio

    ;Declaracion de variables
    crearDirectorio DB "C:\emu8086\MyBuild\Jose", 0
    directorioInicial DB "C:\emu8086\MyBuild", 0   
    rutaCompleta DB "EMU8086\MYBUILD\JOSE$", 0  
    nombre DB "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$", 0
    archivo DB "C:\emu8086\MyBuild\Jose\Haro.txt", 0  
    fecha DB "$$/$$/$$$$$", 0
    dia DB ?
    mes DB ?
    anio DW ?
    uDia DB ?
    dDia DB ?
    uMes DB ?
    dMes DB ?
    uAnio DB ?
    dAnio DB ?
    cAnio DB ?
    mAnio DB ?
    handle DW 0

inicio:
    ;Crear el directorio
    mov AH, 39h
    mov DX, offset crearDirectorio
    int 21h

    ;Entrar en el directorio
    mov AH, 3Bh
    mov DX, offset crearDirectorio
    int 21h

    ;Mostrar la ruta completa manualmente
    lea DX, rutaCompleta   ;Cargar la ruta manualmente en DX
    mov AH, 9h             ;Funcion para mostrar cadena
    int 21h                ;Mostrar en pantalla

    ;Crear archivo
    mov CX, 00h
    mov DX, offset archivo
    mov AH, 3Ch
    int 21h
    mov handle, AX

    ;Obtener fecha del sistema
    mov AH, 2Ah
    int 21h
    mov anio, CX
    mov mes, DH
    mov dia, DL

    ;Convertir dia
    xor AX, AX
    xor BX, BX
    mov AL, dia
    mov BL, 10
    div BL
    mov uDia, AH
    add uDia, 30h
    mov dDia, AL
    add dDia, 30h

    ;Convertir mes
    xor AX, AX
    xor BX, BX
    mov AL, mes
    mov BL, 10
    div BL
    mov uMes, AH
    add uMes, 30h
    mov dMes, AL
    add dMes, 30h

    ;Convertir ano
    xor AX, AX
    mov AX, anio
    mov BL, 10
    div BL
    mov uAnio, AH
    add uAnio, 30h
    xor AH, AH
    div BL
    mov dAnio, AH
    add dAnio, 30h
    xor AH, AH
    div BL
    mov cAnio, AH
    add cAnio, 30h
    mov mAnio, AL
    add mAnio, 30h

    ;Insertar resultados en la cadena
    xor BX, BX
    mov AL, dDia
    mov fecha[BX], AL
    inc BX
    mov AL, uDia
    mov fecha[BX], AL
    add BX, 2
    mov AL, dMes
    mov fecha[BX], AL
    inc BX
    mov AL, uMes
    mov fecha[BX], AL
    add BX, 2
    mov AL, mAnio
    mov fecha[BX], AL
    inc BX
    mov AL, cAnio
    mov fecha[BX], AL
    inc BX
    mov AL, dAnio
    mov fecha[BX], AL
    inc BX
    mov AL, uAnio
    mov fecha[BX], AL

    ;Escribir la fecha en el archivo
    mov AH, 40h
    mov BX, handle
    mov CX, 0Ah
    mov DX, offset fecha
    int 21h

    ;Cerrar el archivo
    mov AH, 3Eh
    mov BX, handle
    int 21h

    ;Volver al directorio inicial
    mov AH, 3Bh
    mov DX, offset directorioInicial
    int 21h

ret