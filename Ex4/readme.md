## Descripción del programa

Este programa implementa tres versiones de la función `F53(n)`: una recursiva, una con recursión de cola y una iterativa.  
Cada versión calcula el valor de una secuencia definida por una relación de recurrencia dependiente de los parámetros `Alpha` y `Beta`, derivados de las constantes `X`, `Y` y `Z`.  
El programa mide el tiempo de ejecución de cada versión utilizando la biblioteca `socket` y genera un archivo `resultados.csv` con los tiempos obtenidos para valores de `n` entre 0 y 90.  

## Instrucciones de ejecución

1. Instale el intérprete de Lua y la biblioteca de sockets de Lua.  
```bash
sudo apt install lua5.4 lua-socket
```
2. Ejecute el programa con el intérprete de Lua, por ejemplo:  
```bash
lua Problem4.lua
```
3. Una vez finalizada la ejecución, se generará el archivo `resultados.csv` con los resultados de rendimiento.
