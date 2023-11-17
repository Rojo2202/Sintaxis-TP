@echo off
"C:\Program Files (x86)\GnuWin32\bin\flex" tp.l
pause
echo "FLEX Compilo La especificacion lexica del archivo  tp.l (Se creo un archivo lex.yy.c)"
pause
c:\MinGW\bin\gcc.exe lex.yy.c -o scanner.exe -lfl
echo "Finalizo la ejecucion del compilador de C sobre el archivo lex.yy.C (Se creo un archivo Compilado.exe)"
pause

scanner.exe ejemplo.txt 
echo "Se ejecuto el analizador lexico sobre el archivo ejemplo.txt"
del lex.yy.c
del scanner.exel
