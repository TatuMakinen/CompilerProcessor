all: compiler test_compiler interpreter test_interpreter

compiler.lex: compiler.l
	flex compiler.l

compiler.tab.c: compiler.y
<<<<<<< HEAD
	bison -d -v compiler.y
=======
	/home/makinen/bison/bison-3.0.4/src/bison -d -v compiler.y
>>>>>>> 38dfbb8ca767744aeb30c1c535227945a844fea0

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
