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

typedef struct Jump Jump;
struct Jump
{
	int if_adr;
	int dest_adr;
};


Jump* add_jump(int currentLine){
	Jump *data = malloc(sizeof(*data));
	data->if_adr = removeQueue(); // get the if adr from LIFO queue - last if that was encountered
	data->dest_adr = currentLine;
	return data;
}
