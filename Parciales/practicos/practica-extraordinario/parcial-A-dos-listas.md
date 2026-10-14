# PRÁCTICA PARA EXTRAORDINARIO — MODELO A
**PARADIGMAS Y LENGUAJES DE PROGRAMACIÓN - LENGUAJE LISP**
**Tema:** Dos listas paralelas | **Fecha:** ___/___/2026

*(Modelo de práctica de ayudantía. No es un examen oficial.)*

**Apellido y Nombre:** ........................................................................ **DNI:** ........................................

**Recordar que se descontarán puntos por:**
* Uso excesivo de variables y variables globales.
* Falta de validación de datos: considerar que no hay certeza de los datos ingresados, es decir pueden ser listas heterogéneas.
* Anidación de IF/COND y diferentes combinaciones.

---

Una estación urbana mide la **calidad del aire** y registra cada hora **dos mediciones simultáneas**. La información llega en **dos listas separadas**:

* *lista-pm25*: valores enteros con la concentración de partículas PM2.5 (en µg/m³).
* *lista-co*: valores enteros con la concentración de monóxido de carbono CO (en ppm).

**Cada posición N de ambas listas corresponde exactamente a la misma hora.** Por ejemplo, el primer elemento de cada lista corresponde a la hora 1, el segundo a la hora 2, y así sucesivamente.

Una hora se considera de **aire crítico** si se cumple **al menos una** de estas condiciones:
* La concentración de PM2.5 es **mayor a 50**.
* La concentración de CO es **mayor a 9**.

Datos de prueba sugeridos:

```lisp
(lista-pm25 '(40 55 30 60 45 70 20))
(lista-co   '(5  8  10 7  4  12 6))
```

---

**1.-** El personal necesita evaluar una hora puntual sin mirar todas las listas. Desarrollar una **función predicado** que reciba **dos átomos** (un valor de PM2.5 y un valor de CO) y determine si esa hora es de aire crítico. *(1.5 p)*

---

**2.-** El tablero central usa indicadores luminosos para ver de un vistazo los momentos de riesgo. Desarrollar una función que reciba **ambas listas** y, utilizando **MAPCAR**, retorne una lista donde:
* `1` representa una hora de aire crítico.
* `0` representa una hora normal.

*(Pista: `MAPCAR` puede recorrer dos listas a la vez.)* *(2 p)*

---

**3.-** Debido a la contaminación acumulada, se debe decidir si se activa un protocolo de emergencia. El protocolo se activa cuando en las listas recibidas se detectan **al menos 4 horas críticas**.

El análisis de las listas deberá efectuarse mediante un **proceso recursivo**, utilizando todas las funciones auxiliares que sean necesarias. La función deberá retornar la lista `(ACTIVAR PROTOCOLO)` o `(MONITOREO NORMAL)` según corresponda. *(2 p)*

---

**4.-** Para el reporte diario se piden dos datos sobre las mediciones individuales: *(2 p en total)*

* → El **pico** de PM2.5, es decir el valor de PM2.5 más alto registrado en la jornada. *(proceso recursivo)* *(1 p)*
* → Saber si hubo **al menos una** medición de CO peligrosa, entendiendo por peligrosa un valor **mayor o igual a 9**. La función retorna `T` o `NIL`. *(proceso recursivo)* *(1 p)*

---

**5.-** Desarrollar la **función principal** que solicite al operador el ingreso de las **dos listas** (PM2.5 y CO), realice todas las validaciones necesarias para contemplar el **peor escenario posible** de ingreso de datos, y pruebe las funciones desarrolladas mostrando los resultados en pantalla. *(2.5 p)*

---

**6.- DESAFÍO** *(puntos adicionales)*

**a)** La central quiere saber **en qué hora** la situación fue peor. Definiendo el *índice combinado* de una hora como `PM2.5 + CO`, desarrollar una función que reciba ambas listas y devuelva el **número de hora** (posición, empezando en 1) con el mayor índice combinado.

**b)** Para un estudio epidemiológico se necesita el **promedio de PM2.5 considerando únicamente las horas críticas**. Desarrollar una función que reciba ambas listas y calcule dicho promedio.
