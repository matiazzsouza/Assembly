.model small
.stack 0100h
.data
    trys db 'Voce tem ', '  ', ' tentativas $', 10, 13 ; '  ' é onde será exibido o número de tentativas

.code
main PROC
            mov  ax, @data
            mov  ds, ax

            lea  si, trys
            add  si, 9                ; Aponta para o local onde o valor de tentativas será atualizado

            mov  cx, 50               ; Número inicial de tentativas
            
ler:    
            ; Decrementa tentativas e exibe
            dec  cx                   ; Decrementa `cx` para contar as tentativas restantes
            cmp  cx, 0
            je   fim_maior            ; Se `cx` chegar a zero, fim das tentativas
            
            ; Conversão do valor de `cx` para ASCII
            mov  ax, cx
            xor  dx, dx
            mov  bx, 10
            div  bx                    ; Divide `ax` por 10 -> `AL` contém a dezena, `AH` a unidade
            
            ; Exibe a dezena, se houver
            add  al, '0'               ; Converte `al` para ASCII
            mov  byte ptr [si], al     ; Armazena no local apropriado da string
            
            ; Exibe a unidade
            inc si
            add  dx, '0'               ; Converte `ah` para ASCII
            mov  byte ptr [si], dl ; Armazena no local apropriado da string

            ; Atualiza a tela com o número de tentativas
            mov  ah, 0
            mov  al, 3
            int  10h                   ; Limpa a tela

            mov  ah, 9
            lea  dx, trys
            int  21h                   ; Exibe a mensagem atualizada

            jmp fim
fim_maior:
            ; Exibe mensagem final e termina o programa
            mov  ah, 9
            lea  dx, trys
            mov  byte ptr [si], '0'    ; Exibe "0 tentativas" ao final
            mov  byte ptr [si + 1], '0'
            int  21h

            fim:

            mov  ah, 4ch
            int  21h                   ; Termina o programa
main ENDP
end main
