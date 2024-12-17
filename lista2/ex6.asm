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

    vetor db 8 dup(?)


    escrev db 'soma do vetor => $'

.code

main PROC

          mov      ax, @data
          mov      ds, ax
    
          mov      ah, 9
          lea      dx, escrev
          int      21h

          call     soma_vet

          mov      ah, 4ch
          int      21h
    
main ENDP


soma_vet PROC
    Push_all
    xor_all

    lea di, vetor

    mov ah, 1
    mov cx, 8

    print:
    int 21h
    cmp al, 0dh
    je fora
    sub al, '0'
    mov [di], al
    add dl, [di]
    inc di
    loop print

    fora:
    mov ah, 2
    add dl, '0'
    int 21h


    pop_all
    ret    
soma_vet ENDP


end main