#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"	
int yylex();


%token TKN_ASGN //“:”
%token TKN_ELEM //[a-zA-Z0-9]
%token TKN_CNJ // “(“([a-zA-Z0-9])(“,”+[a-zA-Z0-9])*“)”         //se usa +?
%token TKN_SEP // "," 
%token TKN_UNION //“+”
%token TKN_COMPLEMENT //“-”
%token TKN_INTERSECTION // “*”
%token TKN_PAA //“(“
%token TKN_PAC //“)“
%token TKN_CAA //“[“
%token TKN_CAC //“]”
%token TKN_SET //set

%%
programa:
            |programa sentCompuesta
;

sentCompuesta: TKN_SET TKN_ELEM TKN_ASGN Expresion 
;

Expresion: Expresion TKN_UNION Expresion  {char*=$1; char*=$3; $$=union($1,$3);}    //CUIDADO QUE $1 Y $3 SON CARACTERES/ID QUE REPRESENTAN SETS!!!! =>ENCONTRAR FORMA PARA OBTENER LA CADENA QUE REPRESENTA EL ID
           |Expresion TKN_COMPLEMENT Expresion {$$=diferencia($1,$3);}
           |Expresion TKN_INTERSECTION Expresion  {$$=interseccion($1,$3);}
           |TKN_CNJ
;



// ***** FUNCION PARA LA UNION *****

char* union (char* A , char* B)
{ 
    eliminarCaracterEnPosicion(A,strlen(A));
    strcat(A, ",");
    eliminarCaracterEnPosicion(B,0);
    return strcat(A, B);
}

// ***** FUNCION PARA LA INTERSECCION ***** 

char* interseccion(char* cadena1,char* cadena2) {   //a*b
    eliminarCaracterEnPosicion(cadena1,strlen(cadena1));
    eliminarCaracterEnPosicion(cadena2,0);

    int longitud1 = strlen(cadena1);
    int longitud2 = strlen(cadena2);
    int contador = 0;

    char* nueva_cadena;

    for (int i = 0; i < longitud1; i++) {
        for (int j = 0; j < longitud2; j++) {
            if (cadena1[i] == cadena2[j] && cadena1[i] != ',' ) {

                nueva_cadena[contador++] = cadena1[i];
                break;  
            }
        }
    }
    eliminarRepetidos(nueva_cadena);
    agregarSeparador(nueva_cadena);
    nueva_cadena[contador] = '\0';  // Establece el último carácter como nulo
    return nueva_cadena;
}

// ***** FUNCION PARA LA DIFERENCIA ***** 
char* diferencia (char* A , char* B)  //A-B
{
 char dif[]= interseccion(A,B)
 int longitudDif = strlen(dif);
 int longitudA = strlen(A);
 
 char* C;
 
 for (int i = 0; i < longitudDif; i++) {
        for (int j = 0; j < longitudA; j++) {
            if (dif[i] != A[j] && A[j] != ',' ) {

                C[contador++] = A[j];
                break;  
            }
        }
    }
 eliminarRepetidos(C);
 agregarSeparador(C);
 C[contador] = '\0';  // Establece el último carácter como nulo
 return C;
}



// **** ADICIONALES ****
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

void eliminarRepetidos(char* array) { 
    int i, j, k;
    int tamanio = array.lenght
    // Recorrer el array
    for (i = 0; i < tamanio; ++i) {
        // Verificar si el elemento actual no está duplicado
        for (j = i + 1; j < tamanio;) {
            if (array[i] == array[j]) {
                // Eliminar el duplicado desplazando elementos hacia la izquierda
                for (k = j; k < tamanio - 1; ++k) {
                    array[k] = array[k + 1];
                }
                --tamanio; // Decrementar el tamaño del array
            } else {
                ++j;
            }
        }
    }
}

void agregarSeparador (char* cadena){

    char* nuevaCadena[100];
    int longitud = strlen(cadena);

    int j = 1;
    nuevaCadena[0] = '(';
    for (int i = 0; i < longitud; i++){
     
    nuevaCadena[j++] = cadena[i];

        if (i < longitud - 1) {
            nuevaCadena[j++] = ',';
        }
    }

    nuevaCadena[j++] = ')';
    nuevaCadena[j] = '\0';
   
//    return nuevaCadena;
}