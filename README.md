# learning x86 assembly :computer:

Repository for miscellaneous informations and programs about x86 assembly 

## Assembling and linking
In order to run those programs, you're gonna need to first, assemble them
and then link them. You can use whatever tools you like to do that, in fact,
there are plenty of them out there. My personal choice is [nasm](https://www.nasm.us/) for
the assembler and [ld](http://litux.nl/man/htmlman8/ld.so.8.html) for the linker. Assuming 
you're using linux, ld should be available by default.

If you use the same tools as i do, you can assemble and run the programs as 
follows: 

### Assemble :hammer:
```
nasm -f elf32 <assembly program> -o <label object file>
```

### link :link:
```
ld -m elf_i386 <label object file> -o <label executable file>
```

> [!NOTE]
> Remember that, i'm assuming you're using x86-32 assembly, if you're
using another version, the commands might be slightly different


## Debugging :bug:
If you wanna debug these programs, i personally recommend using [GDB](https://www.sourceware.org/gdb/),
it's a very well-known and powerful debugger. If you decide to use it, 
the only thing you need to do is adding the flag `-g` in the assemble phase.
This flag will add debug information that gdb needs.

```
nasm -g -f elf32 <assembly program> -o <label object file>
```

After that, you can run your program with gdb and debug it! :rocket:
