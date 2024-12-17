.model small 
.stack 0100h

.data

    vetor1 db 1,2,3,4,5,6, '$'
    vetor2 db 6,2,3,1,2,3, '$'
    msg    db 'qnt de numeros iguais -> $'

.code

     
main PROC
        
             mov  ax, @data
             mov  ds, ax

             call verifica

            mov bl, dl

             mov  ah, 9
             lea  dx, msg
             int  21h

             mov  ah, 2
             mov dl, bl
             add  dl, '0'
             int  21h
        
             mov  ah, 4ch
             int  21h
    
main ENDP


verifica PROC

             lea  di, vetor1
             lea  si, vetor2 


             xor  cx, cx
             xor  dx, dx
    sla:     
             xor  ax, ax
             xor  bx, bx

    comparar:
             mov  al, [di]
             mov  bl, [si]
             cmp al, '$'
             je   fim
             cmp bl, '$'
             je   volta
             cmp  al, bl
             je   contador
             inc  si
             jmp sla
             

    contador:
             lea si, vetor2
             inc  dl
             inc di
             jmp  sla

    volta: 
            lea si, vetor2
            inc di
            jmp sla
             
        fim:
            
             ret
verifica ENDP


    end main