.model small
.stack 0100h
Push_all macro      ; Macro para push em todos os registradores

           push ax
           push BX
           push cx
           push Dx
           push si
           push di
endm

pop_all macro     ; Macro para pop em todos os registradores
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


.data

  matriz  dw 1,1,1,1
          dw 1,1,1,0
          dw 0,1,0,1
          dw 0,0,0,1

  NMATRIZ DB 13,10,'A MATRIZ = ', 13,10, '$'


  res     db 'o resulado da soma eh -> $'
  per     db 'que linha voce deseja somar ? (1 a 4) $',10,13,'ps caso voce digitar o numero errado sera somado a linha de todas $'
    

.code


main PROC

             mov      ax, @data
             mov      ds, ax


             call     limpa
             call     print_mat
             call     soma



             mov      ah, 4ch
             int      21h

main ENDP


print_mat PROC

             push_all

             LEA      DX, NMATRIZ          ; IMPRIME MENSAGEM EM NMATRIZ
             MOV      AH,09
             INT      21H

             MOV      AH,2                 ;inicializa o indexador de coluna
             MOV      DI,4                 ; número de LINHAS

  L2:        
             xor      si,si
             MOV      CX,4                 ;CX contem o número de elementos de linha

  L3:        
             MOV      DX, MATRIZ [BX][SI]  ;carrega zero no operando calculado
             add      dl, '0'
             INT      21H

             ADD      SI,2                 ;incrementa 2 em SI -> tipo DW = 2 bytes
             LOOP     L3


             pular
             ADD      BX,8
             DEC      DI
             JNZ      L2

             pop_all
             ret
print_mat ENDP


soma PROC

             xor      ax,ax
             xor      dx,dx
             mov      di, 4

  sobe:      
             xor      dx,dx
             xor      si,si
             mov      cx, 4
  somas:     
             mov      ax, matriz[bx][si]
             add      dx, ax
             add      si, 2
             loop     somas
             jmp      finz
    
  pula_linha:
             add      bx, 8
             dec      di
             jnz      sobe
             jmp      fora

  saia:      

  finz:      
             push     ax
             push     cx
             push     dx

             pular

             mov      ah, 9
             lea      dx, res
             int      21h

             pop      dx

             mov      ah, 2
             add      dx, '0'
             int      21h


             pop      cx
             pop      ax
  
             jmp      pula_linha

  fora:      
             ret
soma ENDP

limpa PROC

             mov      ah, 0
             mov      al, 3
             int      10h

             ret
    
limpa ENDP

end main
