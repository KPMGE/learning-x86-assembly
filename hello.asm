; Simple but essential hello world program in x86-32 assembly

section .data
	; message to be displayed
	msg db "Hello World!", 0xa
	; lenght of the message
	len equ $ -msg

section .text
	global _start

_start:
	; write syscall
	mov eax, 4
	; stdout file descriptor
	mov ebx, 1
	; bytes of the message to be displayed
	mov ecx, msg
	; lenght of the message
	mov edx, len
	; call kernel
	int 0x80

	; exit syscall
	mov eax, 1
	; call kernel
	int 0x80
