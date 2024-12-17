.model small
.stack 100h

.data
    vetor db 1,2,3,4,5,6,7,8,9,'$'
    msg   db 10,13,'digite o numero que deseja tirar: $',10,13
    msg2  db 10,13,'vetor -> $',10,13
    
.code

    
main PROC

             mov  ax, @data
             mov  ds, ax

             call printvet
             call tirar

             mov  ah, 4ch
             int  21h

main ENDP
    

tirar PROC

             mov  ah, 9
             lea  dx, msg
             int  21h

             mov  ah, 1
             int  21h
             sub  al, '0'

             lea  di, vetor

             xor  bx, bx

    remove:  
             mov  bl, [di]
             cmp  al, bl
             je   tchaus
             inc  di
             jmp  remove


    tchaus:  
             inc  di
    tchau:   
             mov  al,[di]
             mov  [di - 1], al
             inc  di
             cmp  al, '$'
             jne  tchau

             call printvet

             ret

tirar ENDP

printvet PROC


             mov  ah, 9
             lea  dx, msg2
             int  21h

             lea  di, vetor
             xor  dx, dx

    print:   
             mov  dl,[di]
             cmp  dl, '$'
             je   saia
             mov  ah, 2
             add  dl, '0'
             int  21h
             inc  di
             jmp  print
       
    saia:    
             ret

printvet ENDP
    

    end main