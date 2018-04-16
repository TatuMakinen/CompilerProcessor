%{
  #include <stdio.h>
  #include "tableSymbole.c"
	#include "jumpTable.c"
  #include "assemblerStruct.c"




  int yylex(void);
  void yyerror(char*);
  Pile *pile;
  char* type;
  char* name;
  int depth = 0;
  Inst asmo[15];
  int taille_effective = 0;
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
				printf("Declaration de la fonction : 'main' \n");};
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
  							empiler(pile, type,name,depth);};

  	Affectation : tID tEQUAL Expression {
              add_instruction(asmo, taille_effective, "LOAD", 0, peek(pile), -1);taille_effective++;
  						depiler(pile);
              add_instruction(asmo, taille_effective, "STORE", find($1), 0, -1);taille_effective++;};



  	Expression : Expression tPLUS Expression {
  																				depiler(pile);
                                          add_instruction(asmo, taille_effective, "LOAD", 1, peek(pile), -1);taille_effective++;
                                          add_instruction(asmo, taille_effective, "ADD", 0, 0, 1);taille_effective++;
                                          add_instruction(asmo, taille_effective, "STORE", peek(pile), 0, -1);taille_effective++;
  																				empiler(pile, "int","tmp",depth);
                                          display_struct(asmo,taille_effective);
                                        };
  		|tNB {
  						empiler(pile,"int","tmp",depth);
              add_instruction(asmo, taille_effective, "AFC", 0, $1, -1);taille_effective++;
              add_instruction(asmo, taille_effective, "STORE", peek(pile), 0, -1);taille_effective++;
            };
  		|tID {
  						empiler(pile,"str","tmp",depth);
              add_instruction(asmo, taille_effective, "LOAD", 0, find($1), -1);taille_effective++;
              add_instruction(asmo, taille_effective, "STORE", peek(pile), 0, -1);taille_effective++;
              };

  While : tWHILE tPG Boolean tPD tAG RemindProgram tAD {printf("while\n");};
  If : StartIf RemindProgram tAD RemainIf {addInstruction(taille_effective)};
  RemainIf : {};
    | StartElse RemindProgram tAD {};

  StartIf : tIF tPG Boolean tPD tAG {++depth;printf("Depth = %d\n",depth);insertQueue(taille_effective);};
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
    | VariableDeclaration;

%%


int main(void) {
  pile = initPile();
  yyparse();
  return 0;
}
