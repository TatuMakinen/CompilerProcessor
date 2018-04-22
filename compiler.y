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
	Jump* jump;
%}

%union { char* str; int nb;}

%token tIF tWHILE tELSE tMAIN tQUOTE tCHAINE tCONST tNB tRETURN tPRINTF tSTRING
tAG tAD tSEMICOLON tCOMMA tPLUS tMINUS tSLASH tMUL tEQUAL tUNEQUAL tLESS tLESSEQUAL 
tGREATER tGREATEREQUAL tPG tPD tINT tVOID tID tEXP tFIRSTARG tPERCENTINT
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
		afficherPile(pile);display_struct(assembly);
  }
;
Program:

  | Line Program {}
;
Line:
  Content tSEMICOLON {}
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
    add_instruction(assembly,LOAD, 0, peek(pile), -1);
    depiler(pile);
    add_instruction(assembly,STORE, find(pile,$1), 0, -1);
  }
;
// Variable is defined - added to the table
VariableDefinition:
  VariableType tID tEQUAL Expression
  {
    depiler(pile); empiler(pile,type,$2,depth);
		add_instruction(assembly,STORE, peek(pile), 0, -1);
  }
;
// Arithmetic operations
Expression:
  Expression tPLUS Expression
  {
		add_instruction(assembly,LOAD, 0, peek(pile), -1);
    depiler(pile);
    add_instruction(assembly,LOAD, 1, peek(pile), -1);
		depiler(pile);
    add_instruction(assembly,ADD, 0, 0, 1);
		empiler(pile,"int","tmp",depth);
		add_instruction(assembly,STORE, peek(pile), 0, -1);
  }
  | Expression tMINUS Expression
  {
		add_instruction(assembly,LOAD, 0, peek(pile), -1);
		depiler(pile);
    add_instruction(assembly,LOAD,1,peek(pile),-1);
		depiler(pile);
    add_instruction(assembly,SUB,0,0,1);
		empiler(pile,"int","tmp",depth);
		add_instruction(assembly,STORE, peek(pile), 0, -1);
  }
  | Expression tMUL Expression
  {
		add_instruction(assembly,LOAD, 0, peek(pile), -1);
    depiler(pile); 
    add_instruction(assembly,LOAD,1,peek(pile),-1);
		depiler(pile);
    add_instruction(assembly,MUL,0,0,1);
		empiler(pile,"int","tmp",depth);
		add_instruction(assembly,STORE, peek(pile), 0, -1);
  }
  | Expression tSLASH Expression
  {
		add_instruction(assembly,LOAD, 0, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,1,peek(pile),-1);
		depiler(pile);
    add_instruction(assembly,DIV,0,0,1);
		empiler(pile,"int","tmp",depth);
		add_instruction(assembly,STORE, peek(pile), 0, -1);
  }
  | tNB 
  {
    add_instruction(assembly,AFC, 0, $1, -1);
		empiler(pile,"int","tmp",depth);
    add_instruction(assembly,STORE, peek(pile), 0, -1);
  }
  | tID
  {
    add_instruction(assembly,LOAD, 0, find(pile,$1), -1);
		empiler(pile,"str","tmp",depth);
    add_instruction(assembly,STORE, peek(pile), 0, -1);
  }
;
While:
  tWHILE tPG Boolean tPD tAG Program tAD { printf("while\n"); }
;
If:
  StartIf Program tAD RemainIf 
	{
		jump = add_jump(assembly->tailleEffective);  
		add_jmf_destination(assembly,jump->if_adr,jump->dest_adr); 
	}
;
RemainIf:

  | StartElse Program tAD {}
;
StartIf:
  tIF tPG Boolean tPD tAG 
  {
    ++depth; printf("Depth = %d\n",depth);
  }
;
StartElse:
  tELSE tAG  { printf("Depth = %d\n",depth); }
;
Boolean:
  Expression tEQUAL tEQUAL Expression 
	{ 
		add_instruction(assembly,LOAD, 0, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,1,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,CMP,0,1,-1);
		insertQueue(assembly->tailleEffective);
		add_instruction(assembly,JNE,-1,-1,-1);

	}
  | Expression tUNEQUAL Expression 
	{
		add_instruction(assembly,LOAD, 0, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,1,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,CMP,0,1,-1);
		insertQueue(assembly->tailleEffective);
		add_instruction(assembly,JE,-1,-1,-1);
	}
	| Expression tLESS Expression 
	{
		add_instruction(assembly,LOAD, 0, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,1,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,CMP,0,1,-1);
		insertQueue(assembly->tailleEffective);
		add_instruction(assembly,JL,-1,-1,-1);
	}
	| Expression tLESSEQUAL Expression 
	{
		add_instruction(assembly,LOAD, 0, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,1,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,CMP,0,1,-1);
		insertQueue(assembly->tailleEffective);
		add_instruction(assembly,JLE,-1,-1,-1);
	}
	| Expression tGREATER Expression 
	{
		add_instruction(assembly,LOAD, 0, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,1,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,CMP,0,1,-1);
		insertQueue(assembly->tailleEffective);
		add_instruction(assembly,JG,-1,-1,-1);
	}
	| Expression tGREATEREQUAL Expression 
	{
		add_instruction(assembly,LOAD, 0, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,1,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,CMP,0,1,-1);
		insertQueue(assembly->tailleEffective);
		add_instruction(assembly,JGE,-1,-1,-1);
	}
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
	enum assembly_cmds {ADD,SUB,MUL,DIV,STORE,LOAD,AFC,CMP,JE,JNE,JL,JLE,JG,JGE};
	pile = initPile();
	assembly = initAsm();
  yyparse();
  return 0;
}
