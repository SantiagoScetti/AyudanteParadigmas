# Modelo 2 — Recursividad y MAPCAR — Para hacer en clase
**Programación Funcional — Lenguaje LISP**

**Alcance:** foco en TP4 (recursividad) y TP5 (MAPCAR). Cada punto indica explícitamente qué herramienta usar — respetá la consigna: si pide MAPCAR no uses recursión y viceversa.

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
| c | 0,5 |
| d | 2 |
| e | 2 |
| f | 2 |

---

Un taller mecánico registra las reparaciones realizadas en una lista formada por sublistas, donde cada sublista posee dos elementos:
- El primer elemento es el costo de la reparación (en pesos).
- El segundo elemento es el tiempo insumido (en horas).

**a)** Desarrollar una función predicado, la que a partir de la lista y una cantidad de horas ingresadas ambas por el operador, determine si **todas** las reparaciones registradas tuvieron un tiempo menor o igual a la cantidad de horas ingresada.

**b)** Desarrollar una función, la que a partir de la lista y un valor de costo, ambos ingresados como parámetros, determine la cantidad de reparaciones cuyo costo supera el valor ingresado.

**c)** Desarrollar una función que permita determinar la cantidad total de reparaciones registradas en la lista.

**d)** Desarrollar una función utilizando MAPCAR, la cual a partir de la lista ingresada como parámetro, devuelva una lista formada solamente por los tiempos insumidos en cada reparación.

**e)** Definir una función utilizando un proceso recursivo, el cual a partir de la lista ingresada como parámetro, devuelva una nueva lista formada solamente por las sublistas de reparaciones cuyo costo sea mayor a $50.000.

**f)** Definir una función utilizando MAPCAR, la que a partir de la lista que será ingresada como parámetro, devuelva una nueva lista formada por mensajes según el costo de cada reparación:
- "economica", si el costo es menor o igual a $20.000.
- "moderada", si el costo es mayor a $20.000 y menor o igual a $60.000.
- "cara", si el costo es mayor a $60.000.
