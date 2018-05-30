#define REGSIZE 16
#define MEMSIZE 20
int registers[REGSIZE];
int memory[MEMSIZE];

void interpreter(Assembly * instructions){
	Inst *	instruction;
	for(int i=0;i<instructions->tailleEffective;i++){
		instruction = instructions->asmo[i];
		if (instruction->id == ADD){
			registers[instruction->param[0]] = registers[instruction->param[1]] 
			+ registers[instruction->param[2]];
			printf("HEYYY\n");
		}
		if (instruction->id == MUL){
			registers[instruction->param[0]] = registers[instruction->param[1]] 
			* registers[instruction->param[2]];
		}
		if (instruction->id == SOU){
			registers[instruction->param[0]] = registers[instruction->param[1]] 
			- registers[instruction->param[2]];
		}
		if (instruction->id == DIV){
			registers[instruction->param[0]] = registers[instruction->param[1]] 
			/ registers[instruction->param[2]];
		}
		if (instruction->id == COP){
			registers[instruction->param[0]] = registers[instruction->param[1]];
		}
		if (instruction->id == AFC){
			registers[instruction->param[0]] = instruction->param[1];
		}
		if (instruction->id == LOAD){
			registers[instruction->param[0]] = memory[instruction->param[1]];
		}
		if (instruction->id == STORE){
			memory[instruction->param[0]] = registers[instruction->param[1]];
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

void display_memory(int limit){
	printf("Addr|   value   |\n");
	printf("--------------\n");
	for(int i = 0;i<limit;++i){
		printf("%3d |%11d |\n",i,memory[i]);
		printf("-------------------\n");
	}
}
