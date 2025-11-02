## Descripción del programa

Este programa implementa un analizador de expresiones aritméticas en notación prefija (PRE) y postfija (POST). Permite tanto evaluar el resultado de una expresión como reconstruir su forma infija, considerando las reglas de precedencia de operadores y el uso apropiado de paréntesis.  
El programa utiliza funciones recursivas para el análisis en modo prefijo y una pila para el modo postfijo, junto con una tabla de precedencias para determinar cuándo añadir paréntesis en la representación infija.  
Está diseñado para procesar expresiones simples que contienen los operadores básicos `+`, `-`, `*` y `/`.

El programa incluye un conjunto de pruebas automatizadas y un sistema de medición de cobertura desarrollado con las herramientas busted y luacov. Se emplea un archivo Makefile con las reglas all para ejecutar las pruebas y generar los reportes de cobertura, y clean para eliminar los archivos temporales generados por luacov.

## Instrucciones de ejecución

1. Instala el intérprete de Lua desde los repositorios oficiales de Ubuntu.
```bash
sudo apt install lua5.4
```
2. Ejecuta el programa con el intérprete de Lua, por ejemplo:
```bash
sudo apt install lua5.4
```
3. Para ejecutar las pruebas, instale las dependencias necesarias:
```bash
sudo apt install luarocks
sudo luarocks install busted
sudo luarocks install luacov
```
Y ejecute el archivo makefile. 
```bash
make all
make clean
```
Tome en cuenta que en archivo parser.lua se debe comentar el código del menú para que las pruebas se ejecuten normalmente. Para tener la experiencia de usuario con la que fue diseñada el parser, descomente la función Menu() y ejecute el archivo usando el comando:
```bash
lua parser.lua
```
