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
  printf("## ASSEMBLY ##\n");
  for(int i=0;i<assembly->tailleEffective;i++){
    printf("%2d %5s %d %d",i,(assembly->asmo[i])->id,(assembly->asmo[i])->param[0],(assembly->asmo[i])->param[1]);
    if((assembly->asmo[i])->param[2]==-1){
      printf("\n");
    }else {
      printf(" %d\n",(assembly->asmo[i])->param[2]);
    }
  }
}

void add_instruction(Assembly* assembly, char* id, int param1, int param2, int param3){
  int place = assembly->tailleEffective;
  Inst *inst = malloc(sizeof(*inst));
  inst->id = id;
  inst->param[0] = param1;
  inst->param[1] = param2;
  inst->param[2] = param3;
  assembly->asmo[place] = inst;
  assembly->tailleEffective = place + 1;
}
