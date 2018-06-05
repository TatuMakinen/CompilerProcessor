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
    changeTopId(pile,$2);
  }
;
// Arithmetic operations
Expression:
  Expression tPLUS Expression
  {
		add_instruction(assembly,LOAD, 2, peek(pile), -1);
    depiler(pile);
    add_instruction(assembly,LOAD, 1, peek(pile), -1);
		depiler(pile);
    add_instruction(assembly,ADD, 0, 1, 2);
		empiler(pile,"int","tmp",depth);
		add_instruction(assembly,STORE, peek(pile), 0, -1);
  }
  | Expression tMINUS Expression
  {
		add_instruction(assembly,LOAD, 2, peek(pile), -1);
		depiler(pile);
    add_instruction(assembly,LOAD,1,peek(pile),-1);
		depiler(pile);
    add_instruction(assembly,SOU,0,1,2);
		empiler(pile,"int","tmp",depth);
		add_instruction(assembly,STORE, peek(pile), 0, -1);
  }
  | Expression tMUL Expression
  {
		add_instruction(assembly,LOAD, 2, peek(pile), -1);
    depiler(pile); 
    add_instruction(assembly,LOAD,1,peek(pile),-1);
		depiler(pile);
    add_instruction(assembly,MUL,0,1,2);
		empiler(pile,"int","tmp",depth);
		add_instruction(assembly,STORE, peek(pile), 0, -1);
  }
  | Expression tSLASH Expression
  {
		add_instruction(assembly,LOAD, 2, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,1,peek(pile),-1);
		depiler(pile);
    add_instruction(assembly,DIV,0,1,2);
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
		empiler(pile,"int","tmp",depth);
    add_instruction(assembly,STORE, peek(pile), 0, -1);
  }
;
While:
	StartWhile tPG InverseBoolean tPD tAG Program tAD 
	{ 
		add_instruction(assembly,JMP,-1,-1,-1);
		int jmf_line = removeQueue();
		add_jmp_destination(assembly,jmf_line, assembly->tailleEffective); // Add destination to JMPC
		int jmp_line = removeQueue();
		add_jmp_destination(assembly,assembly->tailleEffective-1,jmp_line); // Add destination to JMP
	}
;
StartWhile:
	tWHILE { insertQueue(assembly->tailleEffective+1); } // Save line nb to what follows (INF,...)
;
If:
  StartIf Program tAD RemainIf {}
;
RemainIf:
	{
		add_jmp_destination(assembly,removeQueue(),assembly->tailleEffective);
	}
  | StartElse Program tAD 
	{
		add_jmp_destination(assembly,removeQueue(),assembly->tailleEffective);
	}
;
StartIf:
  tIF tPG Boolean tPD tAG 
  {
    ++depth;
  }
;
StartElse:
  tELSE tAG 
	{
		add_instruction(assembly,JMP,-1,-1,-1);
		add_jmp_destination(assembly,removeQueue(),assembly->tailleEffective);
		insertQueue(assembly->tailleEffective);
	}
;
Boolean:
  Expression tEQUAL tEQUAL Expression 
	{ 
		add_instruction(assembly,LOAD, 1, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,2,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,EQU,0,1,2);
		add_instruction(assembly,JMPC,-1,0,-1);
		insertQueue(assembly->tailleEffective);
	}
  | Expression tUNEQUAL Expression 
	{
		add_instruction(assembly,LOAD, 1, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,2,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,EQU,0,1,2);
		add_instruction(assembly,AFC,1,0,-1);	// To get inverse of EQU
		add_instruction(assembly,EQU,0,0,1);
		add_instruction(assembly,JMPC,-1,0,-1);
		insertQueue(assembly->tailleEffective);
	}
	| Expression tLESS Expression 
	{
		add_instruction(assembly,LOAD, 1, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,2,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,INF,0,1,2);
		add_instruction(assembly,JMPC,-1,0,-1);
		insertQueue(assembly->tailleEffective);
	}
	| Expression tLESSEQUAL Expression 
	{
		add_instruction(assembly,LOAD, 1, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,2,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,INFE,0,1,2);
		add_instruction(assembly,JMPC,-1,0,-1);
		insertQueue(assembly->tailleEffective);
	}
	| Expression tGREATER Expression 
	{
		add_instruction(assembly,LOAD, 1, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,2,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,SUP,0,1,2);
		add_instruction(assembly,JMPC,-1,0,-1);
		insertQueue(assembly->tailleEffective);
	}
	| Expression tGREATEREQUAL Expression 
	{
		add_instruction(assembly,LOAD, 1, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,2,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,SUPE,0,1,2);
		add_instruction(assembly,JMPC,-1,0,-1);
		insertQueue(assembly->tailleEffective);
	}
;
InverseBoolean:
  Expression tEQUAL tEQUAL Expression 
	{
		add_instruction(assembly,LOAD, 1, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,2,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,EQU,0,1,2);
		add_instruction(assembly,JMPC,-1,0,-1);
		insertQueue(assembly->tailleEffective);
	}
  | Expression tUNEQUAL Expression 
	{
		add_instruction(assembly,LOAD, 2, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,3,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,EQU,1,2,3);
		add_instruction(assembly,AFC,2,0,-1);	// To get inverse of EQU
		add_instruction(assembly,EQU,0,1,2);
		add_instruction(assembly,JMPC,-1,0,-1);
		insertQueue(assembly->tailleEffective);
	}
	| Expression tLESS Expression 
	{
		add_instruction(assembly,LOAD, 1, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,2,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,SUP,0,1,2);
		add_instruction(assembly,JMPC,-1,0,-1);
		insertQueue(assembly->tailleEffective);
	}
	| Expression tLESSEQUAL Expression 
	{
		add_instruction(assembly,LOAD, 1, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,2,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,SUPE,0,1,2);
		add_instruction(assembly,JMPC,-1,0,-1);
		insertQueue(assembly->tailleEffective);
	}
	| Expression tGREATER Expression 
	{
		add_instruction(assembly,LOAD, 1, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,2,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,INF,0,1,2);
		add_instruction(assembly,JMPC,-1,0,-1);
		insertQueue(assembly->tailleEffective);
	}
	| Expression tGREATEREQUAL Expression 
	{
		add_instruction(assembly,LOAD, 1, peek(pile), -1); 
    depiler(pile);
    add_instruction(assembly,LOAD,2,peek(pile),-1);
		depiler(pile);
		add_instruction(assembly,INFE,0,1,2);
		add_instruction(assembly,JMPC,-1,0,-1);
		insertQueue(assembly->tailleEffective);
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
	pile = initPile();
	assembly = initAsm();
  if(yyparse()) {
		printf("Compile failed!\n");
	}else{
		printf("Compile succesful!\n");
		afficherPile(pile);
		display_struct(assembly);
		save_assembly_to_file(assembly,"asm_code");
		save_hex_to_file(assembly,"/home/makinen/Processeur/rom1.hex");
	}



  return 0;
}
