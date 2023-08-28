; Simple tcp server in x86-32bit assembly
; Author: Kevin Carvalho de Jesus

section .data
  buffer_size equ 1024
  buffer db buffer_size dup(0)
  msg db 0xa, "Got message: "
  len equ $ -msg
  listen_msg db "Server listening on port 4444...", 0xa
  listen_msg_len equ $ -listen_msg

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
  ; port 4444 in hex bigendian
  push WORD 0x5c11
  ; AF_INET ip domain
  push WORD 0x02
  ; socketcall args
  mov ecx, esp
  ; host address
  push ecx
  ; sizeof(host_address)
  push 0x16
  ; host address
  push ecx
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


  ; ----- LISTEN ON SOCKET -----
  ; C code: listen(sockfd, MAX_CLIENT_CONNECTIONS)
  ; max 5 client connections
  push 0x5
  ; socket file descriptor
  push esi
  ; socketcall args
  mov ecx, esp
  ; socketcall SYS_LISTEN	action
  mov ebx, 0x4
  ; socketcall syscall
  mov eax, 0x66
  ; kernel interruption
  int 0x80


  ; ----- PRINT INFO MESSAGE -----
  ; C code: printf("%s", listen_msg)
  mov edx, listen_msg_len
  ; message
  mov ecx, listen_msg
  ; stdout file descriptor
  mov ebx, 0x1
  ; write syscall
  mov eax, 0x4
  ; kernel interruption
  int 0x80


  ; ----- ACCEPT ON SOCKET -----
  ; C code: listen(sockfd, 0, 0)

  ; sockaddr_len
  push 0x0
  ; sockaddr (NULL)
  push 0x0
  ; socket file descriptor
  push esi
  ; socketcall args
  mov ecx, esp
  ; socketcall SYS_ACCEPT action
  mov ebx, 0x5
  ; socketcall syscall
  mov eax, 0x66
  ; kernel interruption
  int 0x80
  ; save new file descriptor
  mov esi, eax


  ; ----- READ MESSAGE INTO BUFFER -----
  ; C code: read(sockfd, &buffer, sizeof(buffer))

  ; buffer size
  mov edx, buffer_size
  ; buffer to read into
  mov ecx, buffer
  ; socket file descriptor
  mov ebx, esi
  ; read syscall
  mov eax, 0x3
  ; kernel interruption
  int 0x80


  ; ----- PRINT MESSAGE -----
  ; C code: printf("%s\n%s", msg, buffer)

  ; message length
  mov edx, len
  ; message
  mov ecx, msg
  ; stdout file descriptor
  mov ebx, 0x1
  ; write syscall
  mov eax, 0x4
  ; kernel interruption
  int 0x80

  ; buffer size
  mov edx, buffer_size
  ; buffer
  mov ecx, buffer
  ; stdout file descriptor
  mov ebx, 0x1
  ; write syscall
  mov eax, 0x4
  ; kernel interruption
  int 0x80


  ; ----- EXIT -----
  ; C code: exit(0)

  ; exit syscall
  mov eax, 0x1
  ; exit code
  mov ebx, 0x0
  ; kernel interruption
  int 0x80
