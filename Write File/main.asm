include irvine32.inc
.386
.model flat,C
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD


BUFFER_SIZE = 101


.data


buffer BYTE BUFFER_SIZE DUP(?)
FileName     BYTE "AssemblyOutputFile.txt",0
FileHandle   HANDLE ?
StringLength DWORD ?

GetInput BYTE "Enter up to 100 characters:",0dh,0ah,0
Succeed BYTE "Successful! Text written to file AssemblyOutputFile.txt",0
Failure BYTE "Couldn't create file",0dh,0ah,0



.code

main PROC

	mov	edx,OFFSET FileName			; EAX = FileName
	call	CreateOutputFile		; Create a new text file.
	mov	FileHandle,eax				; EAX = FileHandle


	cmp	eax, INVALID_HANDLE_VALUE	; check for errors
	jne	Successful					; if no -> skip
	mov	edx,OFFSET Failure			; else -> display error
	call	WriteString				; write the Filure message
	jmp	quit


Successful:

	mov	edx,OFFSET GetInput			; ask the user to input a string.
	call	WriteString				; write the GetInput message
	mov	ecx,BUFFER_SIZE				; input a string
	mov	edx,OFFSET buffer			; move the buffer address to edx
	call	ReadString				; read the string from user
	mov	StringLength,eax			; count entered characters


	mov	eax,FileHandle				; write the buffer to our file.
	mov	edx,OFFSET buffer			; move the buffer address to edx
	mov	ecx,StringLength			; move the length of the string to ecx
	call	WriteToFile				; call write to file function from Irvine32
	call	CloseFile				; close the output file
	
	call	Crlf
	mov	edx,OFFSET Succeed			; show succeed message
	call	WriteString				; write the string in terminal
	call	Crlf
	
quit:
	exit

main ENDP
END main