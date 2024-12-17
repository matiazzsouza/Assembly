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

    matriz     db 1,2,3,4
               db 5,6,3,1
               db 4,0,1,2
               db 3,4,5,6

    matriz1    db 6,5,4,3
               db 2,1,4,6
               db 3,7,6,5
               db 4,3,2,1

    msg        db 'matriz 1 = $'
    msg2       db 'matriz 2 = $'
    msg3       db 'soma das matrizes = $'

    matrizsoma db 16 dup (?)

.code


main PROC
    

                mov      ax, @data
                mov      ds, ax

                call     printmatriz
                call     soma
                call     printsoma

                mov      ah,  4ch
                int      21h
    
main ENDP


printmatriz PROC
                push_all

                lea      dx, msg
                mov      ah, 9
                int      21h
                pular

                xor_all
                xor      di, di

                mov      di, 4
                mov      ah, 2

    sube:       mov      cx, 4
                xor      si, si

    print:      mov      dl, matriz[bx][si]
                add      dl, '0'
                int      21h
                sub      dl, '0'
                inc      si
                loop     print

    linha:      pular
                add      bx, 4
                dec      di
                jnz      sube
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                pular
                lea      dx, msg2
                mov      ah, 9
                int      21h
                pular
                xor_all
                xor      di, di

                mov      di, 4
                mov      ah, 2

    sube1:      mov      cx, 4
                xor      si, si

    print1:     mov      dl, matriz1[bx][si]
                add      dl, '0'
                int      21h
                sub      dl, '0'
                inc      si
                loop     print1

    linha1:     pular
                add      bx, 4
                dec      di
                jnz      sube1


                pop_all
                ret
printmatriz ENDP


soma PROC
                push_all


                xor_all
                xor      di, di
                mov      di, 4

    subir:      
                xor      si, si
                mov      cx, 4
    coluna:     
                xor      al, al
                add      al, matriz[bx][si]
                add      al, matriz1[bx + si]
                mov      matrizsoma[bx + si], al
                inc      si
                loop     coluna
    linhas:     
                add      bx, 4
                dec      di
                jnz      subir



                pop_all
                ret
soma ENDP

printsoma PROC
                push_all

                pular

                lea      dx, msg3
                mov      ah, 9
                int      21h

                pular

                xor_all
    
                xor      di, di
                mov      di, 4

    sobe:       
                mov      cx, 4
                xor      si, si
                mov      ah, 2
    prints:     

                mov      dl, matrizsoma[bx][si]
                add      dl, '0'
                int      21h
                inc      si
                loop     prints
    pulas:      
                pular
                add      bx, 4
                dec      di
                jnz      sobe
    
    
                pop_all
                ret
printsoma ENDP



end main
