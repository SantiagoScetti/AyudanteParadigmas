# Tema 4 — 2° Examen Parcial – Programación Funcional (14/06/2025)

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
| b | 2 |
| c | 0.5 |
| d | 1.5 |
| e | 2 |
| f | 2 |

Los resultados de una encuesta se guardan en una lista formada por sublistas, donde cada sublista posee dos elementos:
- El primer elemento es el número de la pregunta.
- El segundo elemento es la cantidad de respuestas satisfactorias.

Se tiene además un átomo que representa la cantidad de encuestados.

**a)** Desarrollar una función predicado, la que a partir de la lista y la cantidad de encuestados que serán ingresadas por el operador, determine si hay al menos una pregunta que haya sido respondida por todos los encuestados.

**b)** Desarrollar una función, la que a partir de la lista y la cantidad de encuestados que serán ingresadas como parámetros, determine la cantidad de respuestas satisfactorias que superan la mitad de la cantidad de encuestados.

**c)** Desarrollar una función que permita determinar la cantidad de preguntas que posee la encuesta.

**d)** Desarrollar una función utilizando MAPCAR, la que a partir de la lista y la cantidad de encuestados que serán ingresados como parámetros, devuelva una nueva lista formada por sublistas donde cada sublista estará formada por:
- El nro de la pregunta.
- El porcentaje de respuestas afirmativas, donde el porcentaje = (cant. de respuestas afirmativas * cantidad de encuestados) / 100.

**e)** Desarrollar una función utilizando un proceso recursivo, el que a partir de la lista y la cantidad de encuestados, ambos recibidos como parámetros, devuelva una nueva lista formada por todos los números de preguntas cuyas cantidades de respuestas positivas son mayores a la mitad de los encuestados.

**f)** Desarrollar una función utilizando la función MAPCAR, la que a partir de la lista y la cantidad de encuestados, ambos recibidos como parámetros, devuelva una nueva lista formada únicamente por los resultados de las siguientes evaluaciones:
- "muchos positivos", si la cantidad de respuestas es mayor a la mitad de los encuestados.
- "pocos positivos", si la cantidad de respuestas es menor a la mitad de los encuestados.
- "igual positivos", si la cantidad de respuestas es igual a la mitad de los encuestados.
- Nil si la cantidad de respuestas positivas es cero.
