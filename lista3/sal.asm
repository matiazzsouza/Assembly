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

    matriz dw 1,2,3,4
           dw 5,6,7,8
           dw 9,0,1,2
           dw 3,4,5,6

.code

main PROC

                 mov      ax, @data
                 mov      ds, ax

                 call     limpa
                 call     print_matriz

                
                 mov      ah, 4ch
                 int      21h
      
main ENDP

    ;description
print_matriz PROC

                 push_all

                 xor_all

                 xor      di,di
                 pular

    suba:        
                 mov      cx, 4
                 xor      si,si

    print:       
                 mov      dx, matriz[bx][si]
                 mov      ah, 2
                 add      dl, '0'
                 int      21h
                 sub      dl, '0'
                 add      si, 2
                 loop     print

                 pular
                 inc      di
                 mov      ax, di
                 mov      bx, 8
                 mul      bx
                 xchg     ax, bx
                 cmp      di, 4
                 jne      suba


    fora:        
                 pop_all
                 ret
    
print_matriz ENDP

limpa PROC

                 Push_all

                 mov      ah, 0
                 mov      al, 3
                 int      10h

                 pop_all

                 ret
limpa ENDP

  end main