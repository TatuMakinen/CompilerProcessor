all: compiler

lex.yy.c: compiler.l
	flex compiler.l

compiler.tab.c: compiler.y
	bison -d compiler.y

compiler: compiler.tab.c lex.yy.c
	gcc -o compiler lex.yy.c compiler.tab.c libfl.a /home/makinen/bison/bison-3.0.4/lib/liby.a

test: compiler
	compiler < test.c
