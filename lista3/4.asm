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

xor_all MACRO
          xor ax,ax
          xor bx,bx
          xor cx, cx
          xor dx,dx

ENDM

pop_all macro     ; Macro para pop em todos os registradores
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
endm


pular MACRO

        push_all
        mov      ah, 2
        mov      dl, 10
        int      21h
        pop_all
ENDM

.data

  vetor   db 1,2,3,4,5
  msg     db 10,13,'quantas vezes deseja rotacionar: $',10,13
  msg1    db 10,13,'vetor -> $',10,13
  msg_vet db 10,13,'vetor rotacionado -> $'

.code

main PROC

            mov      ax, @data
            mov      ds,ax
            ;call     limpa
           ; call     print_vet
            call     rot

            mov      ah, 4ch
            int      21h
        

main ENDP



print_vet PROC

            push_all
      
            lea      di, vetor

            mov      ah, 9
            lea      dx, msg1
            int      21h

            xor      dx, dx

            mov      cx, 5

  print:    
            mov      dl, [di]
            mov      ah, 2
            add      dl, '0'
            int      21h
            inc      di
            loop     print
    

  final:    
            pop_all
            ret
print_vet ENDP




rot PROC

            push_all

            mov      ah, 9
            lea      dx, msg
            int      21h
            xor_all

            mov      ah, 1
            int      21h                    ;o valor que esta em al sera comparado com '1' assim comparando o tanto de vez que eu terei que decrementar o valor de di
            sub      al, '0'
            mov      cl, al
            
            xor      di,di
            lea      di, vetor + 4
            push     cx
            xor_all
            pop      cx
            mov      si, 4

            mov bx, 5
            cmp cx, 5
            ja mult
            sub bx, cx
            jmp rota

            mult:
              mov ax, 2
              mul bx
              xchg ax, bx
              sub bx, cx
              jmp rota



  rotas:     
  mov cx, bx

  rota:     
            mov      al, [di]
            cmp      di, si
            je       zera
            mov      byte ptr    [di], al
            inc      di
            dec      cl
            jnz      rota
            jmp      fim

  zera:     
            xor      di, di
            mov      byte ptr     [di], al
            dec      cl
            cmp      cl, 0
            je       finals
            cmp      di, 0
            je       rota
            inc      di
            jmp      rota

    finals:
          loop rotas

  fim:      
            call     print_vet
            pop_all
            ret
rot ENDP

limpa PROC
            push_all
            mov      ah, 0
            mov      al, 3
            int      10h
            pop_all
            ret
limpa ENDP

end main
