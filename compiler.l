%%
if                   {printf("#~Found IF\n");}
while                {printf("#~Found WHILE\n");}
else                 {printf("#~Found else\n");}
main                 {printf("#~Found main\n");}
const                {printf("#~Found const\n");}
return               {printf("#~Found return\n");}
printf               {printf("#~Found return\n");} 
"{"                  {printf("#~Found {\n");}
"}"                  {printf("#~Found }\n");}
" "                  {printf("#~Found space\n");}
";"                  {printf("#~Found ;\n");}
","                  {printf("#~Found ,\n");}
"+"                  {printf("#~Found plus\n");}
"-"                  {printf("#~Found minus\n");}
"/"                  {printf("#~Found div\n");}
"*"                  {printf("#~Found multi\n");}
"="                  {printf("#~Found equal\n");}
"("                  {printf("#~Found (\n");}
")"                  {printf("#~Found )\n");}
\n                   { }
\t                   { }
" "                  { }
[a-z]+               {printf("#~Found string\n");}
[0-9]+               {printf("#~Found int\n");}
[a-zA-Z0-9_]+        {printf("#~Found variable\n");}
[0-9]+E-?[0-9]+      {printf("#~Found intExp\n");}