# PRÁCTICA PARA EXTRAORDINARIO — MODELO B
**PARADIGMAS Y LENGUAJES DE PROGRAMACIÓN - LENGUAJE LISP**
**Tema:** Registro con sublista anidada y lista de registros | **Fecha:** ___/___/2026

*(Modelo de práctica de ayudantía. No es un examen oficial.)*

**Apellido y Nombre:** ........................................................................ **DNI:** ........................................

**Recordar que se descontarán puntos por:**
* Uso excesivo de variables y variables globales.
* Falta de validación de datos: considerar que no hay certeza de los datos ingresados, es decir pueden ser listas heterogéneas.
* Anidación de IF/COND y diferentes combinaciones.

---

Una empresa administra una **red de electrolineras** (estaciones de carga de autos eléctricos). Cada estación reporta su estado en una lista con la siguiente estructura:

`(ID_ESTACION  DEMANDA  (TENSION_MIN  TENSION_ACTUAL  TENSION_MAX)  TARIFA)`

Donde:
* **`ID_ESTACION`** es el identificador de la estación.
* **`DEMANDA`** es la potencia que se está consumiendo en este momento (en kW).
* **`(TENSION_MIN  TENSION_ACTUAL  TENSION_MAX)`** es una **sublista** con el valor de tensión actual y los límites mínimo y máximo de operación segura.
* **`TARIFA`** es el precio de la energía (en $ por kWh).

Datos de prueba de ejemplo:

```lisp
(red '(
    (E1 50 (200 220 240) 35)
    (E2 80 (210 205 230) 40)
    (E3 30 (200 250 240) 38)
))
```

---

**1.-** Antes de facturar, el sistema necesita estimar el costo. Desarrollar una función que, a partir de los datos de **una** estación, calcule el **costo actual** según la fórmula: *(1.5 p)*

*( costo = DEMANDA × TARIFA )*

---

**2.-** El sistema debe verificar si una estación opera con tensión segura. Desarrollar una **función predicado** que reciba la lista de **una** estación y evalúe si la `TENSION_ACTUAL` se encuentra dentro del rango permitido `(TENSION_MIN, TENSION_MAX)`. *(1.5 p)*

---

**3.-** El centro de control necesita el estado descriptivo de cada estación. Definir una función que reciba la lista de **una** estación y, *(2 p)*

* retorne `(ID_ESTACION  BAJA)`, cuando la tensión actual sea menor al mínimo permitido.
* retorne `(ID_ESTACION  ESTABLE)`, si la tensión actual se encuentra dentro del rango seguro.
* retorne `(ID_ESTACION  ALTA)`, cuando la tensión actual supere el máximo permitido.

---

**4.-** Hasta acá se trabajó con una sola estación. Pero la red es grande, por lo que el dato de entrada ahora es una **lista de sublistas** con el siguiente formato:

```lisp
(
  (ID_ESTACION  DEMANDA  (TENSION_MIN  TENSION_ACTUAL  TENSION_MAX)  TARIFA)
  (ID_ESTACION  DEMANDA  (TENSION_MIN  TENSION_ACTUAL  TENSION_MAX)  TARIFA)
  ...
)
```

Desarrollar: *(3 p en total)*

* → Una función que, utilizando **MAPCAR**, genere la lista con el **identificador y el estado** de cada estación de la red. *(1.5 p)*
* → Una función que, mediante un **proceso recursivo**, calcule la **demanda total** sumando la `DEMANDA` de todas las estaciones de la red. *(1.5 p)*

---

**5.-** Desarrollar la **función principal** que solicite al operador el ingreso de la **lista completa** de la red, realice las validaciones necesarias para el **peor escenario posible**, y muestre en pantalla:
* la lista de estados (punto 4),
* la demanda total (punto 4),
* y si existe en la red **al menos una** estación cuya tensión **no** sea segura. *(2 p)*

---

**6.- DESAFÍO** *(puntos adicionales — 1 punto por ítem)*

**a)** Identificar la estación más exigida: desarrollar una función que, dada la lista completa de la red, devuelva el **ID de la estación con mayor DEMANDA**.

**b)** A partir de la **lista de estados** generada en el Punto 4 —lista de pares `(ID_ESTACION  ESTADO)`— desarrollar una función que indique cuántas estaciones hay en cada categoría, con el formato:

`(BAJAS  N   ESTABLES  N   ALTAS  N)`
