%%
if      {printf("#~Found IF\n");}
while   {printf("#~Found WHILE\n");}
else    {printf("#~Found else\n");}
main    {printf("#~Found main\n");}
const   {printf("#~Found const\n");}
"{"     {printf("#~Found {\n");}
"}"     {printf("#~Found }\n");}
"("     {printf("#~Found (\n");}
")"     {printf("#~Found )\n");}
" "     {printf("#~Found space\n");}
";"     {printf("#~Found ;\n");}
","     {printf("#~Found ,\n");}
[a-z]+  {printf("#~Found string\n");}
[0-9]+  {printf("#~Found int\n");}
"+"     {printf("#~Found plus\n");}
"-"     {printf("#~Found minus\n");}
"x"     {printf("#~Found minus\n");}
"-"     {printf("#~Found minus\n");}
