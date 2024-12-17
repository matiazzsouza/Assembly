        .model small
        .stack 0100h
        pop_all macro                 ; Macro para pop em todos os registradores
                        pop di
                        pop si
                        pop dx
                        pop cx
                        pop bx
                        pop ax
        endm

        xor_all MACRO
                        xor ax,ax
                        xor bx,bx
                        xor cx, cx
                        xor dx,dx

        ENDM

        Push_all macro                  ; Macro para push em todos os registradores
                        push ax
                        push BX
                        push cx
                        push Dx
                        push si
                        push di
        endm

.data
        msg         db 50 dup(?),'$'
        msg3        db 50 dup(?),'$'
        str1        db 'escreva seu nome $',10,13
        msg2        db 10,13,'o seu nome eh -> $'
        msg4        db 10,13,'o nome copiado eh -> $'
        sim         db 10,13,'eh o mesmo nome $'
        nao         db 10,13,'nao eh o mesmo nome $'
        criei       db 'mateus $'
        contadordeA db 10,13,'o numero de letras A eh de -> $'

.code
    
main PROC

                 mov     ax, @data
                 mov     es, ax
                 mov     ds, ax                 ;para usar as funções de string
        
                 mov     ah, 9
                 lea     dx, str1
                 int     21h

                 call    leia
                 call    copia
        call    compara
        call    letraA
                 

                 mov     ah, 9
                 lea     dx, msg2
                 int     21h

                 lea     dx, msg
                 int     21h

                 lea     dx, msg4
                 int     21h

                 lea     dx, msg3
                 int     21h

                 mov     ah, 4ch
                 int     21h

main ENDP

    
leia PROC

                 lea     di, msg                ; stosb so funciona com di e ja incrementa di com o cld
                 cld
                 mov     ah, 1
        ler:     
                 int     21h
                 cmp     al, 0dh
                 je      fim
                 cmp     al, 8h
                 je      ex
                 stosb                          ;substitui no vetor
                 inc     bx
                 loop    ler
          

        ex:      
                 dec     di
                 jmp     ler

        fim:     
                 ret
leia ENDP

copia PROC
                
                 push    bx
                 xor_all
                 xor     si, si
                 xor     di, di

                 pop     bx
                 lea     si, msg  + bx  - 1            ; aponta para a string original
                 lea     di, msg3               ;aponta para o destino que sera trocado os valores do string

                 std
                 mov     cx, bx                 ; qunatidade de letras usadas no nome
        loops:   
                 movsb                          ;copia de um string para outro
                 add di, 2
                 loop    loops


                 ret
copia ENDP

compara PROC
                
                 cld

                 lea     si,msg
                 lea     di, criei
                
                 mov     cx, bx
                
        faz:     
                 cmpsb                          ;compara letra por letra dos dois vetores( strings)
                 jne     dif                    ;caso seja diferente ele ja fala que nao sao iguais
                 loop    faz

                 mov     ah, 9
                 lea     dx, sim
                 int     21h
                 jmp     fim1
        dif:     
                 mov     ah, 9
                 lea     dx, nao
                 int     21h
                
        fim1:    
                 ret
compara ENDP


letraA PROC
                
                 push    BX                     ;usando do primeiro proc

                 xor_all

                 xor     di, di
                 lea     di, msg
                 pop     BX
                 MOV     cx, bx
                 xor     bx, bx
        

        compar:  
                 mov     al, [di]
                 cmp     al, 61h
                 je      contador
                 cmp     al, 41h
                 je      contador
                 inc     di
                 loop    compar
                 jmp     fim3
                
        contador:
                 INC     di
                 inc     bx
                 loop    compar


        fim3:    
                 mov     ah, 9
                 lea     dx, contadordeA
                 int     21h

                 mov     dx, bx
                 add     dx, 30h
                 mov     ah, 2
                 int     21h

                 ret

                 
letraA ENDP
end main