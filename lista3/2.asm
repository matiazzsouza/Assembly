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

  matriz    dw 5,4,4,7
            dw 3,3,3,3
            dw 3,3,2,4
            dw 3,3,3,3
    
  msg       db 'matriz: $',10,13

  msg_maior db 'o maior valor da matriz: $'
  msg_menor db 'o menor valor da matriz: $'


.code

main PROC

              mov      ax, @data
              mov      ds, ax

              call     limpa
              call     print_mat
              call     maior
              call     menor
                
              mov      ah, 4ch
              int      21h
      
main ENDP



print_mat PROC

              push_all

              LEA      DX, msg
              MOV      AH,09
              INT      21H

              pular

              MOV      AH,2
              MOV      DI,4
  L2:         
              xor      si,si
              MOV      CX,4

  L3:         
              MOV      DX, MATRIZ [BX][SI]
              add      dl, '0'
              INT      21H

              ADD      SI,2
              LOOP     L3


              pular
              ADD      BX,8
              DEC      DI
              JNZ      L2

              pop_all
              ret
print_mat ENDP



maior PROC
  
              push_all
              xor_all
              
              mov      si, 4

  sube:       
              xor      di,di
              mov      cx, 4

  comp_maior: 
              xor      ax,ax
              mov      ax, matriz[bx][di]
              add      di, 2
              cmp      dx, ax
              jb       maiores
              loop     comp_maior

  pula_linha: 
              add      bx, 8
              dec      si
              jnz      sube
              jmp      saia

  maiores:    
              mov      dx, ax               ;bx tera o maior valor
              loop     comp_maior
              jmp      pula_linha


  saia:       

              pular
            
              push     dx
              mov      ah, 9
              lea      dx, msg_maior
              int      21h
              pop      dx
              


              add      dx, '0'
              mov      ah, 2
              int      21h

              pop_all
              ret
maior ENDP


menor PROC

              push_all
              xor_all
              mov      si, 4
              mov      dx, 0ffh

  subir:      
              xor      di,di
              mov      cx, 4

  comp_menor: 
              xor      ax,ax
              mov      ax, matriz[bx][di]
              add      di, 2
              cmp      dx, ax
              ja       menores
              loop     comp_menor

  pula_linhas:
              add      bx, 8
              dec      si
              jnz      subir
              jmp      saias

  menores:    
              mov      dx, ax               ;bx tera o maior valor
              loop     comp_menor
              jmp      pula_linhas


  saias:      

              pular
            
              push     dx
              mov      ah, 9
              lea      dx, msg_menor
              int      21h
              pop      dx
              


              add      dx, '0'
              mov      ah, 2
              int      21h

              pop_all

              ret
menor ENDP

limpa PROC

              Push_all

              mov      ah, 0
              mov      al, 3
              int      10h

              pop_all

              ret
limpa ENDP


  end main