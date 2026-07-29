# Modelo 3 — Integrador (un poco de todo, estilo 2026)
**Programación Funcional — Lenguaje LISP**

**Alcance:** integra todo lo visto — predicados, clasificación con COND, MAPCAR, recursividad y función principal con validación de datos. Es el formato más parecido al que se toma actualmente en los parciales combinados.

## Importante: se descontarán puntos por
- Uso excesivo de variables y variables globales.
- Falta de validación de datos: considerar que no hay certeza de los datos ingresados, es decir pueden ser listas heterogéneas.
- Anidación de IF/COND y diferentes combinaciones.


Una empresa apícola monitorea sus colmenas mediante sensores. Cada colmena envía una lista con la siguiente estructura:

`(ID_COLMENA (TEMP_MIN TEMP_MAX) TEMP_ACTUAL PESO_ACTUAL CANTIDAD_ABEJAS)`

Donde:
- **`ID_COLMENA`** representa el identificador de la colmena.
- **`(TEMP_MIN TEMP_MAX)`** representa el rango de temperatura interna óptima, en grados Celsius (°C).
- **`TEMP_ACTUAL`** representa la temperatura interna actual registrada.
- **`PESO_ACTUAL`** representa el peso actual de la colmena, en kg.
- **`CANTIDAD_ABEJAS`** representa la población estimada de abejas.

---

**1.-** El sistema necesita estimar la producción de miel de cada colmena, sabiendo que cada 1000 abejas producen en promedio 0,5 kg de miel por temporada. *(1,5 p)*

Desarrollar una función que, a partir de los datos de una colmena, calcule la producción estimada de miel.

*( produccion = (CANTIDAD_ABEJAS / 1000) * 0.5 )*

---

**2.-** Con la información de la colmena, el sistema necesita verificar si la temperatura interna actual (`TEMP_ACTUAL`) se encuentra dentro del rango óptimo (`TEMP_MIN TEMP_MAX`). *(1,5 p)*

Desarrollar una función predicado que reciba la lista correspondiente a una colmena y evalúe si la temperatura actual está dentro del rango permitido.

---

**3.-** El sistema debe generar un estado descriptivo para que el apicultor pueda interpretar rápidamente la situación de cada colmena. *(1,5 p)*

Defina una función que reciba la lista correspondiente a la colmena y:
- retorne `(ID_COLMENA NORMAL)`, si la temperatura actual está dentro del rango permitido.
- retorne `(ID_COLMENA RIESGO_FRIO)`, cuando la temperatura actual sea menor a la mínima permitida.
- retorne `(ID_COLMENA RIESGO_CALOR)`, cuando la temperatura actual sea mayor a la máxima permitida.

---

**4.-** Hasta el momento se desarrollaron las funciones que el sistema utiliza para trabajar con los datos de una única colmena. Pero el apiario tiene varias colmenas, por lo tanto el dato de entrada ahora se transforma en una lista de sublistas con el siguiente formato:

```lisp
(
  (ID_COLMENA (TEMP_MIN TEMP_MAX) TEMP_ACTUAL PESO_ACTUAL CANTIDAD_ABEJAS)
  (ID_COLMENA (TEMP_MIN TEMP_MAX) TEMP_ACTUAL PESO_ACTUAL CANTIDAD_ABEJAS)
  (ID_COLMENA (TEMP_MIN TEMP_MAX) TEMP_ACTUAL PESO_ACTUAL CANTIDAD_ABEJAS)
  ...
)
```

Desarrollar una función que solicite al operador el ingreso de la lista completa con los datos de todas las colmenas, valide que efectivamente sea una lista, y muestre en consola un informe con: *(0,5 p)*

* → Una lista con la identificación y el estado descriptivo de todas las colmenas del apiario. *(para este punto utilizar MAPCAR). (1,75 p)*

* → La producción total estimada de miel de todo el apiario. *(para este punto utilizar un proceso recursivo). (1,75 p)*

* → Si existe al menos una colmena en riesgo (frío o calor). *(1,5 p)*
