dosseg
.MODEL SMALL

.STACK 100H


.CODE

MAIN PROC

; enter video mode

mov ah, 0   ; set display mode function.
mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
int 10h     ; set it by calling the interrupt.

; setting row, column, colour and interrupt

mov cx, 30  ; col => x
mov dx, 30  ; row => y
mov ax, 44h ; 44h is yellow
mov ah, 0ch ; put pixel

; fill a row

columns:
inc cx	
int 10h
cmp cx,60
jb columns

; next row

mov cx, 30  ; reset to start of col
inc dx      ; next row
cmp dx, 60
JNE columns


; exit

mov ax,4C00h  ; terminate program
int 21h


;exiting video-mode and entering text mode:
	;mov ax,0003h
	;int 10h


MAIN ENDP
END MAIN