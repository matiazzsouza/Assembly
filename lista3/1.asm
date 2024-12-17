.model small
.stack 100h
pop_all macro                 ; Macro para pop em todos os registradores
                pop di
                pop si
                pop dx
                pop cx
                pop bx
                pop ax
endm

Push_all macro                  ; Macro para push em todos os registradores

                 push ax
                 push BX
                 push cx
                 push Dx
                 push si
                 push di
endm

.data

    msg db ' digite um numero $',10,13
    vet db 10 dup(?)
    vetor db 1, 3, 4, 5, 8, 6, 5, 0, 65, 33, 111
    qnt db 'numeros maiores ou igual a 15 -> $'
    
.code 

main PROC

    mov ax, @data
    mov ds, ax

    call verifica 

    mov ah, 4ch
    int 21h

main ENDP


verifica PROC

    Push_all

    lea di, vetor 

    mov cx, 11
    
    comp:
    mov al, [di]
    cmp al, 15
    jae maior
    inc di
    loop comp
    jmp fim

    maior: 
        inc bx
        inc di
        loop comp

    fim:

        mov ah, 9
        lea dx, qnt
        int 21h

        mov dx, bx
        add dx, 30h
        mov ah, 2
        int 21h

    pop_all
    ret
verifica ENDP

end main

