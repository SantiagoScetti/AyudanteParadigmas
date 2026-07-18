# RECUPERATORIO PRIMER PARCIAL
## PARADIGMAS Y LENGUAJES DE PROGRAMACION LENGUAJE LISP

**TEMA N° 1** - **08/06/2026**

**Apellido y Nombre:** ........................................................................ **DNI:** ....................................

---

Una unidad de terapia intensiva monitorea continuamente el estado de sus pacientes mediante sensores conectados a un sistema central. Cada minuto se registran dos mediciones simultáneas para cada paciente:

* *lista-frecuencias-cardiacas*: valores enteros que representan la frecuencia cardíaca en pulsaciones por minuto.
* *lista-saturacion-oxigeno*: valores enteros que representan el porcentaje de saturación de oxígeno en sangre.

Cada posición N de ambas listas corresponde exactamente al mismo instante de tiempo.

**1.** Un paciente se considera en estado crítico si se cumple al menos una de las siguientes condiciones:
* La frecuencia cardíaca es menor a 50 o mayor a 120 pulsaciones por minuto.
* La saturación de oxígeno es inferior al 90%.

El personal médico necesita identificar rápidamente situaciones de riesgo. Desarrollar una función predicado que reciba *dos átomos* (frecuencia cardíaca y saturación de oxígeno) y determine si el paciente se encuentra en estado crítico.

**2.** Debido a la alta demanda de camas, se requiere determinar si es necesario activar un protocolo especial de atención. Dicho protocolo debe activarse cuando en las listas recibidas como parámetro se detecten al menos 4 situaciones críticas.

Como restricción para los programadores, la resolución deberá realizarse utilizando todas las funciones auxiliares que sean necesarias, pero el análisis de las listas deberá efectuarse mediante un *proceso recursivo*. La función deberá retornar la lista `(ACTIVAR PROTOCOLO)` o `(MONITOREO NORMAL)` según corresponda.

**3.** El tablero central de la unidad posee indicadores luminosos para que el personal pueda identificar rápidamente los momentos de riesgo sin analizar valores numéricos.
Desarrollar una función que reciba ambas listas y, utilizando `MAPCAR`, retorne una lista donde:
* 1 representa una situación crítica.
* 0 representa una situación normal.

**4.** Para verificar si las funciones desarrolladas pueden incorporarse al sistema hospitalario, desarrollar una función que solicite al operador el ingreso de las dos listas y pruebe las funciones implementadas. Realizar todas las validaciones necesarias para contemplar el peor escenario posible de ingreso de datos.