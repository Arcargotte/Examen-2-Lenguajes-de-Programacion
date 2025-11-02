## Descripción del programa

Este programa implementa varias funciones matemáticas en C, incluyendo el factorial, el coeficiente binomial, los números de Narayana y la sucesión de Tribonacci.  
A partir de estas funciones, define la función `maldad(n)`.  
El programa fue compilado con **gcc** y ejecutado en **PowerShell**, donde se midieron los tiempos de ejecución mediante el comando `Measure-Command { ./a.exe }`.  

## Instrucciones de ejecución

1. Compile el programa con **gcc**:  
```bash
gcc main.c
```
2. Ejecútelo en **PowerShell** y mida el tiempo de ejecución con:  
```powershell
Measure-Command { ./a.exe }
```
3. Si se desea ejecutar el programa con interacción de usuario (modo original), descomente el bloque `main` y elimine el bucle `for` al final del archivo.  
