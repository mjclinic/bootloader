;infra structure
    bits 16
    org 0x7c00

    mov ax, 0xb800
    mov es, ax

    mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov ah, 1
    mov ch, 0x26
    mov cl, 0x07
    int 0x10

    mov ah, 2
    mov dh, 24
    mov dl, 79
    int 0x10

game_start:


    mov word[over],0

    mov di, 0
    .line_check:
    cmp di, 2*80*25
    jge .keyboard
    mov si, 0
    mov dl, 0B_1000_0000
    call print
    add di, 2
    jmp .line_check


    
    .keyboard:
    mov ah, 0x01
    int 0x16

    je .line_end ; je= 1

    mov ah, 0x00
    int 0x16

    cmp al, 'j'
    je .jump
    jmp .keyboard2

    .jump:
    cmp word[padle_l], 20
    je .keyboard2
    add word [padle_l], 1

    call padle

    .keyboard2:
    cmp al, 'k'
    je .kick
    jmp .line_end

    .kick:
    cmp word[padle_l], 0
    je .line_end
    sub word [padle_l], 1

    call padle
    

    
    .line_end:
    imul ax, [padle_l],d_y
    add ax, d_y*4
    mov bx, ax
    mov ax, [padle_l]
    imul ax, [padle_l],d_y
    mov di, ax
    call padle

    
    imul bx, [padle_r],d_y
    add bx, padle_r_x * d_x
    add bx, d_y*4
    imul di, [padle_r], d_y
    add di, padle_r_x * d_x
    call padle
 

    mov ax , [ball_vx]
    add word [ball_x], ax
    mov ax , [ball_r]
    cmp word [ball_x], ax
    je .inverse
    mov ax , [ball_l]
    cmp word [ball_x], ax
    je .inverse
    jmp .nomal 
    .inverse:
    neg word [ball_vx]
    .nomal:

    mov ax , [ball_vy]
    add word [ball_y], ax
    mov ax , [ball_t]
    cmp word [ball_y], ax
    je .inversey
    mov ax , [ball_b]
    cmp word [ball_y], ax
    je .inversey
    jmp .callre
    .inversey:
    neg word [ball_vy]




   

    .callre:
    cmp word[ball_x], 1
    jne .callre_com

    mov ax, word[ball_y]
    mov bx, word[padle_l]
    cmp ax, bx
    jl .callre_com 

    add bx, 4
    cmp ax, bx
    jg .callre_com

    neg word[ball_vx]
    
    .callre_com:
    cmp word[ball_x], 78 
    jne .done

    mov ax, word[ball_y]
    mov bx, word[padle_r]
    cmp ax, bx
    jl .done

    add bx, 4
    cmp ax, bx
    jg .done

    neg word[ball_vx]
    




    .done:
    mov di, [ball_x]
    mov si, [ball_y]
    call ball
    mov di,ax
    mov si, "B"
    mov dl, 0b_1000_1101
    call print
 
    .com:
    mov ax, word[padle_r]
    add ax, 2
    cmp ax, word[ball_y]
    je .gamecheck
    jg .com_up
    
    .com_down:
    mov ax, word[padle_r]
    add ax, 4
    cmp ax, 24
    je .gamecheck
    add word[padle_r],1
    jmp .gamecheck
    .com_up:
    cmp word[padle_r], 0
    je .gamecheck
    sub word[padle_r],1

    .gamecheck:
    cmp word[ball_x],0
    je .cpu_win
    jmp .end

    .cpu_win:
    mov bx, 0
    mov di, d_y * 5 + d_x * 36
    .cpu_loop:
    mov si, word[cpu_win+bx]
    mov dl, 0b_1000_1111
    call print
    add di,2
    add bx,2
    cmp bx, 14
    je .game_over
    jmp .cpu_loop

    .game_over:
    
    mov ah, 0x01
    int 0x16

    je .game_over ; je= 1

    mov ah, 0x00
    int 0x16
    cmp al, 'r'
    je .end
    jmp $


    .end:
    mov bx, [0x_046c]
    add bx, 1
    .delay:
    cmp bx, [0x_046c]
    jge .delay
    jmp game_start

ball:
;di: x si: y
imul di, [ball_x],d_x
imul si, [ball_y],d_y
add di,si
mov ax,di
ret
print:
;di: rocation si:ascii dl: colar
mov cx, si
mov byte [es:di], cl
mov byte [es:di+1], dl
ret

padle:

cmp di, bx
jg .padle_l_end
mov si, 0
mov dl, 0B_1010_0000
call print
add di, d_y
jmp padle
.padle_l_end:
ret


;j: 246A 
;K: 256B

ball_x: dw 5
ball_y: dw 5
ball_r: dw 79
ball_l: dw 0
ball_t: dw 1
ball_b: dw 23
ball_vx: dw 1
ball_vy: dw 1

padle_l: dw 10
padle_r: dw 10
over: dw 0
;constance
padle_l_x equ 0
padle_r_x equ 79
d_y equ 160
d_x equ 2
cpu_win: dw 'c','p','u',' ','w','i','n'


times 510 - ($-$$) db 0

db 0x55
db 0xaa 
