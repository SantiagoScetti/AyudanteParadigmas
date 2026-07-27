# Modelo 2 — Recursividad y MAPCAR — Para hacer en clase
**Programación Funcional — Lenguaje LISP**

**Alcance:** foco en TP4 (recursividad) y TP5 (MAPCAR).

### Ningún punto te dice qué herramienta usar
A diferencia de las prácticas anteriores, acá **no vas a encontrar la palabra "recursividad" ni "MAPCAR" en las consignas**. Decidir cuál corresponde en cada punto es parte del ejercicio.
Antes de escribir una sola línea de código, escribí al lado de cada punto **qué elegiste y por qué**. Si no podés justificarlo en una frase, todavía no entendiste el punto.


Un taller mecánico registra las reparaciones realizadas en una lista formada por sublistas, donde cada sublista posee **tres** elementos:
- El primer elemento es el costo de la reparación (en pesos).
- El segundo elemento es el tiempo insumido (en horas).
- El tercer elemento es la cantidad de repuestos utilizados en esa reparación.

Se define el **costo por hora** de una reparación como su costo dividido por el tiempo insumido.

**a)** Desarrollar una función predicado, la que a partir de la lista y una cantidad de horas ingresadas ambas por el operador, determine si **todas** las reparaciones registradas tuvieron un tiempo menor o igual a la cantidad de horas ingresada.

**b)** Desarrollar una función, la que a partir de la lista y un valor de costo, ambos ingresados como parámetros, determine la cantidad de reparaciones cuyo costo supera el valor ingresado.

**c)** Desarrollar una función que permita determinar la cantidad total de reparaciones registradas en la lista.

**d)** Desarrollar una función, la cual a partir de la lista ingresada como parámetro, devuelva una lista formada solamente por la cantidad de repuestos utilizados en cada reparación.

**e)** Definir una función, la cual a partir de la lista ingresada como parámetro, devuelva una nueva lista formada solamente por las sublistas de reparaciones cuyo costo sea mayor a $50.000.

**f)** Definir una función, la que a partir de la lista que será ingresada como parámetro, devuelva una nueva lista formada por mensajes según el **costo por hora** de cada reparación:
- "eficiente", si el costo por hora es menor o igual a $10.000.
- "aceptable", si el costo por hora es mayor a $10.000 y menor o igual a $25.000.
- "costosa", si el costo por hora es mayor a $25.000.

**g)** Desarrollar una función que, a partir de la lista ingresada como parámetro, devuelva una lista de **exactamente dos elementos**: `(COSTO-TOTAL HORAS-TOTALES)`, considerando únicamente las reparaciones que utilizaron **al menos un repuesto**. Si ninguna reparación usó repuestos, debe devolver `(0 0)`. La lista debe recorrerse **una sola vez**.

**h)** Desarrollar una función que reciba como parámetros la lista de reparaciones y un **porcentaje de recargo**. La función debe devolver una nueva lista en la que cada elemento sea una sublista de la forma `(COSTO-FINAL REPUESTOS ETIQUETA)`, donde:
- `COSTO-FINAL` es el costo de la reparación con el porcentaje de recargo aplicado **únicamente si la reparación utilizó más de 2 repuestos**; en caso contrario, es el costo original sin modificar.
- `REPUESTOS` es la cantidad de repuestos utilizados.
- `ETIQUETA` es un átomo que vale `REVISAR` si el **costo por hora calculado sobre el `COSTO-FINAL`** supera los $25.000, y `OK` en caso contrario.

**i)** Desarrollar una función Menú que permita al operador ingresar las listas y valores que sean necesarios y que llame a todas las funciones que se desarrollaron en los ejercicios anteriores.

---

## Datos de prueba sugeridos

```lisp
((45000 3 0) (70000 6 4) (15000 3 2) (60000 2 5) (30000 5 0))
```

Para el punto **h)**, usar un recargo del `10` por ciento.
