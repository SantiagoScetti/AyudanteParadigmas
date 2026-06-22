# PRÁCTICA PARA EXTRAORDINARIO — MODELO C
**PARADIGMAS Y LENGUAJES DE PROGRAMACIÓN - LENGUAJE LISP**
**Tema:** Una sola lista + un parámetro (predicado universal, partición, filtros, mapcar por tramos) | **Fecha:** ___/___/2026

*(Modelo de práctica de ayudantía. No es un examen oficial.)*
*(Este modelo replica la familia del **Segundo Parcial 2023 - Tema 2** y de los TP 4 y 5, que NO aparece en los modelos A ni B.)*

**Apellido y Nombre:** ........................................................................ **DNI:** ........................................

**Recordar que se descontarán puntos por:**
* No utilización de variables locales cuando sea necesario. Uso de variables globales.
* IF anidados con COND o viceversa.
* Falta de validación en los casos que sea necesario (las listas pueden ser heterogéneas).

---

Una aplicación de música registra en **una única lista** la **duración (en segundos)** de cada canción de una playlist. Por ejemplo:

```lisp
(setq playlist '(200 45 90 30 180 240 90))
```

Además, el operador ingresará un **número** (un *umbral* de duración en segundos) que se usará como parámetro en varias funciones.

> Las funciones deben ser genéricas: tienen que andar para **cualquier** lista y cualquier umbral que se ingrese, no solo para el ejemplo.

---

**1.-** El equipo quiere saber si la playlist es "intensa". Desarrollar una **función predicado** que reciba la **lista** y un **umbral** (número) y determine si **todas** las canciones duran **más** que el umbral. *(1.5 p)*

---

**2.-** Para reorganizar la biblioteca, desarrollar una función que reciba la lista y devuelva una **nueva lista formada por dos sublistas**, donde: *(2 p)*
* la **primera** sublista contiene las canciones que duran **más de 60** segundos (tal cual, en segundos);
* la **segunda** sublista contiene las que duran **60 o menos**, pero **expresadas en minutos** (dividir la duración por 60).

---

**3.-** Desarrollar una función que reciba la **lista** y un **umbral** (número) y determine la **cantidad** de canciones que duran **menos o igual** que el umbral. *(1.5 p)*

---

**4.-** Utilizando **MAPCAR**, desarrollar una función que reciba la **lista** y un **umbral**, y devuelva una nueva lista que, para cada canción, contenga el símbolo `SI` si dura **más** que el umbral, o `NO` en caso contrario. *(1.5 p)*

---

**5.-** Utilizando **MAPCAR**, desarrollar una función que reciba la **lista** y devuelva una nueva lista formada por **sublistas**. Cada sublista contendrá la **duración** y un **mensaje**: *(2 p)*
* si la duración es **60 o menos** → `CORTA`
* si la duración es **mayor a 60 y hasta 180** → `MEDIA`
* si la duración es **mayor a 180** → `LARGA`

---

**6.-** Desarrollar la **función principal** que solicite al operador el ingreso de la **lista** y del **umbral**, realice las **validaciones** necesarias (peor escenario posible) y pruebe las funciones desarrolladas mostrando los resultados en pantalla. *(1.5 p)*

---

**7.- DESAFÍO** *(puntos adicionales — 1 punto por ítem)*

**a)** Desarrollar una función que devuelva la lista **sin duraciones repetidas** (si una duración aparece varias veces, debe quedar una sola).

**b)** Desarrollar una **función predicado** que determine si la playlist está **ordenada de menor a mayor** duración.

**c)** A partir de una **lista heterogénea** y un **átomo numérico**, devolver una nueva lista de sublistas `(elemento  cociente)`, donde *cociente* es el elemento dividido por el átomo, **solo** para los elementos que sean **números mayores a cero**.
Por ejemplo, con la lista `(16 (2 3) -2 40 S (D F))` y el átomo `2`, debe devolver `((16 8) (40 20))`.
