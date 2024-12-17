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

    msg db 'abcdefg123'
    alfabets db 'abcdefghijklmnopqrstuvwxyz'
    numerets db '0123456789 $'

.code


main PROC

    mov ax, @data
    mov ds, ax
    mov es, ax

    call verifica

main ENDP


verifica PROC
    Push_all
    xor_all
    xor si, si

    lea si, alfabets
    lea di, msg

    cld


    sube:
    xor di, di
    mov cl, 9

    lops:
    cmpsb
    je letra
    dec si
    dec cl
    jnz lops 
    volta:
    inc si
    inc ch
    cmp ch, 25
    jne sube
    jmp sai

    letra:
        inc dh
        jmp volta

sai:

        xor di, di
        xor si, si
        xor cx, cx

        lea si, numerets
        lea di, msg

    subiu:
        xor di, di
        mov cl, 9

        lops1:
    cmpsb
    je nume1
    dec si
    dec cl
    jnz lops1
    volta1:
    inc si
    inc ch
    cmp ch, 9
    jne subiu
    jmp saia

    nume1:
        inc dl
        jmp volta1


    saia:


    pop_all
    ret
verifica ENDP



end main