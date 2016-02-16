calculator_v2: calculator_v2.o single_point_parser
	ld -m elf_i386 -o calculator_v2 calculator_v2.o

calculator_v2.o: calculator_v2.asm
	nasm -f elf -g -F stabs calculator_v2.asm

single_point_parser: single_point_parser.o
	ld -m elf_i386 -o single_point_parser single_point_parser.o

single_point_parser.o: single_point_parser.asm
	nasm -f elf -g -F stabs single_point_parser.asm