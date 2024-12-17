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

    vet         db 7,5,3,6,0,1,2,9,1,2
    msg         db 'ordem correta $'
    msg2        db 'ordem normal $'
    

.code

main PROC

              mov      ax, @data
              mov      ds, ax

                mov ah, 9
                lea dx, msg2
                int 21h

              call     print_vet
              call     ordenar

              mov      ah, 4ch
              int      21h
main ENDP


print_vet PROC

              Push_all
              xor_all

              xor      si, si

              lea      si, vet

              mov      cx, 10

    print:    
              mov      dl, [si]
              mov      ah, 2
              add      dl, '0'
              int      21h
              inc      si
              loop     print

              pop_all
              ret
print_vet ENDP



ordenar PROC
              Push_all
            
        
                pular
            mov ah, 9
            lea dx, msg
            int 21H
        
        
              xor_all

              lea      di, vet
            

              mov      cx, 30
    sobe:     
              xor      di, di

    mover:    
              MOV      AL, [DI]
              inc      di
              cmp      AL, [di]
              ja       muda
              jmp      mover

    muda:     
              xchg     al, [di]
              mov      [di - 1], al
              loop     sobe
            

    fim:      
              call     print_vet
              pop_all
              ret
    
ordenar ENDP


end main