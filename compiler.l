%{
#include "compiler.tab.h"
#include <string.h>
%}

%%
if                      {return tIF;}
while                   {return tWHILE;}
else                    {return tELSE;}
main                    {return tMAIN;}
const                   {return tCONST;}
return                  {return tRETURN;}
printf                  {return tPRINTF;}
String                  {return tSTRING;}
int                     {return tINT;}
void                    {return tVOID;}
"{"                     {return tAG;}
"}"                     {return tAD;}
";"                     {return tSEMICOLON;}
","                     {return tCOMMA;}
"+"                     {return tPLUS;}
"-"                     {return tMINUS;}
"/"                     {return tSLASH;}
"*"                     {return tMUL;}
"="                     {return tEQUAL;}
"!="                    {return tUNEQUAL;}
"<"                     {return tLESS;}
"<="                    {return tLESSEQUAL;}
">"                     {return tGREATER;}
">="                    {return tGREATEREQUAL;}
"("                     {return tPG;}
")"                     {return tPD;}
"\""                    {return tQUOTE;}
"\%d"                   {return tPERCENTINT;}
"$1"                    {return tFIRSTARG;}
[0-9]+                  {yylval.nb=atoi(yytext);
                        return tNB;}
[a-zA-Z][a-zA-Z0-9_]*   {yylval.str=strdup(yytext);
                        return tID;}
[0-9]+E-?[0-9]+         {return tEXP;}
[0-9a-zA-Z_]+           {yylval.str=strdup(yytext);
                        return tCHAINE;}
[ \n\t];
