include irvine32.inc

.386
.model flat,C
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD

ARRAY_SIZE = 5		; size of the array

.data

	array DWORD ARRAY_SIZE DUP(?)
	enterElements byte "Enter array elements: ", 0
	enterTargetToSearch byte "Enter search target: ", 0
	notFound byte "Your target is not found.", 0
	foundAt byte "Found at index: ", 0
	target DWORD ?
	left DWORD ?
	right DWORD ?
	middle DWORD ?


.code

main PROC

	mov edx, OFFSET enterElements
	call writestring
    mov edi, OFFSET array
    mov ecx, ARRAY_SIZE
	Call CRLF

L1: 
		call ReadInt							
		stosd				; For 64-bit mode store eax at address rdi or edi			
		loop L1

	mov edx, offset enterTargetToSearch
	call writestring
	call ReadInt
	mov target, eax	
	mov ecx,ARRAY_SIZE
	dec ecx					; ecx = ARRAY_SIZE - 1

;Bubble-Sort

O1:	push ecx				; save outer loop count
	mov	esi,OFFSET array	; point to left value of the Array
O2:	mov	eax,[esi]			; get array value
	cmp	[esi+4],eax			; compare two values
	jge	O3					; if [esi] <= [edi], don't exch
	xchg eax,[esi+4]		; else, exchange the pair
	mov	[esi],eax
O3:	add	esi,4				; move both pointers forward
	loop	O2				; inner loop
	pop	ecx					; retrieve outer loop count
	loop O1					; else repeat outer loop

;Binary-Search

	mov	eax,ARRAY_SIZE			;right = ARRAY_SIZE - 1
	mov	edi,target				;edi = target
	mov	ebx,OFFSET array		;ebx points to the array
	mov	left,0					;left = 0
	dec	eax						;eax = eax -1
	mov	right,eax				;right = eax
	
Z1: 							;while left <= right
	mov	eax,left				;eax = left
	cmp	eax,right				;compare left and right
	jg	SearchFailed			;exit search
								;middle = (right + left) / 2
	mov	eax,right				;eax = right
	add	eax,left				;eax = right + left
	shr	eax,1					;eax shift right -> eax / 2
	mov	middle,eax				;middle = eax
								;edx = array[middle]
	mov	esi,middle				;esi = middle
	shl	esi,2					;multiply middle value by 4
	mov	edx,[ebx+esi]			;edx = array[middle]
								;if  edx < target(edi)
								;left = middle + 1;
	cmp	edx,edi					;compare edx(middle) and target
	jge	Z2						;Jump if greater or equal
	mov	eax,middle				;eax = middle
	inc	eax						;eax = middle +1
	mov	left,eax				;left = eax
	jmp	Z4						;jump to Z4
								;else if edx > target(edi)					
Z2:	cmp	edx,edi				
	jle	Z3						;jump if less than or equal
	mov	eax,middle				;right = middle - 1
	dec	eax						;eax(middle) = eax -1
	mov	right,eax				;right = eax
	jmp	Z4						;jump to Z4
								;else return middle
Z3:	mov	eax,middle  			;value found
	jmp	FoundTarget				;return (middle)
Z4:	jmp	Z1						;continue the loop

SearchFailed:					;search failed
	mov	edx,OFFSET notFound		
	Call WriteString
	Call CRLF
	ret
FoundTarget:					;target found
	mov edx, OFFSET foundAt
	Call WriteString
	Call WriteInt
	Call CRLF


INVOKE ExitProcess, 0
main ENDP 
end main