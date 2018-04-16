#include <stdlib.h>
#include <stdio.h>

#define MAXSIZE 100
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

Pile* pile;

int peek(){
  if(pile == NULL){
    perror("peek");
    exit(EXIT_FAILURE);
  }
  return pile->premier->adr;
}

int find(char* id){
  if(pile == NULL){
    perror("find");
    exit(EXIT_FAILURE);
  }
	Element* current = pile->premier;
	while(current != NULL){
		if(current->id == id){
			return current->adr;
		}
		else{
			current = current->suivant;
		}
	}
	printf("Id not found\n");
	exit(EXIT_FAILURE);
	return 0;
}

int empiler(char* type, char* id, int depth){

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
  return element->adr;
}

void depiler(){

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

void afficherPile()
{
    if (pile == NULL)
    {
   			perror("afficherPile");
        exit(EXIT_FAILURE);
    }
    Element *actuel = pile->premier;

    while (actuel != NULL)
    {
        printf("Variable : id=%s, type=%s, adr=%d, depth=%d\n", 
					actuel->id,actuel->type,actuel->adr,actuel->depth);
        actuel = actuel->suivant;
    }
}
