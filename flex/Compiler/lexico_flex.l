%{
#include <stdio.h>
#include <stdlib.h>
int nlines=0;
%}




TKN_ASGN = “:”
TKN_ELEM = [a-zA-Z0-9]
TKN_CNJ = “(“([a-zA-Z0-9])(“,”+[a-zA-Z0-9])*“)” 
TKN_SEP = "," 
TKN_UNION = “+”
TKN_COMPLEMENT = “-”
TKN_INTERSECTION = “*”
TKN_PAA = “(“
TKN_PAC = “)“
TKN_CAA = “[“
TKN_CAC = “]”
TKN_SET = set
TKN_MOSTRAR = mostrar


%%


[a-zA-Z0-9] {printf("Encontrado TKN_ELEM: %s \n",yytext);}
"“(“+([a-zA-Z0-9]) + (“,”+[a-zA-Z0-9])*+“)”" {printf("Encontrado TKN_CNJ: %s",yytext);} 

":" {printf("Encontrado TKN_ASGN: %s \n",yytext);}
"*"     {printf("Encontrado TKN_INTERSECTION: %s\n",yytext);}
"+"     {printf("Encontrado TKN_UNION: %s \n",yytext);}
"-"     {printf("Encontrado TKN_COMPLEMENT: %s \n",yytext);}
"("     {printf("Encontrado TKN_PAA: %s \n",yytext);}
")"     {printf("Encontrado TKN_PAC: %s \n",yytext);}
"["     {printf("Encontrado TKN_CAA: %s \n",yytext);}
"]"     {printf("Encontrado TKN_CAC: %s \n",yytext);}
","     {printf("Encontrado SEPARADOR: %s \n",yytext);}
set     {printf("Palabra reservada set \n");}
mostrar {printf("Palabra reservada mostrar \n");}
" "     {}
 

"\n"    {nlines++;}
.       {printf("Caracter erroneo: %s \n",yytext);}

%%


void main(int argc,char **argv)
{ 
    if (argc>1)
        yyin=fopen(argv[1],"rt");
    else
        yyin=stdin;
    yylex();
    printf("\nNumero lineas analizadas: %d\n", nlines);
}

/* para compilar
flex tp.l
cc lex.yy.c -o milex -lfl -lm
//
scanner.exe < ejemplo.txt
*/


