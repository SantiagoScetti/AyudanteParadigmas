# Simulacro Integradora 1 (Para Semana 1/2)
**Tema:** Sistema de Calidad en Fábrica de Autopartes

Una fábrica automotriz utiliza sensores para verificar el peso de cada lote de piezas. Los sensores envían la siguiente información en forma de lista:
`(ID_LOTE (PESO_MINIMO PESO_MAXIMO) PESO_ACTUAL PRECIO_UNITARIO)`

**1.-** Desarrolle una función que reciba los datos de un lote y calcule el desvío en el peso con respecto al mínimo permitido. `Desvío = PESO_ACTUAL - PESO_MINIMO`. (Si da negativo, la pieza es defectuosa).

**2.-** Desarrolle una función predicado que evalúe si el `PESO_ACTUAL` de las piezas de un lote está dentro del rango seguro para su comercialización `(PESO_MINIMO PESO_MAXIMO)`.

**3.-** Desarrolle una función que reciba los datos del lote y retorne una lista descriptiva:
- `(ID_LOTE ACEPTADO)`: Si el peso está en rango.
- `(ID_LOTE PESO_BAJO)`: Si el peso es menor al mínimo.
- `(ID_LOTE PESO_ALTO)`: Si el peso es mayor al máximo.

**4.-** Para evaluar si el sistema reconoce listas, desarrollar una función que evalúe si el tercer elemento de la lista del lote es un átomo numérico o no. 
