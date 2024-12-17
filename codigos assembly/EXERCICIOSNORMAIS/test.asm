TITLE Matriz
.MODEL SMALL
.stack 0100h
pula_linha macro
               PUSH AX
               PUSH DX
               MOV  AH,02
               MOV  DL,10
               INT  21H
               POP  DX
               POP  AX
endm
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

Push_all macro          ; Macro para push em todos os registradores
             push ax
             push BX
             push cx
             push Dx
             push si
             push di
endm

.DATA

    MATRIZ   dw 1,2,3,4
             dw 5,6,7,8
             Dw 9,0,1,2
             Dw 3,4,5,6
           
    NMATRIZ  DB 13,10,'MATRIZ = ', 13,10, '$'
    NMATRIZ2 DB 13,10,'A MATRIZ TROCADA = ', 13,10, '$'

.CODE
MAIN PROC

              MOV        AX,@DATA
              MOV        DS,AX

    ;call       print_mat
              call       troca_mat

              MOV        AH,4CH                 ; termina o programa
              INT        21H

MAIN ENDP



print_mat PROC
            
                Push_all
                xor_all

              LEA        DX, NMATRIZ            ; IMPRIME MENSAGEM EM NMATRIZ
              MOV        AH,09
              INT        21H

              MOV        AH,2                   ;inicializa o indexador de coluna
              MOV        DI,4                   ; número de LINHAS

    L2:       
              xor        si,si
              MOV        CX,4                   ;CX contem o número de elementos de linha

    L3:       
              MOV        DX, MATRIZ [BX][SI]    ;carrega zero no operando calculado
              add        dl, '0'
              INT        21H

              ADD        SI,2                   ;incrementa 2 em SI -> tipo DW = 2 bytes
              LOOP       L3


              pula_linha
              ADD        BX,8
              DEC        DI
              JNZ        L2

                pop_all
              ret
print_mat ENDP


troca_mat PROC                                  ;trocas as colunas pares pelas impares

              Push_all

              xor_all
              xor        si, si

              mov cl, 4
            sla:
              mov ch, 2

    troca:    
              mov        ax, Matriz[bx][si]
              add        si, 2
              xchg       ax, Matriz[bx][si]
              sub        si, 2
              mov        Matriz[bx][si], ax
              add si, 4
              dec ch
              jnz troca
              add bx, 8
              xor si, si
              loop sla           

    fim:      
              call       print_mat

              pop_all
              ret
    
troca_mat ENDP

END MAIN
