all: compiler test_compiler interpreter test_interpreter

compiler.lex: compiler.l
	flex compiler.l

compiler.tab.c: compiler.y
	bison -d -v compiler.y

compiler: compiler.tab.c compiler.lex
	gcc -std=c99 -o compiler lex.yy.c compiler.tab.c -ll -ly

test_compiler: compiler
	./compiler < testCompiler.c

interpreter.lex: interpreter.l
	flex interpreter.l

interpreter.tab.c: interpreter.y
	bison -d -v interpreter.y

interpreter: interpreter.tab.c interpreter.lex
	gcc -std=c99 -o interpreter lex.yy.c interpreter.tab.c -ll -ly

test_interpreter:
	./interpreter < asm_code
