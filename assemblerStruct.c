#include <string.h>

enum assembly_cmds {ADD,SUB,MUL,DIV,STORE,LOAD,AFC};

#define ASMSIZE 1000

typedef struct Inst Inst;
struct Inst{
  int id;
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

void print_instruction(Inst* inst){
  switch(inst->id) {
    case ADD :
      printf("ADD r%d r%d r%d\n",inst->param[0],inst->param[1],inst->param[2]);
      break;
    case SUB :
      printf("SUB r%d r%d r%d\n",inst->param[0],inst->param[1],inst->param[2]);
      break;
    case MUL :
      printf("MUL r%d r%d r%d\n",inst->param[0],inst->param[1],inst->param[2]);
      break;
    case DIV :
      printf("DIV r%d r%d r%d\n",inst->param[0],inst->param[1],inst->param[2]);
      break;
    case STORE :
      printf("STR @%d r%d\n",inst->param[0],inst->param[1]);
      break;
    case LOAD :
      printf("LDR r%d @%d\n",inst->param[0],inst->param[1]);
      break;
    case AFC :
      printf("AFC r%d '%d'\n",inst->param[0],inst->param[1]);
      break;
    default :
      printf("error\n");
  }
}	

void display_struct(Assembly* assembly){
  printf("## ASSEMBLY ##\n");
  for(int i=0;i<assembly->tailleEffective;i++){
    printf("%2d ",i);
    print_instruction(assembly->asmo[i]);
  }
}

void add_instruction(Assembly* assembly,int id, int param1, int param2, int param3){
  int place = assembly->tailleEffective;
  Inst *inst = malloc(sizeof(*inst));
  inst->id = id;
  inst->param[0] = param1;
  inst->param[1] = param2;
  inst->param[2] = param3;
  assembly->asmo[place] = inst;
  assembly->tailleEffective = place + 1;
}
