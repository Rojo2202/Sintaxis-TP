%{
#include <stdio.h>
#include <stdlib.h>
#include "sintactico.tab.h"
int nlines=0;
%}


/*
TKN_ASGN = “:”
TKN_ELEM = [a-zA-Z0-9]
TKN_CNJ = “(“+([a-zA-Z0-9])+(“,”+[a-zA-Z0-9])*+“)”      //se usa + para concatenar parentesis y caracteres (creo q es para clausura positiva)?
TKN_SEP = "," 
TKN_UNION = “+”
TKN_COMPLEMENT = “-”
TKN_INTERSECTION = “*”
TKN_PAA = “(“
TKN_PAC = “)“
TKN_CAA = “[“
TKN_CAC = “]”
TKN_DEF = elem
TKN_SET = set
*/  

%%


[a-zA-Z0-9] {return(TKN_ELEM);}
"“(“+([a-zA-Z0-9]) + (“,”+[a-zA-Z0-9])*+“)”" {return(TKN_CNJ);}
":"     {return(TKN_ASGN);}
"*"     {return(TKN_INTERSECTION);}
"+"     {return(TKN_UNION);}
"-"     {return(TKN_COMPLEMENT);}
"("     {return(TKN_PAA);}
")"     {return(TKN_PAC);}
"["     {return(TKN_CAA);}
"]"     {return(TKN_CAC);}
","     {return(TKN_SEP);}
set     {return(TKN_SET);}
//elem   {return(TKN_DEF);}
" "     {}
"\n"    {nlines++;}
[ \t]       {/* No hacer nada en caso de espacios y tabulaciones */}

.       {printf("Caracter erroneo: %s \n",yytext);}

%%

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