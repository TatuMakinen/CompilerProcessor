%{
  #include <stdio.h>
  #include "tableSymbole.c"
  int yylex(void);
  void yyerror(char*);
  Pile *pile;
  char* type;
  char* name;
  int res;
  int depth = 0;
%}

%union { char* str; int nb;}

%token tIF tWHILE tELSE tMAIN tQUOTE tCHAINE tCONST tNB tRETURN tPRINTF tSTRING tAG tAD tSEMICOLON tCOMMA tPLUS tMINUS tSLASH tMUL tEQUAL tUNEQUAL tPG tPD tINT tVOID tID tEXP tFIRSTARG tPERCENTINT
%type <str> tID
%type <nb> tNB
%type <str> tCHAINE
%left tPLUS tMINUS
%left tMUL tSLASH
%%

  Main :
    tINT tMAIN tPG tPD tAG Program tAD
    {
      printf("Declaration de la fonction : 'main' \n");
    }
    ;
  Program : Line RemindProgram {};
  RemindProgram : {};
    |Line RemindProgram {};
  Line : Content tSEMICOLON {};
	  |If {};
    |While {};
    |Function {};
  Content : {printf("Content : 'none' \n");};
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
  						printf("LOAD 0 %d\n",peek(pile));
  						depiler(pile);
  						printf("STORE %d 0",find($1));};


  	Expression : Expression tPLUS Expression {
  																				printf("LOAD 0 %d\n",peek(pile));
  																				depiler(pile);
  																				printf("LOAD 1 %d\n",peek(pile));
  																				printf("ADD 0 0 1\n");
  																				printf("STORE %d 0\n",peek(pile));
  																				empiler(pile, "int","tmp",depth);};
  		|tNB {
  						empiler(pile,"int","tmp",depth);
  						printf("AFC 0 %d\n",$1);
  						printf("STORE %d 0\n", peek(pile));};
  		|tID {
  						empiler(pile,"str","tmp",depth);
  						printf("LOAD 0 %d\n",find($1));
  						printf("STORE %d 0",peek(pile));};

  While : tWHILE tPG Boolean tPD tAG RemindProgram tAD {printf("while\n");};
  If : StartIf RemindProgram tAD RemainIf {};
  RemainIf : {};
    | StartElse RemindProgram tAD {};

  StartIf : tIF tPG Boolean tPD tAG {++depth;printf("Depth = %d\n",depth);};
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
    | tID RemPrint {printf("Nous printons : %s \n",$1)};

  Function : VariableType tID tPG ParamFunction tPD tAG RemindProgram tAD{printf("Declaration de la fonction : '%s' \n", $2);};

  ParamFunction : {};
    | VariableDeclaration;

%%

int main(void) {
  pile = initPile();
  yyparse();
  return 0;
}


/*Program :
  | Fonction Program
  ;
*/
