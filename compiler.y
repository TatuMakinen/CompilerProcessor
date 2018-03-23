%{
  #include <stdio.h>
  #include "tableSymbole.c"
  int yylex(void);
  void yyerror(char*);
%}

%union { char* str; int nb; }

%token tIF tWHILE tELSE tMAIN tQUOTE  tCONST tINTEGER tRETURN tPRINTF tSTRING tAG tAD tSEMICOLON tCOMMA
       tPLUS tMINUS tSLASH tMUL tEQUAL tPG tPD tINT tVARIABLE tEXP tFIRSTARG tPERCENTINT
%type <str> tVARIABLE
%type <nb> tINTEGER
//%type <str> tSTRING
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
    | Line RemindProgram {};
  Line : Content tSEMICOLON
  Content : {printf("Content : 'none' \n")}
    |Addition {};
    |VariableDefinition  {};
    |VariableDeclaration  {};
    |Print {};

  VariableDeclaration : Variable {};
  VariableDefinition : Variable tEQUAL tINTEGER {printf("Valeur de la variable : '%d'\n",$3)};
  Variable :  tINT tVARIABLE RemVariable {printf("Nom de la Variable 1: '%s' \n", $2)};
  RemVariable : {printf("Variable : 'none' \n")};
    |tCOMMA tVARIABLE RemVariable {printf("Variable 2 : '%s' \n", $2)};

  VariableTmp : tINTEGER {int adr = empiler(pile,'i',$1,1);printf("AFC r0 %d\n",$1);printf("STORE %d r0 \n",adr)};
    | tVARIABLE {empiler(&pile,'i',$1,1);printf("Voici ton string %s",$1)};

  Addition : Variable tEQUAL VariableTmp tPLUS VariableTmp {printf("LOAD r0 %d\n",pile->premier;printf("LOAD r1 %d\n",pile->premier->suivant);printf("ADD R0 R1");printf("STORE %d R0",pile->premier->suivant);depiler(pile))};

  Print : tPRINTF tPG tQUOTE tVARIABLE tQUOTE tPD {printf("Nous printons : '%s'\n",$4)};
  /*| tPRINTF tPG tQUOTE RemPrint tQUOTE tCOMMA tVARIABLE tPD {printf("Nous printons : '%s'\n",$7)};

  RemPrint : {printf("Content : 'none' \n")}
  | tPERCENTINT tSTRING {};
  | tSTRING RemPrint {};*/
%%

int main(void) {
  Pile* pile = initPile();
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
