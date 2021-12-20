dosseg
.MODEL SMALL

.STACK 100H


.CODE
MAIN PROC
mov ah, 0   ; set display mode function.
mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
int 10h     ; set it!

mov cx, 30  ;col
mov dx, 30  ;row
mov ax, 44h ;44h is yellow
mov ah, 0ch ; put pixel

colcount:
inc cx
int 10h
cmp cx,60
jb colcount

mov cx, 30  ; reset to start of col
inc dx      ;next row
cmp dx, 60
JNE colcount

; exit

mov ax,4C00h  ;terminate program
int 21h

;exiting video-mode and entering text mode:
	;mov ax,0003h
	;int 10h


MAIN ENDP
END MAIN