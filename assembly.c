#include <stdlib.h>
#include <stdio.h>

int line = 0;

void addAssemblyLine(char* string, int nb){
	printf(sprintf("%s",string),nb);
	++line;
}
