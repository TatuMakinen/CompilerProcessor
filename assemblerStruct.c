#include <string.h>

typedef struct Inst Inst;
struct Inst{
  char* id;
  int param[3];
};

Inst asmo[15];
int tailleEffective = 0;

void display_struct(){
  for(int i=0;i<tailleEffective;i++){
      printf("Pour l'instruction %s \n",asmo[i].id);
  }

}

void add_instruction(char* id, int param1, int param2, int param3){
  asmo[tailleEffective].id = id;
  if(param1 != -1)
    asmo[tailleEffective].param[0] = param1;
  if(param2 != -1)
    asmo[tailleEffective].param[1] = param2;
  if(param3 != -1)
    asmo[tailleEffective].param[2] = param3;
	tailleEffective++;
}

int getTailleEffective(){
	return tailleEffective;
}
