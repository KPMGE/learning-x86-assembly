ASM=nasm
LNK=ld
FLAGS=-g

ASM_FILE_SPLIT=$(subst ., ,$(file))
FILE_NAME_NO_EXTENSION=$(word 1,$(ASM_FILE_SPLIT))

all: 
	@ $(ASM) $(file) $(FLAGS) -f elf32 -o $(FILE_NAME_NO_EXTENSION).o
	@ $(LNK) -m elf_i386 $(FILE_NAME_NO_EXTENSION).o -o $(FILE_NAME_NO_EXTENSION)

clean: 
	@ rm $(FILE_NAME_NO_EXTENSION).o $(FILE_NAME_NO_EXTENSION)
