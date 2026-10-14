# SIMULACRO DE PARCIAL
**PARADIGMAS Y LENGUAJES DE PROGRAMACIÓN - LENGUAJE LISP**
**Fecha:** ___/___/2026

**Apellido y Nombre:** ........................................................................ **DNI:** ........................................

**Recordar que se descontarán puntos por:**
* Uso excesivo de variables y variables globales.
* Falta de validación de datos, considerar que no hay certeza de los datos ingresados, es decir pueden ser listas heterogéneas.
* Anidación de IF/COND y diferentes combinaciones.

---

Una empresa de logística autónoma opera una flota de **drones de reparto** para abastecer localidades de difícil acceso. Cada dron está equipado con un módulo de telemetría que transmite en tiempo real información sobre su estado operativo.

Los datos reportados por cada dron se representan en una lista con la siguiente estructura:

`(ID_DRON  CARGA  (BATERIA_ACTUAL  BATERIA_MIN  BATERIA_MAX)  AUTONOMIA)`

Donde:
* **`ID_DRON`** representa el identificador único del dron dentro de la flota.
* **`CARGA`** representa el peso en kilogramos de la mercadería que el dron transporta actualmente.
* **`(BATERIA_ACTUAL  BATERIA_MIN  BATERIA_MAX)`** es una sublista que contiene el nivel de batería actual del dron (en porcentaje) y los límites mínimo y máximo del rango de operación segura.
* **`AUTONOMIA`** representa la distancia máxima en kilómetros que el dron puede recorrer con la batería cargada al 100%.

---

**1.-** Para planificar las misiones de reparto, el sistema necesita saber qué distancia real puede recorrer cada dron dadas sus condiciones actuales de batería. *(1.5 p)*

Desarrollar una función que, a partir de los datos de un dron, calcule la distancia máxima real que puede recorrer en las condiciones actuales.

*( distancia = AUTONOMIA × (BATERIA_ACTUAL / 100) )*

---

**2.-** Antes de asignar una misión, el sistema verifica si el nivel de batería del dron se encuentra en condiciones seguras para operar. *(1.5 p)*

Desarrollar una función predicado que reciba la lista correspondiente a un dron y evalúe si el nivel de batería actual se encuentra dentro del rango operativo seguro `(BATERIA_MIN, BATERIA_MAX)`.

---

**3.-** La central de control necesita conocer de forma descriptiva el estado de operación de cada dron para tomar decisiones rápidas. *(1.5 p)*

Defina una función que reciba la lista de un dron y,

* retorne `(ID_DRON  CRITICO)`, cuando el nivel de batería actual sea menor al mínimo operativo.
* retorne `(ID_DRON  LISTO)`, si el nivel de batería actual se encuentra dentro del rango seguro.
* retorne `(ID_DRON  SOBRECARGA)`, cuando el nivel de batería actual supere el máximo operativo.

---

**4.-** Hasta el momento se desarrollaron las funciones que el sistema utiliza para trabajar con los datos de un único dron. Pero el sistema es más grande y gestiona la flota completa, por lo tanto el dato de entrada ahora se transforma en una lista de sublistas con el siguiente formato:

```lisp
(
  (ID_DRON  CARGA  (BATERIA_ACTUAL  BATERIA_MIN  BATERIA_MAX)  AUTONOMIA)
  (ID_DRON  CARGA  (BATERIA_ACTUAL  BATERIA_MIN  BATERIA_MAX)  AUTONOMIA)
  (ID_DRON  CARGA  (BATERIA_ACTUAL  BATERIA_MIN  BATERIA_MAX)  AUTONOMIA)
  ...
)
```

Desarrollar una función que solicite al operador el ingreso de la lista completa con los datos de la flota, y mostrar en consola un informe con: *(0.5 p)*

 * → Generar una lista con el identificador y el estado operativo de cada dron de la flota. *(para este punto utilizar MAPCAR). (1.75 p)*

 * → Calcular la distancia total que podría recorrer toda la flota de manera simultánea, considerando las condiciones actuales de batería de cada dron. *(para este punto utilizar un proceso recursivo). (1.75 p)*

 * → Determinar si existe en la flota al menos un dron cuya batería no se encuentre dentro del rango operativo seguro. *(1.5 p)*

---

**5.- DESAFÍO** *(puntos adicionales — 1 punto por ítem)*

Los siguientes ejercicios requieren mayor nivel de análisis. Resolverlos correctamente suma puntos adicionales a la nota final.

**a)** El sistema necesita identificar al dron con mayor alcance real en las condiciones actuales. Desarrollar una función que, dada la lista completa de la flota, devuelva el **ID** del dron que puede recorrer la mayor distancia en este momento.

**b)** Para evaluar si se debe llamar a una recarga masiva de la flota, la central necesita conocer el **nivel de batería promedio** de todos los drones. Desarrollar una función que calcule dicho promedio.

**c)** El equipo de logística necesita un reporte de distribución del estado operativo de la flota. Dada la **lista de estados** generada en el Punto 4 —lista de pares `(ID_DRON  ESTADO)`—, desarrollar una función que indique cuántos drones hay en cada categoría con el siguiente formato de salida:

`(CRITICOS  N   LISTOS  N   SOBRECARGA  N)`
