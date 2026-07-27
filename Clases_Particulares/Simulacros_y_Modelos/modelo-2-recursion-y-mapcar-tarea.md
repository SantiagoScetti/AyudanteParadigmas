# Modelo 2 — Recursividad y MAPCAR — Para llevar de tarea
**Programación Funcional — Lenguaje LISP**

**Alcance:** foco en TP4 (recursividad) y TP5 (MAPCAR).

### Ningún punto te dice qué herramienta usar
A diferencia de las prácticas anteriores, acá **no vas a encontrar la palabra "recursividad" ni "MAPCAR" en las consignas**. Decidir cuál corresponde en cada punto es parte del ejercicio.
Antes de escribir una sola línea de código, escribí al lado de cada punto **qué elegiste y por qué**. Si no podés justificarlo en una frase, todavía no entendiste el punto.


Una biblioteca registra los préstamos de libros en una lista formada por sublistas, donde cada sublista posee **tres** elementos:
- El primer elemento es la cantidad de días que el libro estuvo prestado.
- El segundo elemento es un átomo que indica el estado de devolución: `BIEN` o `DANADO`.
- El tercer elemento es la cantidad de páginas del libro.

Se define el **ritmo de lectura** de un préstamo como la cantidad de páginas del libro dividida por la cantidad de días que estuvo prestado.

**a)** Desarrollar una función predicado, la que a partir de la lista que será ingresada por el operador, determine si **todos** los préstamos registrados fueron devueltos en buen estado (`BIEN`).

**b)** Desarrollar una función, la que a partir de la lista y una cantidad de días, ambos ingresados como parámetros, determine la cantidad de préstamos cuya duración superó la cantidad de días ingresada.

**c)** Desarrollar una función que permita determinar la cantidad total de préstamos registrados en la lista.

**d)** Desarrollar una función, la cual a partir de la lista ingresada como parámetro, devuelva una lista formada solamente por la cantidad de páginas de cada libro.

**e)** Definir una función, la cual a partir de la lista ingresada como parámetro, devuelva una nueva lista formada solamente por las sublistas de los préstamos devueltos `DANADO`.

**f)** Definir una función, la que a partir de la lista que será ingresada como parámetro, devuelva una nueva lista formada por mensajes según el **ritmo de lectura** de cada préstamo:
- "lento", si el ritmo es menor o igual a 20 páginas por día.
- "normal", si el ritmo es mayor a 20 y menor o igual a 60 páginas por día.
- "veloz", si el ritmo es mayor a 60 páginas por día.


**g)** Desarrollar una función que, a partir de la lista ingresada como parámetro, devuelva **una única sublista**: la del préstamo con **mayor ritmo de lectura de entre todos los que fueron devueltos en buen estado** (`BIEN`). Si en la lista no hay ningún préstamo devuelto `BIEN`, la función debe devolver `NIL`.


**h)** Desarrollar una función que reciba como parámetros **dos listas**: la lista de préstamos y una segunda lista, de igual longitud, con los nombres de los socios que retiraron cada libro (en el mismo orden). La función debe devolver una nueva lista en la que cada elemento sea una sublista de la forma `(SOCIO RITMO OBSERVACION)`, donde:
- `SOCIO` es el nombre del socio correspondiente a ese préstamo.
- `RITMO` es el ritmo de lectura **truncado a un número entero** (usar `floor`).
- `OBSERVACION` es un átomo que vale:
  - `RECLAMAR`, si el libro fue devuelto `DANADO`.
  - `MOROSO`, si el libro fue devuelto `BIEN` pero estuvo prestado más de 30 días.
  - `OK`, en cualquier otro caso.

**i)** Desarrollar una función Menú que permita al operador ingresar las listas y valores que sean necesarios y que llame a todas las funciones que se desarrollaron en los ejercicios anteriores.

---

## Datos de prueba sugeridos

```lisp
((5 BIEN 300) (20 DANADO 150) (10 BIEN 900) (3 DANADO 40) (40 BIEN 1200))
```

Lista de socios para el punto **h)**:

```lisp
(ANA BETO CARLA DIEGO EVA)
```
