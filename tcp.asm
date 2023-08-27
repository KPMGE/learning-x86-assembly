; Simple tcp server in x86-32bit assembly
; Author: Kevin Carvalho de Jesus

section .data

section .text
  global _start

_start: 
  ; ----- CREATING SOCKET -----
  ; C code: socket(AF_INET, SOCK_STREAM, IPPROTO_IP)

  ; ip protocol
  push 0x0
  ; tcp socket
  push 0x1
  ; domain ipv4 
  push 0x2
  ; SYS_SOCKET action
  mov ebx, 0x1
  ; socketcall args
  mov ecx, esp
  ; socketcall syscall
  mov eax, 0x66 
  ; kernel interruption
  int 0x80
