#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define TAM 50

// Funcion que llena un areglo entero de 50 posiciones
void llena(int * arreglo){
    srand(time(NULL));
    for(int i=0; i<TAM; i++){
        arreglo[i] = 1 + rand()%((100+1)-1);
    }
}

// Funcion que ordena un arreglo de 50 posiciones
void ordena(int * arreglo){
    int aux;

	for(int i=0;i<TAM;i++){
		for(int j=0;j<TAM;j++){
			if(arreglo[j] > arreglo[j+1]){
				aux = arreglo[j];
				arreglo[j] = arreglo[j+1];
				arreglo[j+1] = aux;
			}
		}
	}
}

// Funcion que imprime un arreglo de 50 posiciones
void imprime(int * arreglo){
    for(int i=0; i<TAM; i++){
        printf("[%d]. %d\n", i+1, arreglo[i]);
    }
}

int main(int argc, char const *argv[]){
    int arreglo[TAM];

    llena(arreglo);
    ordena(arreglo);
    imprime(arreglo);

    return 0;
}
