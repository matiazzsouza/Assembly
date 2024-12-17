  .model small
  .stack 100h
pop_all macro         ; Macro para pop em todos os registradores
            pop di
            pop si
            pop dx
            pop cx
            pop bx
            pop ax
endm

Push_all macro          ; Macro para push em todos os registradores

             push ax
             push BX
             push cx
             push Dx
             push si
             push di
endm

xor_all MACRO
            xor ax,ax
            xor bx,bx
            xor cx, cx
            xor dx,dx

ENDM

pular MACRO

          push_all
          mov      ah, 2
          mov      dl, 10
          int      21h
          pop_all
ENDM

.data

    matriz     db 1,2,3
               db 4,5,6
               db 7,8,9

    msg        db 'matriz 1 = $'
    msg2       db 'matriz 2 = $'
    msg3       db 'soma das matrizes = $'

    matrizsoma db 16 dup (?)

.code


    ;description
main PROC   

        mov ax, @data
        mov ds, ax
    
    call printmatriz
                ;call     matriztrans

                mov      ah, 4ch
                int      21h

main ENDP

    ;description
printmatriz PROC

    push_all
        pular
    xor_all
    xor di, di
    mov di, 3

    sube:
        mov cx,3
        xor si, si
    coluna:
        mov dl, matriz[bx][si]
        mov ah, 2
        add dl, '0'
        int 21h
        inc si
        loop coluna
    linha:
    pular
    add bx, 4
    dec di
    jnz sube


    pop_all
    
                ret
printmatriz ENDP

matriztrans PROC

                push_all

                xor_all
                xor      di, di
                mov di, 3

    ter:        
                mov      cx, 1
                mov      si, 2
                mov      bx, 8
                jmp      muda

    segs:       
                mov      cx, 2
                mov      si, 1
                mov      bx, 4
                jmp      muda

    muda:       
                inc      si
                mov      al, matriz[bx][si]
                dec      si
                add      bx, 4
                xchg     al, matriz[bx][si]
                inc      si
                sub bx, 4
                mov      matriz[bx][si], al
                loop     muda

                dec di
                cmp di, 2
                je segs
            
                call printmatriz
                JMP fora

zera:
    xor si, si
                fora:
                pop_all
                ret
matriztrans ENDP

end main

