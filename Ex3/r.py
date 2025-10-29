def n2s(n: int, b: int):
    if n <= 0: return '0'
    r = ''
    while n > 0:
        u = n % b
        if u >= 10:
            u = chr(ord('A') + u-10)
            n = n // b
            r = str(u) + r
    return r

print(n2s(144, 2))
#Convierte en ASCII el caracter A, suma u y le resta 10. Convierte el resultado en un caracter segun su codificacion ASCII y va agregando los caracteres en la cadena r