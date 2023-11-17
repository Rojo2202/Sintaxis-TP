%{
#include <stdio.h>
#include <stdlib.h> //se usa con %?
#include <string.h>
#include "parser.tab.h"	
int yylex();



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

char* encontrarCadena(char* id) {

    for (int columna = 0; columna < 29; columna++) {
        if (guardadas[0][columna] == id) {
            return guardadas[1][columna];
        }
    }
}
void eliminarCaracterEnPosicion(char* cadena, int posicion) {
    int len = strlen(cadena);

    if (posicion >= 0 && posicion < len) {
        // Mover los caracteres a la izquierda para sobrescribir el carácter en la posición especificada
        for (int i = posicion; i < len - 1; i++) {
            cadena[i] = cadena[i + 1];
        }

        // Establecer el último carácter como nulo
        cadena[len - 1] = '\0';
    }
}


void eliminarRepetidos(char* cadena) {
    size_t longitud = strlen(cadena);

    if (longitud <= 1) {
        // No hay repetidos en cadenas de longitud 0 o 1
        return;
    }

    size_t indiceDestino = 1;

    for (size_t indiceActual = 1; indiceActual < longitud; ++indiceActual) {
        bool esRepetido = false;

        for (size_t indiceAnterior = 0; indiceAnterior < indiceDestino; ++indiceAnterior) {
            if (cadena[indiceActual] == cadena[indiceAnterior]) {
                esRepetido = true;
                break;
            }
        }

        if (!esRepetido) {
            cadena[indiceDestino] = cadena[indiceActual];
            ++indiceDestino;
        }
    }

    // Establecer el nuevo final de la cadena
    cadena[indiceDestino] = '\0';
}




void agregarSeparador(char* cadena) {
    char nuevaCadena[100];  // Cambiado de char* a char
    int longitud = strlen(cadena);

    int j = 1;
    nuevaCadena[0] = '(';
    for (int i = 0; i < longitud; i++) {
        nuevaCadena[j++] = cadena[i];

        if (i < longitud - 1) {
            nuevaCadena[j++] = ',';
        }
    }

    nuevaCadena[j++] = ')';
    nuevaCadena[j] = '\0';

    strcpy(cadena, nuevaCadena);
}



char* unionConjunto (char* A, char* B) {
    // Hacer copias temporales de A y B
    char* copiaA = strdup(A);
    char* copiaB = strdup(B);

    // Eliminar el último carácter de copiaA
    size_t longitudA = strlen(copiaA);
    eliminarCaracterEnPosicion(copiaA, longitudA - 1);

    // Concatenar la coma y copiaB al final de copiaA
    size_t longitudB = strlen(copiaB);
    char* resultado = new char[longitudA + 1 + longitudB]; // 1 para la coma
    strcpy(resultado, copiaA);
    strcat(resultado, ",");
    eliminarCaracterEnPosicion(copiaB,0);
    strcat(resultado, copiaB);

    // Liberar memoria de las copias temporales
    delete[] copiaA;
    delete[] copiaB;

    return resultado;
}



// ***** FUNCION PARA LA INTERSECCION *****

char* interseccion(char* A,char* B) {
    char* copiaA = strdup(A);
    char* copiaB = strdup(B);


    eliminarCaracterEnPosicion(copiaA,0);
    eliminarCaracterEnPosicion(copiaA,strlen(copiaA)-1);

    eliminarCaracterEnPosicion(copiaB,0);
    eliminarCaracterEnPosicion(copiaB,strlen(copiaB)-1);

    int longitud1 = strlen(copiaA);
    int longitud2 = strlen(copiaB);
    int contador = 0;

   // char* resultado = new char[longitudA + 1 + longitudB]; // 1 para la coma

    char* nueva_cadena;

    for (int i = 0; i < longitud1; i++) {
        for (int j = 0; j < longitud2; j++) {
            if (copiaA[i] == copiaB[j] && copiaA[i] != ',' ) {
                nueva_cadena[contador++] = copiaA[i];
                break;
            }
        }
    }
    eliminarRepetidos(nueva_cadena);
   agregarSeparador(nueva_cadena);

    delete[] copiaA;
    delete[] copiaB;

    return nueva_cadena;
}


void eliminar_caracteres(char cadena1[], const char cadena2[]) {
    int i, j, k;
    int longitud_cadena1 = strlen(cadena1);
    int longitud_cadena2 = strlen(cadena2);

    // Iterar a través de cada carácter en cadena1
    for (i = 0; i < longitud_cadena1; i++) {
        // Verificar si el carácter actual de cadena1 está en cadena2
        int encontrado = 0;
        for (j = 0; j < longitud_cadena2; j++) {
            if (cadena1[i] == cadena2[j]) {
                encontrado = 1;
                break;
            }
        }

        // Si el carácter no está en cadena2, conservarlo
        if (!encontrado) {
            cadena1[k++] = cadena1[i];
        }
    }

    // Establecer el nuevo final de la cadena1
    cadena1[k] = '\0';
}


// ***** FUNCION PARA LA DIFERENCIA *****
char* diferencia(char* A, char* B) {
    char* copiaInterseccion = strdup(interseccion(A,B));
    char* copiaA = strdup(A);//(a,b,c)

    eliminarCaracterEnPosicion(copiaA,0);
    eliminarCaracterEnPosicion(copiaA,strlen(copiaA)-1);

    eliminarCaracterEnPosicion(copiaInterseccion,0);
    eliminarCaracterEnPosicion(copiaInterseccion,strlen(copiaInterseccion)-1);

   // std::cout << "Conjunto A: " << copiaA << std::endl;

   // std::cout << "Interseccion: " << copiaInterseccion << std::endl;

    int largodiferencia = 0;
    int longitudA = strlen(copiaA);
    int longitudInterseccion = strlen(copiaInterseccion);
    char* nueva_cadena = new char [longitudA - longitudInterseccion];
    bool estaEnInterseccion;

    for(int i=0; i<longitudA;i++){
        estaEnInterseccion = false;
        for(int j=0; j<longitudInterseccion; j++){
            if(copiaA[i] == copiaInterseccion[j]){
                estaEnInterseccion = true;
                if(copiaA[i] == ','){
                    break;
                }
            }
        }
        if(!estaEnInterseccion){
            nueva_cadena[largodiferencia++] = copiaA[i];
            //std::cout << "Se agrego el caracter: " << copiaA[i] << std::endl;
        }
    }
    nueva_cadena[largodiferencia] = '\0';
    eliminarRepetidos(nueva_cadena);
    agregarSeparador(nueva_cadena);

    delete[] copiaInterseccion;
    delete[] copiaA;

    return nueva_cadena;
}

%}

%token TKN_ASGN 
%token TKN_ELEM 
%token TKN_CNJ 
%token TKN_SEP 
%token TKN_PAA 
%token TKN_PAC 
%token TKN_CAA 
%token TKN_CAC 
%token TKN_SET 
%left TKN_UNION 
%left TKN_COMPLEMENT 
%left TKN_INTERSECTION 
%start programa


%%
programa:           
            |sentCompuesta
;

sentCompuesta: TKN_SET TKN_ELEM TKN_ASGN Expresion sentCompuesta {guardarID($2);guardarCadena($4);}
;

Expresion: Expresion TKN_UNION Expresion  {char* a=encontrarCadena($1); char* b=encontrarCadena($3);char*=$3; $$=union(a,b);}
           |Expresion TKN_COMPLEMENT Expresion {char* a=encontrarCadena($1); char* b=encontrarCadena($3);char*=$3;$$=diferencia(a,b);}
           |Expresion TKN_INTERSECTION Expresion  {char* a=encontrarCadena($1); char* b=encontrarCadena($3);char*=$3;$$=interseccion(a,b);}
           |TKN_CNJ { printf("TKN_CNJ:" \s%\"\n",$1); }

;

%%

int main(int arg,char **argv){
    FILE* yyin;
    if (argc>1)
        yyin=fopen(argv[1],"rt");
    else
        yyin=stdin;
        
    yyparse();
    fclose(yyin);

    return 0;
}


/*
void main(int argc,char **argv)

if (argc>1)
yyin=fopen(argv[1],"rt");
else
yyin=stdin;

yylex();

printf("\nNumero lineas analizadas: %d\n", nlines);

*/


