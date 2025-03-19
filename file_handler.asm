;File handler
;@joseluis-hd
org 100h  

        jmp inicio
        archivo db "C:\emu8086\MyBuild\jose.txt",0      ;Nombre del archivo
        texto1 db "Parangaricutirimicuaro",0           ;Primera cadena
        texto2 db "hipopotomonstrosesquipedaliofobia",0 ;Segunda cadena
        handle dw 0                                     ;Handle del archivo

inicio:
        ;1 y 2. Crear y abrir el archivo   
        
        mov CX,0                  ;Fichero normal
        mov DX,offset archivo     ;Direccion del nombre del archivo
        mov AH,3Ch                ;Funcion 3Ch: Crear archivo
        int 21h
        mov handle,AX             ;Guardar el handle del archivo en 'handle'
    
        ;3. Escribir "Parangaricutirimicuaro" en el archivo
        
        mov AH,40h                ;Funcion 40h: Escritura en archivo
        mov BX,handle             ;Cargar handle del archivo
        mov CX,17h                ;Longitud de la cadena (22 bytes)
        mov DX,offset texto1      ;Direccion de la primera cadena
        int 21h
    
        ;3. Escribir "hipopotomonstrosesquipedaliofobia" en el archivo
        
        mov AH,40h                ;Funcion 40h: Escritura en archivo
        mov BX,handle             ;Cargar handle del archivo
        mov CX,21h                ;Longitud de la cadena (37 bytes)
        mov DX,offset texto2      ;Direccion de la segunda cadena
        int 21h                        
        
        ;4. Mostrar los atributos del archivo (en CX)
        
        mov AH,43h                ;Funcion 43h: Obtener atributos
        mov AL,00h                ;Subfuncion: Obtener atributos
        mov DX,offset archivo     ;Direccion del archivo
        int 21h
    
        ;5. Cierre del archivo
        
        mov AH,3Eh                ;Funcion 3Eh: Cerrar archivo
        mov BX,handle             ;Cargar handle del archivo
        int 21h    
    
        ;6. Eliminacion del archivo
        
        mov AH,41h                ;Funcion 41h: Borrar archivo
        mov DX,offset archivo     ;Direccion del archivo
        int 21h
    
        ;Terminar programa
        mov AH,4Ch                ;Funcion 4Ch: Terminar programa
        int 21h
        
ret            