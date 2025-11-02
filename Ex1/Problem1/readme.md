## Descripción del programa

Este programa implementa la función `Dist(n)`, la cual calcula la cantidad de aplicaciones consecutivas necesarias de una función \( f \) para transformar un número entero positivo \( n \) en 1.  
La función se define recursivamente de la siguiente manera:

- Si \( n = 1 \), retorna 0.  
- Si \( n \) es par, aplica \( f(n) = n / 2 \).  
- Si \( n \) es impar, aplica \( f(n) = 3n + 1 \).  

El valor retornado corresponde al número de pasos requeridos para alcanzar el 1.  

## Instrucciones de ejecución

1. Instala el intérprete de Lua desde los repositorios oficiales de Ubuntu.
```bash
sudo apt install lua5.4
```
2. Ejecuta el programa con el intérprete de Lua, por ejemplo:
```bash
lua Problem1.lua
```
