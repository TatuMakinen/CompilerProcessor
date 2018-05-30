#define REGSIZE 16
int registers[REGSIZE];

void interpreter(Assembly * instructions){
	Inst *	instruction;
	for(int i=0;i<instructions->tailleEffective;i++){
		instruction = instructions->asmo[i];
		if (instruction == ADD){
			registers[instruction->param[0]] = registers[instruction->param[1]] 
			+ registers[instruction->param[2]];
		}
	}
}

void display_registers(){
	printf("| Reg|   value    |\n");
	printf("-------------------\n");
	for(int i=0;i<REGSIZE;++i){
		printf("|%3d |%11d |\n",i,registers[i]);
		printf("-------------------\n");
	}
}
