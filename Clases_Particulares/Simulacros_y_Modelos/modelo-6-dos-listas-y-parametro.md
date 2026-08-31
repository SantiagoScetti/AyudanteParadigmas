# Modelo 6 — Integrador con dos listas en paralelo y un parámetro suelto
**Programación Funcional — Lenguaje LISP**

**Alcance:** integra todo — cálculo sobre un registro, predicado, clasificación con `cond`, MAPCAR, recursividad y función Menú con validación. Mantiene el formato del Modelo 4 (**dos listas que se recorren a la par**) y suma tres cosas que no aparecieron antes:

- la **sublista interna tiene 3 elementos** (hasta ahora tenía 2),
- la **segunda lista es plana**: son átomos sueltos, no sublistas,
- además de las dos listas viaja un **dato suelto** como parámetro.

## Ningún punto te dice qué herramienta usar
En las consignas **no vas a encontrar la palabra "recursividad" ni "MAPCAR"**. Decidir cuál corresponde en cada punto es parte del ejercicio. Antes de escribir código, anotá al lado de cada punto **qué elegiste y por qué**.

## Importante: se descontarán puntos por
- No utilización de variables locales cuando sea necesario.
- IF anidados con COND o viceversa.
- Falta de validación en los casos que sea necesario.
- Falta de mensajes alusivos en el ingreso de datos.
- Uso excesivo o innecesario de variables auxiliares.

---

La estación de servicio **"Ruta 12"** controla lo que vende cada uno de sus surtidores durante el día. Cada surtidor se registra con la siguiente estructura:

`(ID_SURTIDOR TIPO (TURNO_1 TURNO_2 TURNO_3) PRECIO_LITRO)`

Donde:
- **`ID_SURTIDOR`** es el identificador del surtidor.
- **`TIPO`** es el combustible que despacha: `NAFTA` o `GASOIL`.
- **`(TURNO_1 TURNO_2 TURNO_3)`** son los litros vendidos en los turnos de mañana, tarde y noche, respectivamente.
- **`PRECIO_LITRO`** es el precio de venta por litro.

Se definen:

`litros_del_dia = TURNO_1 + TURNO_2 + TURNO_3`

`recaudacion = litros_del_dia * PRECIO_LITRO`

---

**1.-** Desarrollar una función que, a partir de los datos de un surtidor, calcule los **litros vendidos en el día**. *(0,75 p)*

**2.-** Desarrollar una función predicado que, a partir de los datos de un surtidor y de un **objetivo diario de litros** que se recibe como parámetro, determine si ese surtidor **alcanzó o superó** el objetivo. *(1 p)*

**3.-** Definir una función que, a partir de los datos de un surtidor, devuelva: *(1 p)*
- `(ID_SURTIDOR BAJA)`, si los litros del día son menores o iguales a 1500.
- `(ID_SURTIDOR MEDIA)`, si los litros del día son mayores a 1500 y menores o iguales a 3000.
- `(ID_SURTIDOR ALTA)`, si los litros del día son mayores a 3000.

---

Hasta acá se trabajó con **un solo surtidor**. La estación tiene varios, así que el sistema maneja ahora **dos listas de igual longitud** y **un dato suelto**:

```lisp
SURTIDORES: ( (ID_SURTIDOR TIPO (TURNO_1 TURNO_2 TURNO_3) PRECIO_LITRO)
              (ID_SURTIDOR TIPO (TURNO_1 TURNO_2 TURNO_3) PRECIO_LITRO)
              ... )

MEDICIONES: ( LITROS_MEDIDOS  LITROS_MEDIDOS  LITROS_MEDIDOS  ... )
```

**Atención:** `MEDICIONES` **no** es una lista de sublistas. Es una lista de **números sueltos**: el número de la posición 1 corresponde al surtidor de la posición 1, el de la posición 2 al surtidor de la posición 2, y así sucesivamente. `LITROS_MEDIDOS` son los litros que efectivamente salieron del tanque según el medidor físico.

Además, el sistema trabaja con el **`OBJETIVO`** diario de litros por surtidor, que es **un único número** y no forma parte de ninguna de las dos listas.

Se define la **diferencia de control** de un surtidor como:

`diferencia = LITROS_MEDIDOS - litros_del_dia`

---

**4.-** Desarrollar una función que, a partir de la lista de surtidores, determine la **recaudación total** de toda la estación. *(1,25 p)*

**5.-** Desarrollar una función que, a partir de la lista de surtidores y del **objetivo** recibido como parámetro, determine la **cantidad de surtidores** que alcanzaron o superaron ese objetivo. *(1 p)*

**6.-** Desarrollar una función que, a partir de la lista de surtidores, devuelva una nueva lista con la **identificación y el nivel de venta** de cada surtidor. *(1 p)*

**7.-** Desarrollar una función que reciba **las dos listas** y devuelva una nueva lista en la que cada elemento sea una sublista de la forma `(ID_SURTIDOR DIFERENCIA ESTADO)`, donde `ESTADO` vale: *(1,75 p)*
- `FALTANTE`, si la diferencia es mayor a 20 litros (salió del tanque más combustible del que se facturó).
- `SOBRANTE`, si la diferencia es menor a -20 litros.
- `OK`, en cualquier otro caso.

**8.-** Desarrollar una función que reciba **las dos listas** y devuelva una nueva lista formada solamente por los **identificadores de los surtidores** cuyo control haya dado `FALTANTE`. *(1,75 p)*

**9.-** Desarrollar una función Menú que solicite al operador el ingreso de las dos listas y del objetivo, valide que ambas sean listas, que tengan la misma cantidad de elementos y que el objetivo sea numérico, y muestre en consola el resultado de todas las funciones desarrolladas en los puntos anteriores. *(0,5 p)*

---

## Datos para probar

```lisp
(setq surtidores '((S01 NAFTA  (900 1200 600)   1150)
                   (S02 GASOIL (1500 1300 900)  1080)
                   (S03 NAFTA  (400 500 300)    1150)
                   (S04 GASOIL (1100 1000 800)  1080)
                   (S05 NAFTA  (1600 1400 1100) 1150)))

(setq mediciones '(2710 3760 1150 2895 4135))

(setq objetivo 2500)
```
