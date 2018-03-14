%{
#include "compiler.tab.h"
%}

%%
if                      {return tIF;}
while                   {return tWHILE;}
else                    {return tELSE;}
main                    {return tMAIN;}
const                   {return tCONST;}
return                  {return tRETURN;}
printf                  {return tPRINTF;}
int                     {return tINT;}
"{"                     {return tACOLGAU;}
"}"                     {return tACOLDROI;}
";"                     {return tSEMICOLON;}
","                     {return tCOMMA;}
"+"                     {return tPLUS;}
"-"                     {return tMINUS;}
"/"                     {return tSLASH;}
"*"                     {return tMUL;}
"="                     {return tEQUAL;}
"("                     {return tPARGAU;}
")"                     {return tPARDROI;}
[0-9]+                  {yylval.nb=atoi(yytext);
                        return tINTEGER;}
[a-zA-Z][a-zA-Z0-9_]*   {yylval.str=strdup(yytext);
                        return tVARIABLE;}
[0-9]+E-?[0-9]+         {return tEXP;}
[ \n\t];
