all: compiler

lex.yy.c: compiler.l
	flex compiler.l

compiler.tab.c: compiler.y
	bison -d compiler.y

compiler: compiler.tab.c lex.yy.c
	gcc -o compiler lex.yy.c compiler.tab.c -ll -ly

test: compiler
	./compiler < test.c
