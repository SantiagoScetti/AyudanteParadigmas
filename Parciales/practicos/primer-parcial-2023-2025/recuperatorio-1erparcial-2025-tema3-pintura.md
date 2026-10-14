# Recuperatorio 1er Parcial – Programación Funcional (24/5/2025) — Tema 3

> Transcripción de examen manuscrito. Se omiten los datos personales del alumno (nombre/DNI), que ya estaban tapados en la foto original.

## Importante: se descontarán puntos por
- No utilización de variables locales cuando sea necesario.
- IF anidados con COND o viceversa.
- Falta de validación en los casos que sea necesario.
- Falta de mensajes alusivos en el ingreso de datos.
- Uso excesivo o innecesario de variables auxiliares.

## Puntaje

| Ejercicio | Puntos | Ejercicio | Puntos |
|---|---|---|---|
| 1a | 1,50 | 2c | 1,00 |
| 1b | 0,50 | 3a | 2,00 |
| 2a | 1,00 | 3b | 2,00 |
| 2b | 1,00 | 3c | 1,00 |

## Ejercicio Nº 1

**a.** Indicar si la conversión a Lisp de las siguientes expresiones matemáticas son Verdadero o Falso.

| Expresión matemática | Expresión Lisp | Respuesta |
|---|---|---|
| √x − 4x³ + y + 8 | `((- (sqrt x) (* 4 (expt x 3))) (+ y 8))` | *(no visible en la foto)* |
| 3x³ − z·5 − 9 | `(- (* 3 (expt x 3)) (* z 5) 9)` | *(no visible en la foto)* |
| 3x² + 2x + 1 | `(+ (* 3 (expt x 2)) ) (+ 2 x) 1)` | *(no visible en la foto)* |

> Nota: la expresión Lisp de la tercera fila está transcripta tal cual figura en el original, incluyendo un paréntesis de cierre de más (posible error de sintaxis a detectar por el alumno como parte del ejercicio).

**b.** Determinar la cantidad de elementos que posee la o las expresiones Lisp que hayan resultado verdadero e indique cuáles son.

## Ejercicio Nº 2

Analice la siguiente función:

```lisp
(defun analizo (X Y)
  (cond
    ((and (listp X) (atom Y)) (cons Y X))
    ((and (not (consp X)) (numberp Y)) (list X Y))
    ((and (listp X) (listp Y)) (append X Y))
  )
)
```

Determine el resultado que arrojaría si evalúo la misma con los siguientes parámetros:

a. `(analizo '(- ( / 20 2) 5) (caddr '(- 6 (/ 9 3))))` — Rta: ______

b. `(analizo (- ( / 20 2) 5) (cadr '(- 6 (/ 9 3))))` — Rta: ______

c. `(analizo '(- ( / 20 2) 5) (- 6 5 (/ 9 3)))` — Rta: ______

## Ejercicio Nº 3

Para pintar 1 metro cuadrado de pared se necesitan: 150 ml de pintura, 50 gr de masilla y 0.2 metros de cinta de pintor.

**a)** Definir una función predicado, la que a partir de la cantidad de metros cuadrados que se desean pintar, dato que será ingresado por el operador, determine si alcanzan 1 litro de pintura, 200 grs de masilla y 5 metros de cinta de pintor. Recordar que 1 ml = 0.001 litro.

**b)** Definir una función, la que a partir de la cantidad de m² que se desea pintar, la que será ingresada por parámetro, devuelva una lista donde:
- El primer elemento será la cantidad de m² que se desea pintar.
- El resto de los elementos serán la cantidad de cada uno de los materiales que se necesitarán expresada la pintura en litros, la masilla en gramos y la cinta en metros.

**c)** Sabiendo que las paredes son de 2,5 mts de altura, definir una función que permita calcular el ancho de la misma. Dicha función debe recibir como parámetro el área de la pared. Recordar que la fórmula del área = base * altura.

> Nota: en el enunciado original del punto b) el texto impreso decía "docenas" / "preparar" (quedó de la plantilla del ejercicio de alfajores) y estaba corregido a mano a "m²" / "pintar". Se transcribe aquí ya con la corrección aplicada.
