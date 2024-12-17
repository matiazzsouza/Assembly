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

    vetor   db 1,2,3,4,5,6,7,8,9, 1, 2 , 3, 4, 5, 6, 2, 2
    pares   db 'pares -> $'
    impares db 'impares -> $'


.code


main PROC

            MOV      ax, @data
            mov      ds, ax

            call     compara

            mov      ah, 4ch
            int      21h

    
main ENDP

compara PROC
            Push_all
            xor_all

            lea      di, vetor
        
            mov      cx, 17

    mover:  
            mov      al, [di]
            shr      al, 1
            jc       impar
            inc      di
            inc      Dh
            loop     mover
            jmp      lops

    impar:  
            inc      dl
            inc      di
            loop     mover
            
    lops:
            Push_all
            mov      ah, 9
            lea      dx, impares
            int      21h
            pop_all

            mov      ah, 2
            add      dl, '0'
            int      21h

            xchg     dl, Dh

            Push_all
            pular
            mov      ah, 9
            lea      dx, pares
            int      21h
            pop_all

            mov      ah, 2
            add      dl, '0'
            int      21h
            

            pop_all
            ret
compara ENDP
    
end main