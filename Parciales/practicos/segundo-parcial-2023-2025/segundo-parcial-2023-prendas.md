# Segundo Examen Parcial – Programación Funcional (2023)

> Nota: se normalizó una pequeña errata de tipeo del PDF original ("Para la prenda no haya en stock" → "Para la prenda que no haya en stock").

## Importante: se descontarán puntos por
- No utilización de variables locales cuando sea necesario.
- IF anidados con COND o viceversa.
- Falta de validación en los casos que sea necesario.

En una única lista se tiene registrado el precio de las prendas de vestir de invierno.

La información en la lista se presenta de la siguiente manera:

```
((prenda1 precio1) (prenda2 precio2) …)
```

Donde prenda1, prenda2, … será el nombre de cada prenda y precio1, precio2, … será el precio que le corresponde a la prenda. Para la prenda que no haya en stock, tendrá el valor 0 en precio.

## Ejercicio Nº 1 — 1.5 Ptos
Desarrollar una función, la que permita que el operador ingrese la lista y llame a las distintas funciones que se solicitan.

## Ejercicio Nº 2 — 2.5 Ptos
Desarrollar una función, la que recibirá como parámetro la lista ingresada en el punto 1; y permita obtener el promedio de los precios de las prendas de las que hay stock.

## Ejercicio Nº 3 — 2 Ptos
Desarrollar una función; la que recibirá como parámetro la lista ingresada en el punto 1; la cual debe devolver una nueva lista formada solamente por los nombres de las prendas cuyo precio sea mayor a los 3000 pesos.

## Ejercicio Nº 4 — 2.5 Ptos
Desarrollar una función; utilizando mapcar, la que recibirá como parámetro la lista ingresada en el punto 1, la cual debe devolver una nueva lista conteniendo sublistas. Cada sublista estará formada por el precio de la prenda y un mensaje.
- Para los precios de la lista iguales a 0, se formará una sublista conteniendo el precio y el mensaje "sin-stock".
- Para los precios de la lista menores o iguales a 1000, se formará una sublista conteniendo el precio y el mensaje "barato".
- Para los precios de la lista mayores a 1000, se formará una sublista conteniendo el precio y el mensaje "caro".

## Ejercicio Nº 5 — 1.5 Ptos
Definir una función utilizando mapcar, la que a partir de una lista ingresada como parámetro, devuelva una nueva lista cuyos elementos sean el resultado de evaluar uno a uno cada prenda, determinando si la misma posee o no stock. Recordar que una prenda no posee stock si su precio es 0.
