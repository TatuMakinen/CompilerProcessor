#include <string.h>

typedef struct Inst Inst;
struct Inst{
  char* id;
  int param[3];
};
void display_struct(Inst* asmo, int taille_tableau){
  int i;

  for(i=0;i<taille_tableau;i++){
      printf("Pour l'instruction %s \n",asmo[i].id);
  }

}

void add_instruction(Inst* asmo, int taille_effective, char* id, int param1, int param2, int param3){
  asmo[taille_effective].id = id;
  if(param1 != -1)
    asmo[taille_effective].param[0] = param1;
  if(param2 != -1)
    asmo[taille_effective].param[1] = param2;
  if(param3 != -1)
    asmo[taille_effective].param[2] = param3;
}
