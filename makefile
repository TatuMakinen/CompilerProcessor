all: compiler test_compiler interpreter test_interpreter

compiler.lex: compiler.l
	./flex compiler.l

compiler.tab.c: compiler.y
	/home/makinen/bison/bison-3.0.4/src/bison -d -v compiler.y

compiler: compiler.tab.c compiler.lex
	gcc -std=c99 -o compiler lex.yy.c compiler.tab.c libfl.a /home/makinen/bison/bison-3.0.4/lib/liby.a

test_compiler: compiler
	./compiler < test.c

interpreter.lex: interpreter.l
	./flex interpreter.l

interpreter.tab.c: interpreter.y
	/home/makinen/bison/bison-3.0.4/src/bison -d interpreter.y

interpreter: interpreter.tab.c interpreter.lex
	gcc -std=c99 -o interpreter lex.yy.c interpreter.tab.c libfl.a /home/makinen/bison/bison-3.0.4/lib/liby.a

test_interpreter:
	./interpreter < asm_code
