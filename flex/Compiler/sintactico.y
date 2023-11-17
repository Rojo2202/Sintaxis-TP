%{
#include <stdio.h>
#include <stdlib.h> //se usa con %?
#include <string.h>
#include "sintactico.tab.h"
extern int yylex(void);
extern FILE* yyin;
void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
int yywrap(){
    return(1);
}

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
        int esRepetido = 0;

        for (size_t indiceAnterior = 0; indiceAnterior < indiceDestino; ++indiceAnterior) {
            if (cadena[indiceActual] == cadena[indiceAnterior]) {
                esRepetido = 1;
                break;
            }
        }

        if (esRepetido == 0) {
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
    char* resultado = malloc(longitudA + 1 + longitudB); // 1 para la coma
    strcpy(resultado, copiaA);
    strcat(resultado, ",");
    eliminarCaracterEnPosicion(copiaB,0);
    strcat(resultado, copiaB);

    free(copiaA);
    free(copiaB);

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

    free(copiaA);
    free(copiaB);
    
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
        if (encontrado == 0) {
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
    char* nueva_cadena = malloc(longitudA - longitudInterseccion);
    int estaEnInterseccion = 1;

    for(int i=0; i<longitudA;i++){
        estaEnInterseccion = 0;
        for(int j=0; j<longitudInterseccion; j++){
            if(copiaA[i] == copiaInterseccion[j]){
                estaEnInterseccion = 1;
                if(copiaA[i] == ','){
                    break;
                }
            }
        }
        if(estaEnInterseccion == 0){
            nueva_cadena[largodiferencia++] = copiaA[i];
            //std::cout << "Se agrego el caracter: " << copiaA[i] << std::endl;
        }
    }
    nueva_cadena[largodiferencia] = '\0';
    eliminarRepetidos(nueva_cadena);
    agregarSeparador(nueva_cadena);

    free(copiaA);
    free(copiaInterseccion);
    
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
%token TKN_MOSTRAR 


%type <var> TKN_ELEM
%type <cnj> TKN_CNJ
%union{
    char* var;
    char* cnj;
}


%left TKN_UNION 
%left TKN_COMPLEMENT 
%left TKN_INTERSECTION 

%start programa


%%

programa:   sentCompuesta {printf("Encontrado programa");}
;

sentCompuesta: TKN_SET TKN_ELEM TKN_ASGN expresion sentCompuesta {printf("encontrado set"); guardarID($2);}
            |  TKN_MOSTRAR TKN_ELEM {printf("encontrado mostrar"); printf("Encontrado TKN_UNION: %s \n",encontrarCadena($2));}
; 

expresion: TKN_CNJ TKN_UNION TKN_CNJ  {printf("Encontrado TKN_UNION"); char* a=encontrarCadena($1); char* b=encontrarCadena($3); guardarCadena(unionConjunto(a,b));}
           |TKN_CNJ TKN_COMPLEMENT TKN_CNJ {printf("Encontrado TKN_COMPLEMENT"); char* a=encontrarCadena($1); char* b=encontrarCadena($3);guardarCadena(diferencia(a,b));}
           |TKN_CNJ TKN_INTERSECTION TKN_CNJ  {printf("Encontrado TKN_INTERSECTION"); char* a=encontrarCadena($1); char* b=encontrarCadena($3);guardarCadena(interseccion(a,b));}
           |TKN_CNJ {printf("Encontrado TKN_CNJ"); guardarCadena($1); }
;

%%

int main(int arg,char **argv){

    if (arg>1)
    {
        yyin=fopen(argv[1],"rt");
        printf("Entro al primer arg");
    }
    else
        yyin=stdin;
        
    yyparse();
    fclose(yyin);
 
    return 0;
}


//gcc lex.yy.c sintactico.tab.c -o programa.exe -lfl
//gcc lex.yy.c -o scanner.exe -lfl  es para compilar el de flex
//bison -d sintactico.y
//flex lexico_flex.l

//gcc lex.yy.c -o scanner.exe -lfl -lm    es para compilar el de flex
//flex lexico_flex.l