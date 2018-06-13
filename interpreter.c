#define REGSIZE 16
#define MEMSIZE 20
int registers[REGSIZE];
int memory[MEMSIZE];

void interpreter(Assembly * instructions){
	Inst *	instruction;
	int i = 0;
	while(i < instructions->tailleEffective){
		instruction = instructions->asmo[i];
		if (instruction->id == ADD){
			registers[instruction->param[0]] = registers[instruction->param[1]]
			+ registers[instruction->param[2]];
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
		if (instruction->id == EQU){
			registers[instruction->param[0]] = (registers[instruction->param[1]] ==
				registers[instruction->param[2]]) ? 1 : 0;
		}
		if (instruction->id == INF){
			registers[instruction->param[0]] = (registers[instruction->param[1]] <
				registers[instruction->param[2]]) ? 1 : 0;
		}
		if (instruction->id == INFE){
			registers[instruction->param[0]] = (registers[instruction->param[1]] <=
				registers[instruction->param[2]]) ? 1 : 0;
		}
		if (instruction->id == SUP){
			registers[instruction->param[0]] = (registers[instruction->param[1]] >
				registers[instruction->param[2]]) ? 1 : 0;
		}
		if (instruction->id == SUPE){
			registers[instruction->param[0]] = (registers[instruction->param[1]] >=
				registers[instruction->param[2]]) ? 1 : 0;
		}
		++i;
		if (instruction->id == JMP){
			i = instruction->param[0];
		}
		if (instruction->id == JMPC){
			if(registers[instruction->param[1]] == 0){
				i = instruction->param[0];
			}
		}

	}
}

void display_registers(){
	printf("-------------\n");
	printf(" Reg| value \n");
	printf("-------------\n");
	for(int i=0;i<REGSIZE;++i){
		printf("%3d |%5d\n",i,registers[i]);
	}
}

void display_memory(int limit){
	printf("-------------\n");
	printf("Addr|value \n");
	printf("-------------\n");
	for(int i = 0;i<limit;++i){
		printf("%3d |%5d \n",i,memory[i]);
	}
}
