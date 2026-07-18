# Tema 2 — Segundo Examen Parcial – Programación Funcional (2023)

> Nota: se corrigieron pequeñas erratas de concordancia del PDF original ("la primer sublista estara formada" → "estará", "pesos deberán ser expresadas" → "expresados").

## Importante: se descontarán puntos por
- No utilización de variables locales cuando sea necesario.
- IF anidados con COND o viceversa.
- Falta de validación en los casos que sea necesario.

En una única lista se tienen registrados los pesos expresados en Kg de determinadas cajas que deben ser transportadas.

## Ejercicio Nº 1 — 1.5 Ptos
Desarrollar una función predicado, la que a partir de la lista y una variable numérica (conteniendo un determinado peso) ingresadas ambas por el operador, permita determinar si todas las cajas tienen un peso mayor al peso ingresado por el operador.

## Ejercicio Nº 2 — 2.5 Ptos
Desarrollar una función, la que a partir de la lista con los pesos expresados en Kg, la que será ingresada como parámetro, devuelva una nueva lista formada por dos sublistas. Donde:
- La primer sublista estará formada por los pesos mayores a 30.
- La segunda sublista estará formada solamente con los pesos que sean menores o iguales a 30. Estos pesos deberán ser expresados en gramos. Recordar que 1kg = 1000 gramos.

## Ejercicio Nº 3 — 1.5 Ptos
Desarrollar una función, la que a partir de la lista con los pesos y una variable numérica (conteniendo un determinado peso) ingresados como parámetros, permita determinar la cantidad de cajas que poseen un peso menor o igual al peso ingresado como parámetro.

## Ejercicio Nº 4 — 1.5 Ptos
Definir una función utilizando mapcar, la que a partir de una lista ingresada como parámetro y un valor atómico conteniendo un determinado peso, devuelva una nueva lista cuyos elementos sean el resultado de evaluar uno a uno si cada elemento de la lista original posee un peso mayor al peso ingresado por parámetro.

## Ejercicio Nº 5 — 2 Ptos
Desarrollar una función, utilizando mapcar, la que a partir de la lista con los diferentes pesos, la que será ingresada como parámetro, devuelva una nueva lista formada por sublistas. Cada sublista contendrá un peso y un mensaje. El mensaje será el siguiente:
- Si el peso es <= 20, el mensaje será "liviano".
- Si el peso es > 20 y <= 60, el mensaje será "pesado".
- Si el peso es > 60, el mensaje será "muy pesado".
