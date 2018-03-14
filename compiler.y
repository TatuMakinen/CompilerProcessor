%{#include <stdio.h>
  int yylex(void);
  void yyerror(char*);
%}

%union { char* str; int nb; }

%token tIF tWHILE tELSE tMAIN tQUOTE  tCONST tINTEGER tRETURN tPRINTF tAG tAD tSEMICOLON tCOMMA
       tPLUS tMINUS tSLASH tMUL tEQUAL tPG tPD tINT tSTRING tVARIABLE tEXP tFIRSTARG tPERCENTINT tPERCENTSTRING
%type <str> tVARIABLE
%type <nb> tINTEGER
%type <str> tSTRING
%%

  Main :
    tINT tMAIN tPG tPD tAG Line tAD
    {
      printf("Declaration de la fonction : 'main' \n");
    }
    ;
  Line : Content tSEMICOLON
  Content : {printf("Content : 'none' \n")}
    |VariableDefinition {};
    |VariableDeclaration {};
    |Print {};

  VariableDeclaration : Variable {};
  VariableDefinition : Variable tEQUAL tINTEGER {printf("Valeur de la variable : '%d'\n",$3)};
  Variable :  tINT tVARIABLE RemVariable {printf("Nom de la Variable 1: '%s' \n", $2)};
  RemVariable : {printf("Variable : 'none' \n")};
    |tCOMMA tVARIABLE RemVariable {printf("Variable 2 : '%s' \n", $2)};

  Print : tPRINTF tPG tQUOTE tSTRING tQUOTE tPD {printf("Nous printons : '%s'\n",$4)};
  | tPRINTF tPG tQUOTE RemPrint tQUOTE tCOMMA tVARIABLE tPD {printf("Nous printons : '%s'\n",$)};

  RemPrint : {printf("Content : 'none' \n")}
  | tPERCENTINT tSTRING {};
  | tSTRING RemPrint {};
  | tPERCENTSTRING tSTRING {};
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
