bits 16
org 0x7c00


game_start:
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov ax, 0xb800
    mov es, ax
    .init:
    mov di, 0
    mov si, 0
    call ball
      
    .bg:
    mov di, 0
    .bg_check:
    cmp di, 2*80*25-1
    jge .line1
    mov si, 0
    mov dl, 0B_1111_0000
    call print
    add di, 2
    jmp .bg_check

    .line1:
    mov di, 160
    .line_check:
    cmp di, 2*80*24-1
    jge .line_end
    mov si, 0
    mov dl, 0B_0000_0000
    call print
    add di, 2
    jmp .line_check
    
    .line_end:
    imul ax, [padle_l],160
    add ax, 160*4
    mov bx, ax
    mov ax, [padle_l]
    imul ax, [padle_l],160
    mov di, ax
    call padle

    mov bx, [padle_r]
    add bx, 160*4
    mov di, [padle_r]
    call padle
    

    .done:
    mov di, [ball_x]
    mov si, [ball_y]
    call ball
    mov di,ax
    mov si, "B"
    mov dl, 0b_0000_1101
    call print

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
    jmp .keyboard
    .inversey:
    neg word [ball_vy]
    
  
    .keyboard:
    mov ah, 0x01
    int 0x16

    je .end ; je= 1

    mov ah, 0x00
    int 0x16
    cmp al, 0x6A
    je .jump
    jmp .keyboard2

    .jump:
    add word [padle_l], 1

    call padle

    .keyboard2:
    cmp al, 0x6B
    je .kick
    jmp .end

    .kick:
    sub word [padle_l], 1

    call padle




    .callre:
    cmp [ball_x], 2
    je .impact
    .impact:
    mov ax, [padle_l]
    div ax, 160
    jmp .end











    .end:
    mov bx, [0x_046c]
    add bx, 1
    .delay:
    cmp bx, [0x_046c]
    jge .delay
    jmp game_start

ball:
;di: x si: y
imul di, di,2
imul si, si,160
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
add di, 160
jmp padle
.padle_l_end:
ret


;j: 246A 
;K: 256B

ball_x: dw 5
ball_y: dw 2
ball_r: dw 79
ball_l: dw 0
ball_t: dw 1
ball_b: dw 23
ball_vx: dw 1
ball_vy: dw 1

padle_l: dw 10
padle_r: dw 160*11-2

times 510 - ($-$$) db 0

db 0x55
db 0xaa 
