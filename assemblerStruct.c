#include <string.h>

enum assembly_cmds {ADD,MUL,SOU,DIV,COP,AFC,LOAD,STORE,EQU,INF,INFE,SUP,SUPE,JMP,JMPC};

char* a_strings[15] = {"ADD","MUL","SOU","DIV","COP","AFC","LOAD","STORE","EQU","INF","INFE","SUP","SUPE","JMP","JMPC"};

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
      printf("%s r%d r%d r%d\n",a_strings[inst->id],inst->param[0],inst->param[1],inst->param[2]);
      break;
    case MUL :
      printf("%s r%d r%d r%d\n",a_strings[inst->id],inst->param[0],inst->param[1],inst->param[2]);
      break;
    case SOU :
      printf("%s r%d r%d r%d\n",a_strings[inst->id],inst->param[0],inst->param[1],inst->param[2]);
      break;
    case DIV :
      printf("%s r%d r%d r%d\n",a_strings[inst->id],inst->param[0],inst->param[1],inst->param[2]);
      break;
    case COP :
      printf("%s r%d r%d\n",a_strings[inst->id],inst->param[0],inst->param[1]);
      break;
    case AFC :
      printf("%s r%d '%d'\n",a_strings[inst->id],inst->param[0],inst->param[1]);
      break;
    case LOAD :
      printf("%s r%d @%d\n",a_strings[inst->id],inst->param[0],inst->param[1]);
      break;
    case STORE :
      printf("%s @%d r%d\n",a_strings[inst->id],inst->param[0],inst->param[1]);
      break;
    case EQU :
			printf("%s r%d r%d r%d\n",a_strings[inst->id],inst->param[0],inst->param[1],inst->param[2]);
      break;
    case INF :
			printf("%s r%d r%d r%d\n",a_strings[inst->id],inst->param[0],inst->param[1],inst->param[2]);
      break;
    case INFE :
			printf("%s r%d r%d r%d\n",a_strings[inst->id],inst->param[0],inst->param[1],inst->param[2]);
      break;
    case SUP :
			printf("%s r%d r%d r%d\n",a_strings[inst->id],inst->param[0],inst->param[1],inst->param[2]);
      break;
    case SUPE :
			printf("%s r%d r%d r%d\n",a_strings[inst->id],inst->param[0],inst->param[1],inst->param[2]);
      break;
    case JMP :
      printf("%s @%d\n",a_strings[inst->id],inst->param[0]);
      break;
    case JMPC :
      printf("%s @%d r%d\n",a_strings[inst->id],inst->param[0],inst->param[1]);
      break;
    default :
      printf("Instruction not known\n");
      exit(EXIT_FAILURE);
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

void add_jmp_destination(Assembly* assembly, int line, int destination){
  if(assembly->tailleEffective<line){
    perror("line out of range\n");
    exit(EXIT_FAILURE);
  }
  assembly->asmo[line]->param[0] = destination;
}
