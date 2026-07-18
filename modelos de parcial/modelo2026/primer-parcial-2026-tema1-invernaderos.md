# PRIMER PARCIAL
**PARADIGMAS Y LENGUAJES DE PROGRAMACIÓN - LENGUAJE LISP**
**TEMA N°1** | **Fecha:** 18/05/2026

**Apellido y Nombre:** ........................................................................ **DNI:** ........................................

**Recordar que se descontarán puntos por:**
* Uso excesivo de variables y variables globales.
* Falta de validación de datos, considerar que no hay certeza de los datos ingresados, es decir pueden ser listas heterogéneas.
* Anidación de IF/COND y diferentes combinaciones.

---

Una empresa desarrolla un sistema para supervisar automáticamente distintos invernaderos utilizados para cultivos de precisión.

Cada invernadero posee un sensor que registra información relacionada con temperatura y nivel de agua. Es necesario analizar esos datos para decidir si las condiciones ambientales son adecuadas para las plantas y, en caso necesario, generar alertas para el operador.

La información enviada por los sensores se representa en una listas con la siguiente estructura:

`(ID_SENSOR (Temp_MIN Temp_MAX) ACTUAL_Temp ACTUAL_Agua RADIO)`

Donde:
* **`ID_SENSOR`** representa el identificador del sensor.
* **`(Temp_MIN Temp_MAX)`** representa el rango de temperatura permitida para el funcionamiento óptimo.
* **`ACTUAL_Temp`** representa el valor de temperatura registrado actualmente.
* **`ACTUAL_Agua`** representa la altura del agua registrada actualmente.
* **`RADIO`** representa el radio del tanque de almacenamiento.

---

**1.-** Antes de comenzar el monitoreo, el sistema debe calcular la cantidad de agua disponible en el tanque del invernadero. *(1.5p)*

Desarrollar una función que a partir de los datos de un sensor, calcule el volumen actual de agua almacenada en el tanque utilizando la fórmula correspondiente al volumen de un cilindro.

*( vol = PI * r^2 * altura )*

---

**2.-** Con la información del sensor, el sistema necesita verificar si el valor registrado por el sensor (`ACTUAL_Temp`), se encuentra dentro de los parámetros adecuados (`Temp_MIN Temp_MAX`) para el correcto crecimiento de las plantas. La lista de datos del sensor ingresa como parámetro.

Desarrollar una función predicado que reciba la lista correspondiente a un sensor y evalúe si la temperatura actual está dentro del rango permitido. *(1.5p)*

---

**3.-** El sistema debe generar una lista con la identificación (`ID_SENSOR`) y el estado descriptivo para que el operador pueda interpretar rápidamente la situación de cada sensor. *(1.5 p)*

Defina una función que reciba la lista correspondiente al sensor. Y,

* retorne `(ID-SENSOR Óptimo)`, si el valor actual se encuentra dentro del rango permitido.
* retorne `(ID-SENSOR Bajo_Nivel)`, cuando el valor actual sea menor al mínimo permitido.
* retorne `(ID-SENSOR Exceso)`, cuando el valor actual sea mayor al máximo permitido.

---

**4.-** Hasta el momento se desarrollaron las funciones que el sistema utiliza para trabajar con los datos correspondientes a un sensor. Pero el sistema es más grande y trabaja con varios sensores por lo tanto el dato de entrada ahora se transforma en una lista de sublistas con el siguiente formato:

```lisp
(
  (ID_SENSOR (Temp_MIN Temp_MAX) ACTUAL_Temp ACTUAL_Agua RADIO)
  (ID_SENSOR (Temp_MIN Temp_MAX) ACTUAL_Temp ACTUAL_Agua RADIO)
  (ID_SENSOR (Temp_MIN Temp_MAX) ACTUAL_Temp ACTUAL_Agua RADIO)
  ...
)
```
 
Desarrollar una función que solicite al operador el ingreso de la lista completa con los datos de todos los sensores, y mostrar en consola (pantalla) un informe con: (0.5p)

 * -> Generar una lista con la identificación y un estado descriptivo de todos los sensores de la lista ingresada. (para este punto utilizar MAPCAR). (1.75 p)

 * -> Informar el total de agua almacenada en todos los tanques del invernadero. (para este punto utilizar un proceso recursivo). (1.75 p)

 * -> Saber si hay al menos un sensor cuya temperatura no está dentro del rango permitido. (1.5 p)