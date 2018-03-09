%union { char str[80]; int nb; }

%token tID tPO tPF tAO tAF
%type <dtr> tID

%%

Program :
  | Fonction Program
  ;

Fonction :
  tID tPO tPF tAO tAF
  {
    printf("Declaration de la fonction : '%s' \n", $1);
  }
  ;

%%

int main(void) {
  yyparse();
  return 0;
}
