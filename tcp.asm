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
  ; socketcall SYS_SOCKET action
  mov ebx, 0x1
  ; socketcall args
  mov ecx, esp
  ; socketcall syscall
  mov eax, 0x66 
  ; kernel interruption
  int 0x80
  ; save socket file descriptor
  mov esi, eax


  ; ----- BINDING SOCKET -----
  ; C code: 
  ;
  ; struct sockaddr_in addr = {
  ;     .sin_family = AF_INET,
  ;     .sin_addr.s_addr = INADDR_ANY,
  ;     .sin_port = htons(PORT),
  ; };
  ; bind(sockfd, (const struct sockaddr *)&addr, sizeof(addr))

  ; INADDR_ANY and struct padding
  push 0x0
  ; port 3333 in hex bigendian
  push 0xd05
  ; AF_INET ip domain
  push 0x2
  ; socket file descriptor
  push esi
  ; socketcall args
  mov ecx, esp
  ; socketcall SYS_BIND action
  mov ebx, 0x2
  ; socketcall syscall
  mov eax, 0x66
  ; kernel interruption
  int 0x80
