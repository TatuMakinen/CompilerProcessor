%{
  #include <stdio.h>
  #include "tableSymbole.c"
	#include "jumpTable.c"
  #include "assemblerStruct.c"
  int yylex(void);
  void yyerror(char const *s);
  char* type;
  char* name;
  int depth = 0;
	int line = 0;
	Pile* pile;
	Assembly* assembly;
%}

%union { char* str; int nb;}

%token tIF tWHILE tELSE tMAIN tQUOTE tCHAINE tCONST tNB tRETURN tPRINTF tSTRING
tAG tAD tSEMICOLON tCOMMA tPLUS tMINUS tSLASH tMUL tEQUAL tUNEQUAL tPG tPD tINT
tVOID tID tEXP tFIRSTARG tPERCENTINT
%type <str> tID
%type <nb> tNB
%type <str> tCHAINE
%left tPLUS tMINUS
%left tMUL tSLASH

%%
Main: 
  tINT tMAIN tPG tPD tAG Program tAD
  {
    printf("Compile succesful!\n"); 
  }
;
Program:

  | Line Program {}
;
Line:
  Content tSEMICOLON {++line;printf("Line %d:\n",line);afficherPile(pile);display_struct(assembly);}
  | If {}
  | While {}
  | Function {}
;
Content:

  | VariableDeclaration {}
  | VariableDefinition {}
  | Assignment {}
  | Print {}
;
// Variable type can be int, void or string
VariableType:
  tINT { type = "int"; }
  | tVOID { type ="void"; }
  | tSTRING { type ="string"; }
;
// Declaring one or multiple variables - they are added to the
// symbol table for later assignment
VariableDeclaration:
  VariableType tID RemVariable { empiler(pile,type,$2,depth); }
;
RemVariable:

  | tCOMMA tID RemVariable { empiler(pile,type,$2,depth); }
;
// Assignment - error if variable is not declared earlier in the code
Assignment:
  tID tEQUAL Expression
  {
    add_instruction(assembly,"LOAD", 0, peek(pile), -1);
    depiler(pile);
    add_instruction(assembly,"STORE", find(pile,$1), 0, -1);
  }
;
// Variable is defined - added to the table
VariableDefinition:
  VariableType tID tEQUAL Expression
  {
    depiler(pile); empiler(pile,type,$2,depth);
  }
;
// Arithmetic operations
Expression:
  Expression tPLUS Expression
  {
    depiler(pile);
    add_instruction(assembly,"LOAD", 1, peek(pile), -1);
    add_instruction(assembly,"ADD", 0, 0, 1);
    add_instruction(assembly,"STORE", peek(pile), 0, -1);
    empiler(pile,"int","tmp",depth);
  }
  | Expression tMINUS Expression
  {
		depiler(pile);
    add_instruction(assembly,"LOAD",1,peek(pile),-1);
    add_instruction(assembly,"SUB",0,0,1);
    add_instruction(assembly,"STORE",peek(pile),0,-1);
    empiler(pile,"int","tmp",depth);
  }
  | Expression tMUL Expression
  {
    depiler(pile); 
    add_instruction(assembly,"LOAD",1,peek(pile),-1);
    add_instruction(assembly,"MUL",0,0,1);
    add_instruction(assembly,"STORE",peek(pile),0,-1);
    empiler(pile,"int","tmp",depth);
  }
  | Expression tSLASH Expression
  {
    depiler(pile);
    add_instruction(assembly,"LOAD",1,peek(pile),-1);
    add_instruction(assembly,"DIV",0,0,1);
    add_instruction(assembly,"STORE",peek(pile),0,-1);
    empiler(pile,"int","tmp",depth);
  }
  | tNB 
  {
    empiler(pile,"int","tmp",depth);
    add_instruction(assembly,"AFC", 0, $1, -1);
    add_instruction(assembly,"STORE", peek(pile), 0, -1);
  }
  | tID
  {
    empiler(pile,"str","tmp",depth);
    add_instruction(assembly,"LOAD", 0, find(pile,$1), -1);
    add_instruction(assembly,"STORE", peek(pile), 0, -1);
  }
;
While:
  tWHILE tPG Boolean tPD tAG Program tAD { printf("while\n"); }
;
If:
  StartIf Program tAD RemainIf { addInstruction(assembly->tailleEffective); }
;
RemainIf:
  | StartElse Program tAD {}
;
StartIf:
  tIF tPG Boolean tPD tAG 
  {
    ++depth; printf("Depth = %d\n",depth);
    insertQueue(assembly->tailleEffective);
  }
;
StartElse:
  tELSE tAG  { printf("Depth = %d\n",depth); }
;
Boolean:
  tID tEQUAL tEQUAL tNB { printf("VAR == INT\n"); }
  | tID tEQUAL tEQUAL tID { printf("VAR == VAR\n"); }
  | tNB tEQUAL tEQUAL tNB { printf("INT == INT\n");}
  | tNB tEQUAL tEQUAL tID { printf("INT == VAR\n"); }
  | tID tUNEQUAL tNB { printf("VAR!=INT\n"); }
  | tID tUNEQUAL tID { printf("VAR!=VAR\n"); }
  | tNB tUNEQUAL tNB { printf("INT!=INT\n"); }
  | tNB tUNEQUAL tID { printf("INT!=VAR\n"); }
;
Print: 
  tPRINTF tPG tID tPD { printf("La variable a printé : %s \n", $3); }
  | tPRINTF tPG tQUOTE RemPrint tQUOTE tPD {}
  | tPRINTF tPG tQUOTE tPERCENTINT RemPrint tQUOTE tCOMMA tNB tPD { printf("Nous printons : %d \n",$8); }
  | tPRINTF tPG tQUOTE tPERCENTINT RemPrint tQUOTE tCOMMA tID tPD { printf("Nous printons : %s \n",$8); }
  | tPRINTF tPG tQUOTE RemPrint tPERCENTINT RemPrint tQUOTE tCOMMA tID tPD { printf("Nous printons : %s \n",$9); }
  | tPRINTF tPG tQUOTE RemPrint tPERCENTINT RemPrint tQUOTE tCOMMA tNB tPD { printf("Nous printons : %d \n",$9); }
;
RemPrint:
  | tID RemPrint { printf("Nous printons : %s \n",$1); }
;
Function:
  VariableType tID tPG ParamFunction tPD tAG Program tAD{ printf("Declaration de la fonction : '%s' \n", $2); }
;
ParamFunction:
  | VariableDeclaration {}
;

%%

void yyerror (char const *s) {
	fprintf (stderr, "%s\n", s);
}

int main(void) {
	pile = initPile();
	assembly = initAsm();
  yyparse();
  return 0;
}
