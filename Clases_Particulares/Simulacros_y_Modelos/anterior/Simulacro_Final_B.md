# Simulacro de Parcial B (Para Semana 3)
**Tema:** Gestión de Misiones Espaciales

La agencia espacial monitorea satélites en órbita. Cada satélite envía una lista con sus datos de la siguiente manera:
`(ID_SATELITE CAPACIDAD_DATOS (TEMPERATURA_ACTUAL TEMPERATURA_MIN TEMPERATURA_MAX) CONSUMO_ENERGIA)`

*(Notar que el orden de Min y Max está como Min y Max en la tupla térmica, pero los datos generales están en otro orden, hay que tener cuidado con CADDR, CADDDR)*.

**1.-** Desarrollar una función que calcule la eficiencia de la transmisión. 
*( eficiencia = CAPACIDAD_DATOS / CONSUMO_ENERGIA )*

**2.-** Desarrollar una función predicado que determine si el satélite está en peligro de sobrecalentamiento. Esto ocurre cuando `TEMPERATURA_ACTUAL` es estrictamente mayor que `TEMPERATURA_MAX`.

**3.-** Desarrollar una función que retorne:
- `(ID_SATELITE CRITICO)` si la temperatura actual está fuera de rango operativo `(TEMPERATURA_MIN TEMPERATURA_MAX)`.
- `(ID_SATELITE OPERATIVO)` si está dentro del rango.

**4.-** A partir de una lista general que agrupa a todos los satélites (lista de listas):
Desarrolle un bloque que la pida por consola y:
- (A) Devuelva una lista con el identificador y la eficiencia de transmisión de cada uno utilizando **MAPCAR**.
- (B) Retorne el consumo de energía total de todos los satélites utilizando un proceso **recursivo**.
- (C) Verifique si existe algún satélite en peligro de sobrecalentamiento (utilizando las funciones auxiliares previas).
