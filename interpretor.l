%{
#include "interpretor.tab.h"
#include <string.h>
%}

%%
"ADD" 	{return tADD;}
"MUL"		{return tMUL;}
"SOU"		{return tSOU;}
"DIV"		{return tDIV;}
"COP"		{return tCOP;}
"AFC"		{return tAFC;}
"LOAD"	{return tLOAD;}
"STORE"	{return tSTORE;}
"EQU"		{return tEQU;}
"INF"		{return tINF;}
"INFE"	{return tINFE;}
"SUP"		{return tSUP;}
"SUPE"	{return tSUPE;}
"JMP"		{return tJMP;}
"JMPC"	{return tJMPC;}
[0-9]+  {yylval.nb=atoi(yytext);return tNB;}
";"    {return tSEMICOLON;}

[ \n\t];
