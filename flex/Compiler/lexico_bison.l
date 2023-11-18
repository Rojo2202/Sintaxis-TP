%{
#include <stdio.h>
#include <stdlib.h>
#include "sintactico.tab.h"
int nlines=0;
%}


TKN_ASGN [:]
TKN_ELEM [a-zA-Z0-9] 
TKN_SEP [,]
TKN_PAA [(]
TKN_PAC [)]
TKN_UNION [+]
TKN_DIFERENCIA [-]
TKN_INTERSECTION [*]
TKN_SET [set]
TKN_MOSTRAR [mostrar]
TKN_CNJ {TKN_PAA}{TKN_ELEM}({TKN_SEP}{TKN_ELEM})*{TKN_PAC}

%%


{TKN_ELEM} {yylval.cadena = strdup(yytext);return TKN_ELEM;}
{TKN_CNJ}  {yylval.cadena = strdup(yytext);return TKN_CNJ;}
":"        {return TKN_ASGN;}
"*"        {return TKN_INTERSECTION;}
"+"        {return TKN_UNION;}
"-"        {return TKN_DIFERENCIA;}
"("        {}
")"        {}
","        {}
set        {return TKN_SET;}
mostrar    {return TKN_MOSTRAR;}
" "        {}
"\n"       {nlines++;}
[ \t]       {/* No hacer nada en caso de espacios y tabulaciones */}

.       {printf("Caracter erroneo: %s \n",yytext);}

%%

/*

{TKN_ELEM} {printf("Encontrado TKN_ELEM: %s\n",yytext);}
{TKN_CNJ} {printf("Encontrado TKN_CNJ: %s\n",yytext);} 

":"     {printf("Encontrado TKN_ASGN: %s \n",yytext);}
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

*/





/*
void main(int argc,char **argv)
{
if (argc>1)
yyin=fopen(argv[1],"rt");
else
yyin=stdin;
yylex();
printf("\nNumero lineas analizadas: %d\n", nlines);
}


void main() {
    yyparse();  // Llama al parser generado por Bison
}
*/