# Modelo 7 — Validación estructural, transformación y promedio
**Programación Funcional — Lenguaje LISP**

**Alcance:** una **sola lista de sublistas**, con el formato exacto que la cátedra tomó en el segundo parcial de 2025 (temas *ondas* y *proyectos*) y en el de 2023 (*prendas*). No hay dos listas en paralelo ni parámetros sueltos: la dificultad está en **otras cuatro cosas que no aparecieron en ningún modelo anterior**:

- un **predicado que valida la estructura** de la lista (¿todos los elementos son sublistas de 3 elementos?),
- **reemplazar un campo adentro de la sublista** devolviendo la sublista completa, no un dato suelto,
- un **promedio con condición** (sumar y contar solo algunos),
- **encadenar**: un punto que trabaja sobre la lista que devolvió otro punto.

Además, uno de los puntos tiene que **soportar datos sucios**: elementos que no son sublistas o que no traen un número donde corresponde.

## Ningún punto te dice qué herramienta usar
En las consignas **no vas a encontrar la palabra "recursividad" ni "MAPCAR"**. Decidir cuál corresponde en cada punto es parte del ejercicio. Antes de escribir código, anotá al lado de cada punto **qué elegiste y por qué**.

## Importante: se descontarán puntos por
- No utilización de variables locales cuando sea necesario.
- IF anidados con COND o viceversa.
- Falta de validación en los casos que sea necesario.
- Falta de mensajes alusivos en el ingreso de datos.
- Uso excesivo o innecesario de variables auxiliares.

---

Un **hemocentro** registra las donaciones de sangre de la jornada en una lista formada por sublistas, donde cada sublista tiene **3 elementos**:

`(DONANTE VOLUMEN ESTADO)`

Donde:
- **`DONANTE`** es un átomo con el nombre del donante.
- **`VOLUMEN`** es un número con los mililitros extraídos.
- **`ESTADO`** es el resultado del control de la bolsa, y puede ser:
  - `A` si la donación quedó **apta**,
  - `O` si quedó **en observación**,
  - `R` si fue **rechazada**.

---

**1.-** Desarrollar una función predicado que, a partir de la lista ingresada por el operador, determine si **todos los elementos de la lista son sublistas de 3 elementos**. *(1,5 p)*

**2.-** Definir una función que, a partir de la lista ingresada como parámetro, devuelva una nueva lista formada por sublistas, en la que se **reemplace el estado por su descripción**, conservando el resto de los datos de cada donación: *(2 p)*
- `A` se debe reemplazar por `"apta"`
- `O` se debe reemplazar por `"en observacion"`
- `R` se debe reemplazar por `"rechazada"`

**3.-** Desarrollar una función que, a partir de la lista ingresada como parámetro, devuelva una nueva lista formada solamente por las **sublistas de las donaciones que quedaron aptas**. *(2 p)*

**4.-** Desarrollar una función que, **a partir de la lista resultante del punto 3**, devuelva una nueva lista formada solamente por los **nombres de los donantes**. *(1,5 p)*

**5.-** Desarrollar una función que, a partir de la lista ingresada como parámetro, calcule el **volumen promedio de las donaciones aptas**. *(2 p)*

> **Atención:** esta función puede recibir una lista con datos sucios, es decir, elementos que no sean sublistas de 3 elementos o que no tengan un número en el volumen. Esos elementos deben **saltearse**, no deben hacer fallar la función ni entrar en el promedio.

**6.-** Desarrollar una función Menú que solicite al operador el ingreso de la lista, la valide **utilizando la función del punto 1**, y muestre en consola el resultado de todas las funciones desarrolladas en los puntos anteriores. *(1 p)*

---

## Desafío *(puntos adicionales — 1 punto por ítem)*

**a)** Desarrollar una función que, a partir de la lista, devuelva la **distribución de las donaciones** con el siguiente formato de salida:

`(APTAS N OBSERVADAS N RECHAZADAS N)`

**b)** Desarrollar una función que, a partir de la lista, determine la **cantidad de donaciones cuyo volumen supera el promedio general** de la jornada (el promedio de todas las donaciones, sin importar el estado).

---

## Datos para probar

```lisp
(setq donaciones '((ANA 450 A) (BETO 380 O) (CARLA 500 A)
                   (DIEGO 420 R) (EVA 470 A) (FELIPE 400 O)))
```

Y para probar el punto 5 con datos sucios:

```lisp
(setq sucia '((ANA 450 A) HOLA (CARLA 500 A) (X Y) (EVA 470 A) (BETO 380 O)))
```
