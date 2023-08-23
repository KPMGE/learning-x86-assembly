; simple example of how to call functions in x86-32 assembly

section .data
  ; store a number in memory
  num dd 0x20

section .text
  ; entrypoint
  global _start

_start:
  ; load the value of num into eax
  mov eax, [num]
  ; call function
  call add_10

  ; exit with 0 status code
  mov eax, 1
  mov ebx, 0
  int 0x80

; function that adds 10 to a given number
add_10:
  ; push base pointer into the stack
  push ebp
  ; make base pointer(ebp) register be the stack pointer register(esp)
  mov ebp, esp

  ; add 10 to the parameter, passed through eax
  add eax, 10

  ; restore the values of esp and ebp
  mov esp, ebp
  pop ebp

  ; return back to callee
  ret
