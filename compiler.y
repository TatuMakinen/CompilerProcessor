%{
  #include <stdio.h>
  #include "tableSymbole.c"
	#include "jumpTable.c"
  #include "assemblerStruct.c"




  int yylex(void);
  void yyerror(char*);
  char* type;
  char* name;
  int depth = 0;
	Pile *pile;
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

  Main :
    tINT tMAIN tPG tPD tAG RemindProgram tAD{
				printf("Declaration  de la fonction : 'main' \n");};
  RemindProgram : {};
    |Line RemindProgram {};
  Line : Content tSEMICOLON {};
	  |If {};
    |While {};
    |Function {};
  Content : {printf("Content: 'none' \n");};
    |VariableDefinition  {};
    |VariableDeclaration  {};
    |Print {};
    |Affectation {};

    VariableType : tINT {type = "int";};
    | tVOID {type ="void";};
    | tSTRING {type ="string";};
    VariableDeclaration : VariableType tID RemVariable {
  				name = $2;
  				empiler(pile,type,name,depth);};
  	RemVariable : {};
      |tCOMMA tID RemVariable {name = $2;empiler(pile,type,name,depth);};


    VariableDefinition : VariableType tID tEQUAL Expression{
  							depiler(pile);
  							empiler(pile,type,name,depth);};

  	Affectation : tID tEQUAL Expression {
              add_instruction(assembly,"LOAD", 0, peek(pile), -1);
  						depiler(pile);
              add_instruction(assembly,"STORE", find(pile,$1), 0, -1);};



  	Expression : Expression tPLUS Expression {
								depiler(pile);
                add_instruction(assembly,"LOAD", 1, peek(pile), -1);
                add_instruction(assembly,"ADD", 0, 0, 1);
                add_instruction(assembly,"STORE", peek(pile), 0, -1);
								empiler(pile,"int","tmp",depth);
                display_struct(assembly);
              };
      | Expression tMINUS Expression {
              depiler(pile);
              add_instruction(assembly,"LOAD",1,peek(pile),-1);
              add_instruction(assembly,"SUB",0,0,1);
              add_instruction(assembly,"STORE",peek(pile),0,-1);
              empiler(pile,"int","tmp",depth);
              display_struct(assembly);
      };
      | Expression tMUL Expression {
        depiler(pile);
        add_instruction(assembly,"LOAD",1,peek(pile),-1);
        add_instruction(assembly,"MUL",0,0,1);
        add_instruction(assembly,"STORE",peek(pile),0,-1);
        empiler(pile,"int","tmp",depth);
        display_struct(assembly);
      }
      | Expression tSLASH Expression {
        depiler(pile);
        add_instruction(assembly,"LOAD",1,peek(pile),-1);
        add_instruction(assembly,"DIV",0,0,1);
        add_instruction(assembly,"STORE",peek(pile),0,-1);
        empiler(pile,"int","tmp",depth);
        display_struct(assembly);
      }
  		|tNB {
  						empiler(pile,"int","tmp",depth);
              add_instruction(assembly,"AFC", 0, $1, -1);
              add_instruction(assembly,"STORE", peek(pile), 0, -1);
            };
  		|tID {
  						empiler(pile,"str","tmp",depth);
              add_instruction(assembly,"LOAD", 0, find(pile,$1), -1);
              add_instruction(assembly,"STORE", peek(pile), 0, -1);};

  While : tWHILE tPG Boolean tPD tAG RemindProgram tAD {printf("while\n");};
  If : StartIf RemindProgram tAD RemainIf {addInstruction(assembly->tailleEffective);};
  RemainIf : {};
    | StartElse RemindProgram tAD {};

  StartIf : tIF tPG Boolean tPD tAG {++depth;printf("Depth = %d\n",depth);
								insertQueue(assembly->tailleEffective);};
  StartElse : tELSE tAG {printf("Depth = %d\n",depth);};
  Boolean :	tID tEQUAL tEQUAL tNB {printf("VAR == INT\n");}
  			| tID tEQUAL tEQUAL tID {printf("VAR == VAR\n");}
  			| tNB tEQUAL tEQUAL tNB {printf("INT == INT\n");}
  			| tNB tEQUAL tEQUAL tID {printf("INT == VAR\n");}
  			| tID tUNEQUAL tNB {printf("VAR!=INT\n");}
  			| tID tUNEQUAL tID {printf("VAR!=VAR\n");}
  			| tNB tUNEQUAL tNB {printf("INT!=INT\n");}
  			| tNB tUNEQUAL tID {printf("INT!=VAR\n");}

  Print : tPRINTF tPG tID tPD {printf("La variable a printé : %s \n", $3);};
    | tPRINTF tPG tQUOTE RemPrint tQUOTE tPD {};
    | tPRINTF tPG tQUOTE tPERCENTINT RemPrint tQUOTE tCOMMA tNB tPD {printf("Nous printons : %d \n",$8);};
    | tPRINTF tPG tQUOTE tPERCENTINT RemPrint tQUOTE tCOMMA tID tPD {printf("Nous printons : %s \n",$8);};
    | tPRINTF tPG tQUOTE RemPrint tPERCENTINT RemPrint tQUOTE tCOMMA tID tPD {printf("Nous printons : %s \n",$9);};
    | tPRINTF tPG tQUOTE RemPrint tPERCENTINT RemPrint tQUOTE tCOMMA tNB tPD {printf("Nous printons : %d \n",$9);};

  RemPrint : {};
    | tID RemPrint {printf("Nous printons : %s \n",$1);};

  Function : VariableType tID tPG ParamFunction tPD tAG RemindProgram tAD{printf("Declaration de la fonction : '%s' \n", $2);};

  ParamFunction : {};
    | VariableDeclaration {};

%%


int main(void) {
	pile = initPile();
	assembly = initAsm(); 
  yyparse();
  return 0;
}
