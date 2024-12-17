.model small
.stack 0100h
pop_all macro         ; Macro para pop em todos os registradores
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

pular MACRO

          push_all
          mov      ah, 2
          mov      dl, 10
          int      21h
          pop_all
ENDM
Push_all macro          ; Macro para push em todos os registradores
             push ax
             push BX
             push cx
             push Dx
             push si
             push di
endm
.data

    msg  db 'digite um numero: $', 10,13
    res  db 'o resultado eh -> $'
.code
main PROC

            mov      ax, @data
            mov      ds, ax
        
            call     somador

            mov      ah, 4ch
            int      21h

main ENDP

somador PROC

            Push_all

            mov      ah, 9
            lea      dx, msg
            int      21h
    
            xor_all

            mov      ah, 1
            int      21h
            sub      al, '0'
            push     ax

            pular

            mov      ah, 9
            lea      dx, msg
            int      21h

            xor_all

            mov      ah, 1
            int      21h
            sub      al, '0'

            pop      cx

    lops:   
            add      dl, al
            dec      cl
            jnz      lops
            push dx

            pular
            mov      ah, 9
            lea      dx, res
            int      21h

            pop dx
            mov      ah, 2
            add      dl, '0'
            int      21h

            pop_all
            ret
    
somador ENDP

end main