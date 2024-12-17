  .model small
  .stack 100h
pop_all macro     ; Macro para pop em todos os registradores
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
endm

Push_all macro      ; Macro para push em todos os registradores

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

  matriz dw 1,2
         dw 3,4
         
    
  msg    db 'matriz: $',10,13
  msg2   db 'matriz tranposta: $',10,13

.code

main PROC

               mov      ax, @data
               mov      ds, ax

   call     limpa
     call     print_matriz
               call     matriztrans

                
               mov      ah, 4ch
               int      21h
      
main ENDP



print_matriz PROC

               push_all

               mov      ah, 9
               lea      dx, msg
               int      21h

               pular

               xor_all
                
               xor      di,di
                 
               mov      di, 2

  suba:        

               mov      cx, 2
               xor      si,si

  print:       
               mov      dx, matriz[bx][si]
               add      dl, '0'
               mov      ah, 2
               int      21h
               sub      dl, '0'
               add      si, 2
               loop     print
     
  pula_linha:  

               pular
               add      bx, 4
               dec      di
               jnz      suba

               pular
               pop_all
               ret
print_matriz ENDP


  ;description
matriztrans PROC

               push_all

               mov      ah, 9
               lea      dx, msg2
               int      21H

               pular
               xor_all
               xor      si, si
               add      si, 2
               mov      ax, matriz[bx][si]
               add      bx, 4
               mov      si, 0
               xchg     matriz[bx][si], ax
               xor      bx,bx
               add      si, 2
               mov      matriz[bx][si],ax

               call     print_matriz

               pop_all
               ret

  
matriztrans ENDP



limpa PROC

               Push_all

               mov      ah, 0
               mov      al, 3
               int      10h

               pop_all

               ret
limpa ENDP


  end main