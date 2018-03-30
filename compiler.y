%{
  #include <stdio.h>
  #include "tableSymbole.c"
  int yylex(void);
  void yyerror(char*);
  Pile pile;
  pile = initPile(&pile);
%}

%union { char* str; int nb; }

%token tIF tWHILE tELSE tMAIN tQUOTE  tCONST tINTEGER tRETURN tPRINTF tSTRING tAG tAD tSEMICOLON tCOMMA tPLUS tMINUS tSLASH tMUL tEQUAL tPG tPD tINT tVARIABLE tEXP tFIRSTARG tPERCENTINT
%type <str> tVARIABLE
%type <nb> tINTEGER
//%type <str> tSTRING
%left tPLUS tMINUS
%left tMUL tSLASH
%%

  Main :
    tINT tMAIN tPG tPD tAG Program tAD
    {
      int adr = empiler(pile, "a", "test", 1);
      printf("Declaration de la fonction : 'main' \n %d",adr);
    }
    ;
  Program : Line RemindProgram {};
  RemindProgram : {};
    | Line RemindProgram {};
  Line : Content tSEMICOLON;
  Content : {printf("Content : 'none' \n");};
    |Addition {};
    |VariableDefinition  {};
    |VariableDeclaration  {};
	|Print {};

  VariableType : tINT {printf(" int ");};
  VariableDeclaration : Variable RemVariable {printf("-Declaration");};
  VariableDefinition : Variable tEQUAL VariableTmp {printf("-Definition");};
  Variable :  VariableType tVARIABLE {printf("Variable: '%s' ", $2);};
  RemVariable : {};
    |tCOMMA tVARIABLE RemVariable {printf("Variable2: '%s' ", $2);};


  VariableTmp : tINTEGER {printf("%d ",$1);};
    | tVARIABLE {printf("Voici ton string %s",$1);};
/*
int adr = empiler(pile,'i',$1,1);printf("AFC r0 %d\n",$1);printf("STORE %d r0 \n",adr)
empiler(&pile,'i',$1,1);
printf("LOAD r0 %d\n",pile->premier);printf("LOAD r1 %d\n",pile->premier->suivant);printf("ADD R0 R1");printf("STORE %d R0",pile->premier->suivant);depiler(pile);
*/

  Addition : Variable tEQUAL VariableTmp tPLUS VariableTmp {printf("+");};

  Print : tPRINTF tPG tQUOTE tVARIABLE tQUOTE tPD {printf("Nous printons : '%s'\n",$4);};
  /*| tPRINTF tPG tQUOTE RemPrint tQUOTE tCOMMA tVARIABLE tPD {printf("Nous printons : '%s'\n",$7)};
  Print : tPRINTF tPG tQUOTE tSTRING tQUOTE tPD {printf("Nous printons : '%s'\n",$4);};
  | tPRINTF tPG tQUOTE RemPrint tQUOTE tCOMMA tVARIABLE tPD {printf("Nous printons : '%s'\n",$7);};
  RemPrint : {printf("Content : 'none' \n");}
  | tPERCENTINT tSTRING {};
  | tSTRING RemPrint {};*/
%%

int main(void) {
  yyparse();
  return 0;
}


/*Program :
  | Fonction Program
  ;

Fonction :
  tVARIABLE tPARGAU tPARDROI tACOLGAU tACOLDROI
  {
    printf("Declaration de la fonction : '%s' \n", $1);
  }
  ; */
