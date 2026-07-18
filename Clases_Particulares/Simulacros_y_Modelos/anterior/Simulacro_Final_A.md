# Simulacro de Parcial A (Para Semana 3)
**Tema:** Gestión de Estaciones de Carga para Vehículos Eléctricos.

Una red de transporte ecológico utiliza estaciones de carga. Cada estación envía una lista con sus datos:
`(ID_ESTACION  (CAPACIDAD_MIN CAPACIDAD_MAX)  AUTOS_CARGANDO  PRECIO_KWH  KWH_DISPONIBLE)`

**1.-** Desarrollar una función que calcule la recaudación potencial actual de una estación si cobrara toda su energía disponible: `(PRECIO_KWH * KWH_DISPONIBLE)`.

**2.-** Desarrollar una función predicado que reciba la lista de una estación y determine si la cantidad de `AUTOS_CARGANDO` está dentro del límite permitido `(CAPACIDAD_MIN CAPACIDAD_MAX)`.

**3.-** Desarrollar una función que reciba los datos de la estación y retorne:
- `(ID_ESTACION SOBRECARGA)` si los autos cargando superan la capacidad máxima.
- `(ID_ESTACION NORMAL)` si están dentro del límite.
- `(ID_ESTACION INACTIVA)` si los autos cargando son menores a la capacidad mínima.

**4.-** El sistema recibe una lista de listas con los datos de todas las estaciones de la ciudad.
Desarrolle un bloque que pida los datos por consola y:
- (A) Devuelva una lista con el estado de todas las estaciones utilizando **MAPCAR**.
- (B) Retorne la recaudación potencial total de toda la red utilizando **Recursividad**.
- (C) Verifique si existe al menos una estación en `SOBRECARGA`.
