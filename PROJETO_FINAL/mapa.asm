.model small
.stack 0100h

 .data
mapa db '    0 1 2 3 4 5 6 7 8 9', 13, 10
     db '    _ _ _ _ _ _ _ _ _ _', 13, 10
     db '   |_|_|_|_|_|_|_|_|_|_|', 13, 10
     db 'A  |_|_|_|_|_|_|_|_|_|_|', 13, 10
     db 'B  |_|_|_|_|_|_|_|_|_|_|', 13, 10
     db 'C  |_|_|_|_|_|_|_|_|_|_|', 13, 10
     db 'D  |_|_|_|_|_|_|_|_|_|_|', 13, 10
     db 'E  |_|_|_|_|_|_|_|_|_|_|', 13, 10
     db 'F  |_|_|_|_|_|_|_|_|_|_|', 13, 10
     db 'G  |_|_|_|_|_|_|_|_|_|_|', 13, 10
     db 'H  |_|_|_|_|_|_|_|_|_|_|', 13, 10
     db 'I  |_|_|_|_|_|_|_|_|_|_|', 13, 10
     db 'J  |_|_|_|_|_|_|_|_|_|_|', 13, 10
     db '$' ; '$' indica o final da string para exibição com a função 09h do DOS


.code
main proc


    mov ax, @data
    mov ds, ax          ; Configura o segmento de dados

    mov ah, 0           ; Modo de texto
    mov al, 3
    int 10h

    call imprimir_mapa  ; Exibir o mapa inicial

    ; Solicitar coordenadas do usuário e atualizar o mapa
    call ler_coordenadas
    call atualizar_mapa
    call imprimir_mapa  ; Exibir o mapa atualizado

    ; Fim do programa
    mov ah, 4Ch         ; Função para sair do programa
    int 21h             ; Chama a interrupção do DOS

main endp

; Procedimento para imprimir o mapa
imprimir_mapa proc
    mov ah, 09h
    mov dx, offset mapa
    int 21h
    ret
imprimir_mapa endp

; Procedimento para ler coordenadas do usuário
ler_coordenadas proc
    ; Ler a letra (A-E)
    mov ah, 01h
    int 21h
    sub al, 'A'         ; Converte a letra para um índice (0-4)
    mov bl, al          ; Armazena a linha em BL

    ; Ler o número (0-4)
    mov ah, 01h
    int 21h
    sub al, '0'         ; Converte o número para um índice (0-4)
    mov bh, al          ; Armazena a coluna em BH
    ret
ler_coordenadas endp

; Procedimento para atualizar o mapa com um barco na posição do usuário
atualizar_mapa proc
    ; Calcular a posição no mapa com base em BL (linha) e BH (coluna)
    mov ax, bx          ; Carrega a linha em AX
    mov cx, 26          ; Cada linha ocupa 26 bytes no mapa (5 células com bordas)
    mul cx              ; AX = linha * largura da linha
    add ax, bx          ; Adiciona a coluna
    shl ax, 1           ; Multiplica por 2 (cada célula é 2 bytes devido às bordas)
    add ax, offset mapa ; Adiciona o endereço base do mapa

    ; Substitui o espaço vazio por 'x' (marcação do barco)
    ret
atualizar_mapa endp

end main
