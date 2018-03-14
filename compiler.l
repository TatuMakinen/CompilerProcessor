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
"{"                     {return tAG;}
"}"                     {return tAD;}
";"                     {return tSEMICOLON;}
","                     {return tCOMMA;}
"+"                     {return tPLUS;}
"-"                     {return tMINUS;}
"/"                     {return tSLASH;}
"*"                     {return tMUL;}
"="                     {return tEQUAL;}
"("                     {return tPG;}
")"                     {return tPD;}
"\""                    {return tQUOTE;}
"\%d"                   {return tPERCENTINT;}
"\%s"                   {return tPERCENTSTRING;}
"$1"                    {return tFIRSTARG;}
[0-9]+                  {yylval.nb=atoi(yytext);
                        return tINTEGER;}
[a-zA-Z0-9_]+           {yylval.str=strdup(yytext);
                        return tSTRING;}
[a-zA-Z][a-zA-Z0-9_]*   {yylval.str=strdup(yytext);
                        return tVARIABLE;}
[0-9]+E-?[0-9]+         {return tEXP;}
[ \n\t];
