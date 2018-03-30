%{
  #include <stdio.h>
  #include "tableSymbole.c"
  int yylex(void);
  void yyerror(char*);
  Pile *pile;
  char* type;
  char* name;
  int res;
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
      printf("Declaration de la fonction : 'main' \n");
    }
    ;
  Program : Line RemindProgram {};
  RemindProgram : {};
    | Line RemindProgram {};
  Line : Content tSEMICOLON;
  Content : {printf("Content : 'none' \n");};
    |Arithmetique {};
    |VariableDefinition  {};
    |VariableDeclaration  {};
    |IfElseStatement {};
	  |Print {};

  Arithmetique : VariableDefinition RemArith {};
    | Variable tEQUAL tPG VarInt RemArith tPD  RemArith {};
  Operation : tPLUS {printf("Addition");};
    |tMINUS {printf("Soustraction");}
    |tSLASH {printf("Division");};
    |tMUL {printf("Multiplication");};
  RemArith : Operation tPG VarInt RemArith tPD{};
    | Operation VarInt RemArith {};
    | Operation VarInt {};


  VariableType : {};
    | tINT {type = "int";printf(" int ");}
  VariableDeclaration : Variable RemVariable {empiler(pile,type,name,0);printf("-Declaration");};
  VariableDefinition : Variable tEQUAL VarInt {empiler(pile, type,name,0);afficherPile(pile);printf("-Definition");};
  Variable :  VariableType tVARIABLE {name = $2;printf("Variable: '%s'", $2);};
  RemVariable : {};
    |tCOMMA tVARIABLE RemVariable {name = $2;empiler(pile,type,name,0);printf("Variable2: '%s' ", $2);};
  VarInt : tINTEGER {printf("%d \n",$1);};
    | tVARIABLE {printf("Voici ton string %s",$1);};





/*
int adr = empiler(pile,'i',$1,1);printf("AFC r0 %d\n",$1);printf("STORE %d r0 \n",adr)
empiler(&pile,'i',$1,1);
printf("LOAD r0 %d\n",pile->premier);printf("LOAD r1 %d\n",pile->premier->suivant);printf("ADD R0 R1");printf("STORE %d R0",pile->premier->suivant);depiler(pile);
*/


  Print : tPRINTF tPG tQUOTE tVARIABLE tQUOTE tPD {printf("Nous printons : '%s'\n",$4);};
    | tPRINTF tPG
  /*| tPRINTF tPG tQUOTE RemPrint tQUOTE tCOMMA tVARIABLE tPD {printf("Nous printons : '%s'\n",$7)};
  Print : tPRINTF tPG tQUOTE tSTRING tQUOTE tPD {printf("Nous printons : '%s'\n",$4);};
  | tPRINTF tPG tQUOTE RemPrint tQUOTE tCOMMA tVARIABLE tPD {printf("Nous printons : '%s'\n",$7);};
  RemPrint : {printf("Content : 'none' \n");}
  | tPERCENTINT tSTRING {};
  | tSTRING RemPrint {};*/
%%

int main(void) {
  pile = initPile();
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
