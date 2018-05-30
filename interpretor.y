%{
  #include <stdio.h>
  #include "assemblerStruct.c"
  int yylex(void);
  void yyerror(char const *s);
	Assembly* assembly;
%}
%union { int nb;}
%token tADD tMUL tSOU tDIV tCOP tAFC tLOAD tSTORE tEQU tINF tINFE tSUP tSUPE tJMP tJMPC tNB tSEMICOLON
%type <nb> tNB

%%
Content :

	| Line Content {}
;
Line :
	Instruction tSEMICOLON
;
Instruction :
	Add
	|Mul
	|Sou
	|Div
	|Cop
	|Afc
	|Load
	|Store
	|Equ
	|Inf
	|Infe
	|Sup
	|Supe
	|Jmp
	|Jmpc
;
	
Add: 
  tADD tNB tNB tNB {add_instruction(assembly,ADD,$2,$3,$4);}
;
Mul: 
  tMUL tNB tNB tNB {add_instruction(assembly,MUL,$2,$3,$4);}
;
Sou: 
  tSOU tNB tNB tNB {add_instruction(assembly,SOU,$2,$3,$4);}
;
Div: 
  tDIV tNB tNB tNB {add_instruction(assembly,DIV,$2,$3,$4);}
;
Cop: 
  tCOP tNB tNB {add_instruction(assembly,COP,$2,$3,-1);}
;
Afc: 
  tAFC tNB tNB {add_instruction(assembly,AFC,$2,$3,-1);}
;
Load: 
  tLOAD tNB tNB {add_instruction(assembly,LOAD,$2,$3,-1);}
;
Store: 
  tSTORE tNB tNB {add_instruction(assembly,STORE,$2,$3,-1);}
;
Equ: 
  tEQU tNB tNB tNB {add_instruction(assembly,EQU,$2,$3,$4);}
;
Inf: 
  tINF tNB tNB tNB {add_instruction(assembly,INF,$2,$3,$4);}
;
Infe: 
  tINFE tNB tNB tNB {add_instruction(assembly,INFE,$2,$3,$4);}
;
Sup: 
  tSUP tNB tNB tNB {add_instruction(assembly,SUP,$2,$3,$4);}
;
Supe: 
  tSUPE tNB tNB tNB {add_instruction(assembly,SUPE,$2,$3,$4);}
;
Jmp: 
  tJMP tNB {add_instruction(assembly,JMP,$2,-1,-1);}
;
Jmpc: 
  tJMPC tNB tNB {add_instruction(assembly,JMPC,$2,$3,-1);}
;


%%

void yyerror (char const *s) {
	fprintf (stderr, "%s\n", s);
}

int main(void) {
	assembly = initAsm();
  if(yyparse()) {
		printf("Compile failed!\n");
	}else{
		printf("Compile succesful!\n");
	}
  return 0;
}
