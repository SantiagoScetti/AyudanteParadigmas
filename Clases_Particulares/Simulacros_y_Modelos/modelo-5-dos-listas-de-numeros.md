# Modelo 5 — Dos listas de números en paralelo
**Programación Funcional — Lenguaje LISP**

**Alcance:** recursividad, MAPCAR sobre dos listas y función Menú con validación. Es el modelo **más simple** de la carpeta en cuanto a estructura de datos: acá **no hay registros ni sublistas**, son dos listas planas de números que se recorren a la par. Toda la dificultad está en elegir bien la herramienta y en avanzar las dos listas juntas, no en acordarse de los accesores.

## Ningún punto te dice qué herramienta usar
En las consignas **no vas a encontrar la palabra "recursividad" ni "MAPCAR"**. Decidir cuál corresponde en cada punto es parte del ejercicio. Antes de escribir código, anotá al lado de cada punto **qué elegiste y por qué**.

## Importante: se descontarán puntos por
- No utilización de variables locales cuando sea necesario.
- IF anidados con COND o viceversa.
- Falta de validación en los casos que sea necesario.
- Falta de mensajes alusivos en el ingreso de datos.
- Uso excesivo o innecesario de variables auxiliares.

---

La panadería **"La Espiga"** tiene dos sucursales y anota cuántos **kilos de pan** vende cada una por día. La información de la semana llega en **dos listas de números**:

```lisp
CENTRO: ( KILOS  KILOS  KILOS  ... )
NORTE:  ( KILOS  KILOS  KILOS  ... )
```

**Las dos listas tienen la misma cantidad de elementos y cada posición corresponde al mismo día:** la posición 1 es el lunes, la posición 2 el martes, y así sucesivamente. Los elementos son números sueltos, no sublistas.

---

**1.-** Desarrollar una función predicado que reciba **dos números** —los kilos que vendió cada sucursal en un mismo día— y determine si fue un **día de venta alta**, es decir, si entre las dos vendieron más de 200 kilos. *(1 p)*

**2.-** Desarrollar una función que reciba **las dos listas** y devuelva una nueva lista con el **total de kilos vendidos cada día** entre ambas sucursales. *(1,5 p)*

**3.-** Desarrollar una función que reciba **las dos listas** y devuelva una nueva lista donde cada elemento indique **qué sucursal vendió más ese día**: *(1,5 p)*
- `CENTRO`, si ese día vendió más la sucursal Centro.
- `NORTE`, si ese día vendió más la sucursal Norte.
- `EMPATE`, si las dos vendieron lo mismo.

**4.-** Desarrollar una función que, a partir de **una** de las listas, calcule el **total de kilos** que vendió esa sucursal en toda la semana. *(1,5 p)*

**5.-** Desarrollar una función que reciba **las dos listas** y determine **en cuántos días** la sucursal Centro vendió más que la sucursal Norte. *(1,5 p)*

**6.-** Desarrollar una función que reciba **las dos listas** y devuelva una nueva lista formada solamente por los **kilos que vendió la sucursal Norte** en aquellos días en que **superó** a la sucursal Centro. *(2 p)*

**7.-** Desarrollar una función Menú que solicite al operador el ingreso de las dos listas, valide que ambas sean listas y que tengan la misma cantidad de elementos, y muestre en consola el resultado de todas las funciones desarrolladas en los puntos anteriores. *(1 p)*

---

## Desafío *(puntos adicionales — 1 punto por ítem)*

**a)** Desarrollar una función que reciba las dos listas y devuelva el **número del día** (la posición, empezando en 1) en que **más kilos se vendieron entre las dos sucursales**.

**b)** Desarrollar una función que, a partir de una de las listas, calcule el **promedio** de kilos vendidos por día por esa sucursal.

---

## Datos para probar

```lisp
(setq centro '(120 95 140 80 160 200 75))
(setq norte  '(90 110 140 60 175 150 95))
```
