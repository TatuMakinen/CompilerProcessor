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

void insertQueue(int currentline) {
	if(!isFull()) {
		intArray[++frontQueue] = currentline-1;
	}
	else{
		printf("Queue is full\n");
	}
}

int removeQueue() {
	if(!isEmpty()) {
		int destination = intArray[frontQueue--];	
   	return destination;
	}
	printf("Queue is empty\n");
	return 0;
}
