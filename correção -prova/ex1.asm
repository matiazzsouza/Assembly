model small 
.stack 0100h
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
pular macro
    push_all

    mov ah, 2
    mov dl, 10
    int 21h

    pop_all

endm

.data 
 n equ 3
 M1 db 0,1,2
 db 2,1,0
 db 1,3,1
 M2 db n dup ( n dup (?)) 
 
.code 
main PROC
 mov ax,@data 
 mov ds,ax
 lea si,M1 
 lea di,M2 
 call q1 
 mov ah,4ch
 int 21h
main ENDP
q1 PROC
 ; n X n é o tamnho da matriz
 ; si aponta para a matriz original M1
 ; di aponta para M2
 ; bx é a coluna de ambas as natrizes
 xor ax, ax ; dividendo
 xor dx,dx ; somatória
 xor bx,bx
 mov cx,n
 push si
; calcula somatória da diagonal
soma: 
 add dl, [si][bx] 

 inc bx
loop soma 
; calcula M2
 pop si
mov cl,n 
linha: 
 mov ch,n 
 xor bx,bx
coluna: 
 mov al, [si][bx] 
 div dl
 mov [di][bx],al
 inc bx
 dec ch
 jnz coluna 
 add si,n 
 add di,n 
 dec cl
 jnz linha 


 mov ah, 2
mov cl,n 
linha1: 
 mov ch,n 
 xor bx,bx
coluna1: 
 mov dl, [si][bx] 
 add dl, '0'
 int 21h
  inc bx
 dec ch
 jnz coluna1
 pular
  add si,n 
 dec cl
 jnz linha1 

 ret
q1 ENDP
end main