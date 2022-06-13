; Reverses myString using the stack

.386								; Sets program as using the 32-bit x86 instructions
.model flat, stdcall				; Sets the memory model as flat and uses the standard call for procedures
.stack 4096							; Gives the program stack 4096 bytes
ExitProcess PROTO, dwExitCode:DWORD ; Declares prototype for ExitProcess

.data
myString BYTE "Racecar", 0
stringLen = ($ - myString) - 1

.code
main PROC
	;Keep track of the char index of myString and the length of the string
	mov esi, 0
	mov ecx, stringLen

	PushCharToStack:
		movzx ax, myString[esi]		; Moves first character into ax register
		push ax 					; Pushes the ax register on the stack
		inc esi						; Increment index
		loop PushCharToStack		; Decrement ecx and keep looping subroutine until it reaches 0

	; Reset counters
	mov esi, 0
	mov ecx, stringLen

	PopCharToMemory:
		pop ax						; Take character from top of stack to ax
		mov myString[esi], al		; Take the char in al and put into memory
		inc esi						; Increment string index
		loop PopCharToMemory		; Loop through whole string

	INVOKE ExitProcess, 0		    ; Returns 0 to the OS as the exit code
main ENDP
END MAIN							; Last line to be assembled