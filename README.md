# learning x86 assembly

Repository for miscellaneous informations and programs about x86 assembly 

## Assembling and linking
In order to run those programs, you're gonna need to first, assemble them
and then link them. You can use whatever tools you like to do that, in fact,
there are plenty of them out there. My personal choice is [nasm](https://www.nasm.us/) for
the assembler and [ld](http://litux.nl/man/htmlman8/ld.so.8.html) for the linker. Assuming 
you're using linux, ld should be available by default.

If you use the same tools as i do, you can assemble and run the programs as 
follows: 

### Assemble
```bash
nasm -f elf32 <assembly program> -o <label object file>
```

### link
```bash
ld -m elf_i386 <label object file> -o <label executable file>
```

> [!NOTE]
> Remember that, i'm assuming you're using x86-32 assembly, if you're
using another version, the commands might be slightly different
