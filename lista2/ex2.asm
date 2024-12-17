.model small
.stack 0100h

pular macro

          Push_all
          mov      dl, 10
          mov      ah, 2
          int      21h
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

    matriz db 1,2,3,4
           db 5,6,7,8
           db 9,0,1,2
           db 3,4,5,6
            
    escrev   db 'diag. principal $'

.code

main PROC

          mov      ax, @data
          mov      ds, ax
    
          mov      ah, 9
          lea      dx, escrev
          int      21h  

          call     escre

          mov      ah, 4ch
          int      21h
    
main ENDP


escre PROC
    
          Push_all
          xor_all
            xor di, di
            mov di, 4
            xor si, si
            add si, 3

        print:
            mov dl, matriz[bx][si] 
            add dl, '0'
            mov ah, 2
            int 21h

        diag:
            dec si
            add bx, 4
            dec di
            jnz print

          pop_all
          ret
escre ENDP

end main