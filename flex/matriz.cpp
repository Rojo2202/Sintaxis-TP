#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* guardadas [2][28];

void inicializarMatriz (){
        for (int fila = 0; fila < 2; fila++) {
            for (int columna = 0; columna < 29; columna++) {
                    guardadas [fila][columna]=0;
                }
            }
}

void guardarID (char* id) {

    for (int columna = 0; columna < 29; columna++) {
        if (guardadas[0][columna] == 0 ) {
            guardadas[0][columna] = id;
                    return;
        }
    }
}

void guardarCadena(char* cadena) {
    for(int columna = 0; columna < 29; columna ++) {
        if(guardadas[1][columna] == 0) {
            guardadas[1][columna] = cadena;
                    return;
        }
    }
}

char* encontrarCadena(char id) {

    for (int columna = 0; columna < 29; columna++) {
        if (guardadas[0][columna] == id) {
            return *guardadas[1][columna];
        }
    }
}






void main()
{
char* a =hola;
char* b =que;
char* c =tal;
char* d =(a,b,c,d);
guardarID(a);
guardarCadena(a);
guardarID(b);
guardarCadena(b);
guardarID(c);
guardarCadena(c);
guardarID(d);
guardarCadena(d);

printf("El valor a es %d  .\n", encontrarCadena(a));
printf("El valor b es %d  .\n", encontrarCadena(b));
printf("El valor c es %d  .\n", encontrarCadena(c));
printf("El valor d es %d  .\n", encontrarCadena(d));
}

//g++ pruebas.cpp -std=c++17 -o pruebas.exe
