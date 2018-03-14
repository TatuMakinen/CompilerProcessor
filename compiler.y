%union { char str[80]; int nb; }

%token tIF tWHILE tELSE tMAIN tCONST tRETURN tPRINTF tACOLGAU tACOLDROI tSEMICOLON tCOMMA tPLUS tMINUS tSLASH tMUL tEQUAL tPARGAU tPARDROI tEOF tTAB tSPACE tINT tVARIABLE tEXP
%type <str> tVARIABLE

%%

Program :
  | Fonction Program
  ;

Fonction :
  tVARIABLE tPARGAU tPARDROI tACOLGAU tACOLDROI
  {
    printf("Declaration de la fonction : '%s' \n", $1);
  }
  ;

%%

int main(void) {
  yyparse();
  return 0;
}

yyerror() {}
yywrap() {}