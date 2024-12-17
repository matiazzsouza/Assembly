
.model small
 .stack 100h 
.data
        msg   db 'digite um numero: $',10,13
        outro db 10,13,'digite outro numero: $',10,13
        vet   db 10 dup(?)
        vetor db 10,2,8,10, 20, 130,'$'
        qnt   db 'o valor da media entre esses numeros eh -> $'
.code

main PROC

                mov  ax, @data

                mov  ds, ax

                call ler
                call media


                mov  ah, 4ch

                int  21h

main ENDP

        
ler PROC

                xor  cx, cx
                lea  di, vet

        
                mov  ah, 9
                lea  dx, msg
                int  21h

                jmp  lers

        outros: 
                mov  ah,9
                lea  dx, outro
                int  21h


        lers:   
                mov  ah, 1
                int  21h
                cmp  al, 0dh
                je   final

                inc  cx
                sub  al, '0'
                mov  [di], al
                inc  di
                jmp  outros


        final:  

                ret
ler ENDP

media PROC

                xor  ax, ax

                mov  dx,cx
                lea  si, vet

        soma:   

                mov  al,[si]

                add  bl, al

                inc  si

                loop soma

                mov  cl, dl
                xor  dx, dx
        med:    

                mov  al, bl

                div  cx

                cmp  al, 10

                jae  print10

                mov  dl, al           ;certo

                add  dl, '0'

                mov  ah, 2

                int  21h

                jmp  fim2


        print10:

                xor  cx,cx

                xor  bx, bx

                mov  bl, 10

        mais:   

                xor  dx, dx

                inc  cx

                div  BX

                push dx

                cmp  al, 0

                je   fim

            

                jmp  mais


        fim:    

                pop  dx

                add  dl, '0'

                mov  ah, 2

                int  21h

                loop fim


        fim2:   


                ret


media ENDP

end main