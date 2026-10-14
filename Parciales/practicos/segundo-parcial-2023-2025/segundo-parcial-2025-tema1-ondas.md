# Tema 1 — 2° Examen Parcial – Programación Funcional (14/06/2025)

> Transcripción de examen manuscrito. Se omiten los datos personales del alumno.

## Importante: se descontarán puntos por
- No utilización de variables locales cuando sea necesario.
- IF anidados con COND o viceversa.
- Falta de validación en los casos que sea necesario.
- Falta de mensajes alusivos en el ingreso de datos.
- Uso excesivo o innecesario de variables auxiliares.

## Puntaje

| Ejercicio | Ptos |
|---|---|
| a | 2 |
| b | 1,5 |
| c | 0.5 |
| d | 2 |
| e | 2 |
| f | 2 |

Si consideramos que las ondas de un electro se pueden escribir como una lista formada por sublistas donde cada sublista tendrá 3 elementos:
- El primer elemento es un átomo numérico siendo:
  - 1 si la onda es superior al eje,
  - -1 si es inferior al eje y
  - 0 si es sobre el eje.
- El segundo elemento corresponde a la intensidad del eje, este dato está representado por un número real.
- Y el tercer y último átomo de la sublista representa al tipo de onda siendo:
  - A si es onda Alfa
  - B si es onda Beta

**a)** Desarrollar una función predicado, la que a partir de la lista que será ingresada por el operador, determine si todos los elementos son sublistas de 3 elementos.

**b)** Desarrollar una función, la que a partir de la lista que será ingresada como parámetro, determine la cantidad de ondas Alfa por encima del eje.

**c)** Desarrollar una función utilizando MAPCAR, la cual a partir de la lista ingresada como parámetro, devuelva una lista formada solamente por las intensidades de los ejes.

**d)** Definir una función utilizando un proceso recursivo, el cual a partir de la lista ingresada como parámetro, devuelva una nueva lista formada solamente por las sublistas cuya onda sea Alfa.

**e)** Desarrollar una función utilizando MAPCAR, la que a partir de la lista resultante del punto d) devuelva una nueva lista formada solamente por los resultados de las siguientes evaluaciones:
- Si la onda es inferior, devolver el mensaje "0000"
- Si la onda es superior, devolver el mensaje "0011"
- En cualquier otro caso, devolver el mensaje "1001"

**f)** Definir una función utilizando MAPCAR, la que a partir de la lista que será ingresada como parámetro devuelva una nueva lista formada por sublistas. En cada sublista se deberá reemplazar el valor del primer elemento por su descripción, recordando que:
- 1 -> reemplazar por "superior"
- -1 -> reemplazar por "inferior"
- 0 -> reemplazar por "sobre"
