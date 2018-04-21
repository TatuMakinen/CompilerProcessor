#include <stdlib.h>
#include <stdio.h>
#include <string.h>

// Groupe 21
typedef struct Element Element;
struct Element
{
    int adr;
    char* type;
    char* id;
    int depth;
    Element *suivant;
};

typedef struct Pile Pile;
struct Pile
{
    Element *premier;
    int adr;
};

Pile* initPile(){
  Pile *pile = malloc(sizeof(*pile));
  pile->premier = NULL;
  pile->adr = 0;
	return pile;
}

int peek(Pile* pile){
  if(pile == NULL){
    perror("peek");
    exit(EXIT_FAILURE);
  }
  return pile->premier->adr;
}

int find(Pile* pile, char* id){
  if(pile == NULL){
    perror("find");
    exit(EXIT_FAILURE);
  }
	Element* current = pile->premier;
	while(current != NULL){
		if(strcmp(current->id,id)==0){
			return current->adr;
		}
		else{
			current = current->suivant;
		}
	}
	printf("\"%s\" is not declared.\n",id);
	exit(EXIT_FAILURE);
	return 0;
}

void empiler(Pile* pile, char* type, char* id, int depth){

  Element* element = malloc(sizeof(*element));
  if(pile == NULL | element ==NULL){
   	perror("empiler");
		exit(EXIT_FAILURE);
  }
  element->adr = pile->adr;
  pile->adr++;
  element->type = type;
  element->id = id;
  element->depth = depth;
  element->suivant = pile->premier;
  pile->premier = element;
}

void depiler(Pile* pile){

	if(pile == NULL){
   	perror("depiler");
		exit(EXIT_FAILURE);
	}
  Element* thingToDepile = pile->premier;

  if(pile != NULL && pile->premier != NULL){
    pile->premier = pile->premier->suivant;
    free(thingToDepile);
  }
}

void afficherPile(Pile* pile)
{
  if (pile == NULL)
  {
    perror("afficherPile");
    exit(EXIT_FAILURE);
  }
  Element *actuel = pile->premier;
  printf("## SYMBOL TABLE ##\n");
  printf("|    ID    | TYPE |    ADR   |DEPTH|\n");
  while (actuel != NULL){
    printf("| %8s | %4s | %8d | %2d  |\n", actuel->id,actuel->type,actuel->adr,actuel->depth);
    actuel = actuel->suivant;
  }
}
