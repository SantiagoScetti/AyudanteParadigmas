# Modelo 2 — Recursividad y MAPCAR — Para llevar de tarea
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

Una biblioteca registra los préstamos de libros en una lista formada por sublistas, donde cada sublista posee dos elementos:
- El primer elemento es la cantidad de días que el libro estuvo prestado.
- El segundo elemento es un átomo que indica el estado de devolución: `BIEN` o `DANADO`.

**a)** Desarrollar una función predicado, la que a partir de la lista que será ingresada por el operador, determine si **todos** los préstamos registrados fueron devueltos en buen estado (`BIEN`).

**b)** Desarrollar una función, la que a partir de la lista y una cantidad de días, ambos ingresados como parámetros, determine la cantidad de préstamos cuya duración superó la cantidad de días ingresada.

**c)** Desarrollar una función que permita determinar la cantidad total de préstamos registrados en la lista.

**d)** Desarrollar una función utilizando MAPCAR, la cual a partir de la lista ingresada como parámetro, devuelva una lista formada solamente por la cantidad de días de cada préstamo.

**e)** Definir una función utilizando un proceso recursivo, el cual a partir de la lista ingresada como parámetro, devuelva una nueva lista formada solamente por las sublistas de los préstamos devueltos `DANADO`.

**f)** Definir una función utilizando MAPCAR, la que a partir de la lista que será ingresada como parámetro, devuelva una nueva lista formada por mensajes según la duración de cada préstamo:
- "rapido", si la cantidad de días es menor o igual a 7.
- "normal", si la cantidad de días es mayor a 7 y menor o igual a 15.
- "demorado", si la cantidad de días es mayor a 15.
