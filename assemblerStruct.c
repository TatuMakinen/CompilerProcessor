#include <string.h>

#define ASMSIZE 1000

typedef struct Inst Inst;
struct Inst{
  char* id;
  int param[3];
};

typedef struct Assembly Assembly;
struct Assembly{
	int tailleEffective;
	Inst* asmo[ASMSIZE];
};

Assembly* initAsm(){
	Assembly *assembly = malloc(sizeof(*assembly));
	assembly->tailleEffective = 0;
	return assembly;
}
	

void display_struct(Assembly* assembly){
  printf("asd");
  for(int i=0;i<assembly->tailleEffective;i++){
      printf("Pour l'instruction %s \n",(assembly->asmo[i])->id);
  }

}

void add_instruction(Assembly* assembly, char* id, int param1, int param2, int param3){
	assembly->tailleEffective++;
  assembly->asmo[assembly->tailleEffective]->id = id;
  if(param1 != -1)
    assembly->asmo[assembly->tailleEffective]->param[0] = param1;
  if(param2 != -1)
    assembly->asmo[assembly->tailleEffective]->param[1] = param2;
  if(param3 != -1)
    assembly->asmo[assembly->tailleEffective]->param[2] = param3;
}
