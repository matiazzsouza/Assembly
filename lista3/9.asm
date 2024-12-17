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
    msg  db 'Quantos numeros voce deseja exibir -> $'
    msg2 db 10, 13, 'Sequencia que pediu: $'

.code
main PROC

                mov      ax, @data
                mov      ds, ax

                call     limpa
                call     fib

                mov      ah, 4ch
                int      21h
    
main ENDP

fib PROC
                xor_all

                mov      ah, 9
                lea      dx, msg
                int      21h
         

                mov      ah, 1
                int      21h
                sub      al, '0'
                mov      cl, al

                mov      ah, 9
                lea      dx, msg2
                int      21h

                mov      dl, 0
                mov      bl, 1

    lops:       
                
                call     print_maior10

                add      dl, bl
                xchg     dl,bl
                loop     lops
                jmp      fim

    fim:        
                ret
fib ENDP


print_maior10 PROC

                push     cx
                push     bx
                xor      di,di
    
    print10:    

                pular

                
                mov      bl, 10
                
                mov      ax, dx
                push     dx
    mais:       

                xor      dx,dx

                inc      di

                div      BX

                push     dx

                cmp      al, 0

                je       fims

            

                jmp      mais


    fims:       

                pop      dx

                add      dl, '0'

                mov      ah, 2

                int      21h

                sub      dl, '0'

                dec      di
                jnz      fims


    fim2:       
        
        
                pop      dx
                pop      bx
                pop      cx
                ret
    
print_maior ENDP


limpa PROC

                Push_all

                mov      ah, 0
                mov      al, 3
                int      10h

                pop_all
                ret

limpa ENDP

end main
