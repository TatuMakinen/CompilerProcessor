#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#define MAXQUEUE 10
#define MAXTABLE 100

int intArray[MAXQUEUE];
int frontQueue = 0;

bool isFull() {
   return frontQueue >= MAXQUEUE;
}

bool isEmpty() {
	return frontQueue == 0;
}

void insertQueue(int data) {

	if(!isFull()) {
		intArray[++frontQueue] = data;
	}
	else{
		printf("Queue is full\n");
	}
}

int removeQueue() {
	if(!isEmpty()) {
		int data = intArray[frontQueue--];	
   	return data;
	}
	printf("Queue is empty\n");
	return 0;
}

typedef struct Instruction Instruction;
struct Instruction
{
	int if_adr;
	int dest_adr;
};

Instruction* jumpTable[MAXTABLE];
int frontTable = 0;

void addInstruction(int currentLine){
	if(frontTable<=MAXTABLE){
		Instruction *data = malloc(sizeof(*data));
		data->if_adr = removeQueue(); // get the if adr from LIFO queue - last if that was encountered
		data->dest_adr = currentLine; 
		jumpTable[frontTable++] = data;
	}
	else{
		printf("Table is full.\n");
	}
}

void displayTable()
{
    for(int i=0;i<frontTable;++i)
    {
        printf("Instruction JMF: %d destination: %d\n", jumpTable[i]->if_adr, jumpTable[i]->dest_adr);
    }
}
/* Test structure
int main(){
	insertQueue(1);
	insertQueue(2);
	insertQueue(3);
	insertQueue(4);
	addInstruction(11);
	addInstruction(12);
	insertQueue(5);
	addInstruction(13);
	addInstruction(14);
	addInstruction(15);
	displayTable();

}
*/
