.model small
.stack 0100h

pular macro 

    Push_all
    mov dl, 10
    mov ah, 2
    int 21h
    pop_all

endm


Push_all macro 

    push ax
    push bx
    push cx
    push dx 
    push si
    push di
endm

pop_all macro

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax

endm


xor_all macro

    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx

endm

xor_mem macro

    xor di, di
    xor si, si

endm

.data

    nome db 20 dup(?)
    tam equ 20
    qnt db 'quantidade de letras A -> $'
    msg db 'digite um nome ate 20 letras $'
    letra db 'a $'

.code

main PROC

    mov ax, @data
    mov ds, ax
    mov es, ax

    mov ah, 9
    lea dx, msg
    int 21h

    call conta

    mov ah, 4ch
    int 21h
    
main ENDP

;description
escrever PROC
    
escrever ENDP



conta PROC
    Push_all

    xor_all


    lea di, letra
    lea si, nome


    mov ah, 1
    escreve:
    int 21h
    cmp al, 0dh
    je lops
    inc cx 
    mov [si], al
    inc si
    jmp escreve

    lops:
    xor si, si
    cld

    saia:
    cmpsb
    je contador
    dec di
    loop saia
    jmp print
    
    contador:
        inc dx
        dec di
        loop saia

        
    print:
        push dx
        pular
        mov ah, 9
        lea dx, qnt
        int 21h

        pop dx
        add dl, '0'
        mov ah, 2
        int 21h


    fora:
    pop_all
    ret
conta ENDP

end main