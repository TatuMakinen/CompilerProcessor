%{
  #include "compiler.tab.h"
%}

%%
if                   {return tIF;}
while                {return tWHILE;}
else                 {return tELSE;}
main                 {return tMAIN;}
const                {return tCONST;}
return               {return tRETURN;}
printf               {return tPRINTF;}
"{"                  {return tACOLGAU;}
"}"                  {return tACOLDROI;}
";"                  {return tSEMICOLON;}
","                  {return tCOMMA;}
"+"                  {return tPLUS;}
"-"                  {return tMINUS;}
"/"                  {return tSLASH;}
"*"                  {return tMUL;}
"="                  {return tEQUAL;}
"("                  {return tPARGAU;}
")"                  {return tPARDROI;}
\n+                  {return tEOF;}
\t+                  {return tTAB;}
" "+                 {return tSPACE;}
[a-z]+               {return tSTRING;}
[0-9]+               {return tINT;}
[a-zA-Z0-9_]+        {return tVARIABLE;}
[0-9]+E-?[0-9]+      {return tEXP;}
