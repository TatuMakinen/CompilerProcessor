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

%union { char* str; int nb; }

%token tIF tWHILE tELSE tMAIN tQUOTE tCHAINE tCONST tINTEGER tRETURN tPRINTF tSTRING tAG tAD tSEMICOLON tCOMMA tPLUS tMINUS tSLASH tMUL tEQUAL tPG tPD tINT tVARIABLE tEXP tFIRSTARG tPERCENTINT
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
    |Line RemindProgram {};
  Line : Content tSEMICOLON {};
	|If {};
  Content : {printf("Content : 'none' \n");};
    |Arithmetique {};
    |VariableDefinition  {};
    |VariableDeclaration  {};
    |Print {};


  Arithmetique : VariableDefinition RemArith {};
    | Variable tEQUAL tPG VarInt RemArith tPD  RemArith {};
  Operation : tPLUS {printf("Addition");};
    |tMINUS {printf("Soustraction");};
    |tSLASH {printf("Division");};
    |tMUL {printf("Multiplication");};
  RemArith : Operation tPG VarInt RemArith tPD{};
    | Operation VarInt RemArith {};
    | Operation VarInt {};


  VariableType : {};
    | tINT {type = "int";};
  VariableDeclaration : Variable RemVariable {empiler(pile,type,name,depth);printf("-Declaration\n");};
  VariableDefinition : Variable tEQUAL VarInt {empiler(pile, type,name,depth);afficherPile(pile);printf("-Definition\n");};
  Variable :  VariableType tVARIABLE {};
  RemVariable : {};
    |tCOMMA tVARIABLE RemVariable {name = $2;empiler(pile,type,name,depth);};
  VarInt : tINTEGER {};
    | tVARIABLE {printf("Voici ton string %s",$1);};


  If : StartIf RemindProgram EndIf {};
  EndIf : tAD;

  StartIf : tIF tPG Boolean tPD tAG {++depth;printf("Depth = %d\n",depth);};
  Boolean : {printf("Boolean ici\n");};

  Print : tPRINTF tPG tQUOTE RemPrint tQUOTE tPD {};
    | tPRINTF tPG tQUOTE tPERCENTINT RemPrint tQUOTE tCOMMA tVARIABLE tPD {printf("Nous printons : %s \n",$8);};
    | tPRINTF tPG tQUOTE RemPrint tPERCENTINT RemPrint tQUOTE tCOMMA tVARIABLE tPD {printf("Nous printons : %s \n",$9);};

  RemPrint : {};
    | tCHAINE RemPrint {printTest = $1;printf("Nous printons : %s \n",printTest)};


/*
int adr = empiler(pile,'i',$1,1);printf("AFC r0 %d\n",$1);printf("STORE %d r0 \n",adr)
empiler(&pile,'i',$1,1);
printf("LOAD r0 %d\n",pile->premier);printf("LOAD r1 %d\n",pile->premier->suivant);printf("ADD R0 R1");printf("STORE %d R0",pile->premier->suivant);depiler(pile);
*/
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
