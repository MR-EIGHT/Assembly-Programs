include irvine32.inc
.386
.model flat,C
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD

.data
intNum1    SDWORD ?
intNum2    SDWORD ?


promptBad BYTE "Invalid input, please enter again: ",0
som BYTE "X + Y = ",0
sob BYTE "X - Y = ",0
dov BYTE "X / Y = ",0
mol BYTE "X * Y = ",0

x BYTE "X = ",0
y BYTE "Y = ",0

.code

main PROC
read:  
       mov  edx,OFFSET x
       call WriteString
       call ReadInt
       jno  goodInput

       mov  edx,OFFSET promptBad
       call WriteString
       call crlf
       jmp  read       

goodInput:
       mov  intNum1,eax  



read2: 
       mov  edx,OFFSET y
       call WriteString
       call ReadInt
       jno  goodInput2

       mov  edx,OFFSET promptBad
       call WriteString
       call crlf
       jmp  read2       

goodInput2:
       mov  intNum2,eax  


; ADD SECTION

mov  edx,OFFSET som
call WriteString

add eax,intNum1
call WriteInt

call crlf



;SUBTRACT SECTION

mov  edx,OFFSET sob
call WriteString

mov eax,intNum1
sub eax,intNum2
call WriteInt

call crlf



; MULTIPLY SECTION

mov  edx,OFFSET mol
call WriteString

mov eax,intNum2
imul eax,intNum1
call WriteInt
     
call crlf 


; DIVIDE SECTION

mov  edx,OFFSET dov
call WriteString

mov eax,intNum1
cdq
idiv intNum2
call WriteInt

call crlf 

INVOKE ExitProcess, 0
main ENDP 
end main