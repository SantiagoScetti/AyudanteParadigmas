# Modelo 4 — Integrador con dos listas en paralelo
**Programación Funcional — Lenguaje LISP**

**Alcance:** integra todo — cálculo sobre un registro, predicado, clasificación con COND, MAPCAR, recursividad y función Menú con validación. La diferencia con los modelos anteriores es que acá hay **dos listas** que se recorren **a la par**: la posición 1 de una se corresponde con la posición 1 de la otra.

## Ningún punto te dice qué herramienta usar
En las consignas **no vas a encontrar la palabra "recursividad" ni "MAPCAR"**. Decidir cuál corresponde en cada punto es parte del ejercicio. Antes de escribir código, anotá al lado de cada punto **qué elegiste y por qué**.

---

Una empresa de logística controla los viajes de su flota de camiones. Cada viaje se registra con la siguiente estructura:

`(ID_CAMION (KM_INICIAL KM_FINAL) LITROS_CARGADOS CARGA_KG)`

Donde:
- **`ID_CAMION`** es el identificador del camión.
- **`(KM_INICIAL KM_FINAL)`** son las lecturas del odómetro al salir y al llegar.
- **`LITROS_CARGADOS`** son los litros de combustible cargados para ese viaje.
- **`CARGA_KG`** son los kilos de mercadería transportados.

Se define el **consumo** de un viaje como los litros gastados cada 100 kilómetros:

`consumo = ( LITROS_CARGADOS / (KM_FINAL - KM_INICIAL) ) * 100`

---

**1.-** Desarrollar una función que, a partir de los datos de un viaje, calcule su **consumo**. *(1 p)*

**2.-** Desarrollar una función predicado que, a partir de los datos de un viaje, determine si fue un viaje **eficiente**, es decir, si su consumo es menor o igual a 20 litros cada 100 km. *(1 p)*

**3.-** Definir una función que, a partir de los datos de un viaje, devuelva: *(1,25 p)*
- `(ID_CAMION ECONOMICO)`, si el consumo es menor o igual a 15.
- `(ID_CAMION NORMAL)`, si el consumo es mayor a 15 y menor o igual a 25.
- `(ID_CAMION EXCESIVO)`, si el consumo es mayor a 25.

---

Hasta acá se trabajó con **un solo viaje**. La empresa tiene varios camiones, así que el sistema maneja ahora **dos listas de igual longitud**:

```lisp
VIAJES:   ( (ID_CAMION (KM_INICIAL KM_FINAL) LITROS_CARGADOS CARGA_KG)
            (ID_CAMION (KM_INICIAL KM_FINAL) LITROS_CARGADOS CARGA_KG)
            ... )

CHOFERES: ( (NOMBRE ANTIGUEDAD)
            (NOMBRE ANTIGUEDAD)
            ... )
```

El chofer que aparece en la posición 1 de la lista de choferes es el que realizó el viaje de la posición 1 de la lista de viajes, y así sucesivamente. `ANTIGUEDAD` está expresada en años.

---

**4.-** Desarrollar una función que, a partir de la lista de viajes, determine la **cantidad total de kilómetros** recorridos por toda la flota. *(1,25 p)*

**5.-** Desarrollar una función que, a partir de la lista de viajes, devuelva una nueva lista con la **identificación y la clasificación de consumo** de cada viaje. *(1,25 p)*

**6.-** Desarrollar una función que reciba **las dos listas** y devuelva una nueva lista en la que cada elemento sea una sublista de la forma `(NOMBRE ID_CAMION OBSERVACION)`, donde `OBSERVACION` vale: *(1,75 p)*
- `CAPACITAR`, si el consumo del viaje fue `EXCESIVO` y el chofer tiene menos de 2 años de antigüedad.
- `REVISAR_UNIDAD`, si el consumo del viaje fue `EXCESIVO` y el chofer tiene 2 años o más de antigüedad.
- `OK`, en cualquier otro caso.

**7.-** Desarrollar una función que reciba **las dos listas** y devuelva una nueva lista formada solamente por los **nombres de los choferes** cuyo viaje resultó `EXCESIVO`. *(1,75 p)*

**8.-** Desarrollar una función Menú que solicite al operador el ingreso de las dos listas, valide que ambas sean listas y que tengan la misma cantidad de elementos, y muestre en consola el resultado de todas las funciones desarrolladas en los puntos anteriores. *(0,75 p)*