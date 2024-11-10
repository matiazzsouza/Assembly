.model small
.stack 100h

.data
mapa db '    0 1 2 3 4 5 6 7 8 9', 13, 10
     db '    _ _ _ _ _ _ _ _ _ _', 13, 10
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
     db '$'  ; $ indica o final da string para exibição com a função 09h do DOS

.code
main:
    ; Inicializa o segmento de dados
    mov ax, @data
    mov ds, ax

loop_inicio:
    ; Exibir o mapa atual
    call imprimir_mapa

    ; Ler coordenadas do usuário
    call ler_coordenadas

    ; Verificar se o usuário deseja sair (pressionando 'q' ou 'Q')
    cmp al, 'q'
    je fim_programa
    cmp al, 'Q'
    je fim_programa

    ; Atualizar o mapa com a coordenada fornecida
    call atualizar_mapa

    ; Voltar para o início do loop
    jmp loop_inicio

fim_programa:
    ; Sair do programa
    mov ah, 4Ch
    int 21h

; Função para imprimir o mapa
imprimir_mapa:
    mov ah, 09h
    lea dx, mapa
    int 21h
    ret

; Função para ler as coordenadas do usuário
ler_coordenadas:
    ; Ler a letra (A-J) da linha
    mov ah, 01h
    int 21h
    sub al, 'A'           ; Converte para índice (0-9)

    ; Armazenar no registrador BL a linha (0-9)
    mov bl, al

    ; Ler o número (0-9) da coluna
    mov ah, 01h
    int 21h
    sub al, '0'           ; Converte para índice (0-9)

    ; Armazenar no registrador BH a coluna (0-9)
    mov bh, al
    ret

atualizar_mapa:
    ; Calcular o deslocamento da linha: cada linha ocupa 24 caracteres no total
    mov al, bl            ; Linha (0-9) está em BL
    mov ah, 0             ; Limpar AH para multiplicação
    mov cx, 24            ; Cada linha ocupa 24 caracteres
    mul cx                ; Multiplica a linha pelo tamanho total da linha, resultado em AX

    ; Adicionar a posição base da linha para a primeira coluna
    add ax, 54             ; Começar na posição [2,2] para a primeira célula em cada linha

    ; Ajuste adicional para cada nova linha, incrementando em 2 sucessivamente
    mov cl, bl            ; Copia o valor de bl para cl
    shl cl, 1             ; Multiplica cl por 2 para incrementos de 2, 4, 6, etc.
    add ax, cx            ; Incrementa o deslocamento da linha em múltiplos de 2

    ; Calcular o deslocamento da coluna: cada coluna se move duas posições para a direita
    mov cl, bh            ; Coluna (0-9) está em BH
    shl cl, 1             ; Multiplica coluna por 2 (salto de 2 caracteres por coluna)
    add ax, cx            ; Soma o deslocamento da coluna ao endereço

    ; Calcular o endereço final no mapa
    lea si, mapa          ; Carrega o endereço base do mapa em SI
    add si, ax            ; Soma o índice calculado em AX ao endereço base

    ; Substituir o caractere no mapa por 'X' (marcando a posição)
    mov byte ptr [si], 'X'
    ret

end main
