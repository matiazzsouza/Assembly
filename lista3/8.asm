.model small
.stack 0100h
Push_all macro          ; Macro para push em todos os registradores

             push ax
             push BX
             push cx
             push Dx
             push si
             push di
endm

pop_all macro         ; Macro para pop em todos os registradores
            pop di
            pop si
            pop dx
            pop cx
            pop bx
            pop ax
endm

pular MACRO
       
          push ax
          push dx
        
          mov  ah, 2
          mov  dl, 10
          int  21h

          pop  dx
          pop  ax

ENDM


xor_all MACRO
            xor ax,ax
            xor bx,bx
            xor cx, cx
            xor dx,dx

ENDM
.data
    
    nmatriz db 'matriz : $',10,13
    novamat db 'matriz trocada: $',10,13

    matriz  dw 1,2,3,4
            dw 4,5,6,7
            dw 8,9,0,1
            dw 2,3,4,5

.code




main PROC
    
                 mov      ax, @data
                 mov      ds, ax

                 call     limpa
                 call     print_matriz
                 call     mover
                 
                 mov      ah, 4ch
                 int      21h

main ENDP



print_matriz PROC

                 Push_all
    
                 mov      ah, 9
                 lea      dx, nmatriz
                 int      21H

                 pular
                 xor_all

                 xor      di, di
                 mov      di, 4
                 mov      ah, 2

    subir:       
                 xor      si,si
                 mov      cx, 4

    coluna:      
                 mov      dx, matriz[bx + si]
                 add      dl, '0'
                 int      21H
                 add      si, 2
                 loop     coluna

    linha:       
                 pular
                 add      bx, 8
                 dec      di
                 jnz      subir

                 pop_all
                 ret
    
print_matriz ENDP



mover PROC
    
                 Push_all

    
    
                 mov      ah, 9
                 lea      dx, novamat
                 int      21h


                 xor_all
                 xor      si, si
    
                 mov      cx, 4

    troks:       
                 mov      bx, 16
                 mov      ax, matriz[bx][si]
                 mov      bx, 24
                 xchg     ax, matriz[bx][si]
                 mov      bx, 16
                 mov      matriz[bx][si], ax
                 add      si, 2
                 loop     troks

                 call     print_matriz

    fora:        
                 pop_all
                 ret


mover ENDP





limpa PROC
                 Push_all

                 mov      ah, 0
                 mov      al, 3
                 int      10h


                 pop_all
                 ret
    
limpa ENDP

end main