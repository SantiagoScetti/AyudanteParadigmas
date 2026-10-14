# Recuperatorio 1er Parcial – Programación Funcional (24/5/2025) — Tema (alfajores)

> Transcripción de examen manuscrito, con respuestas ya completadas a mano en el Ejercicio 1. Se omiten los datos personales del alumno. El número de Tema no es legible en la foto (el encuadre no incluye el encabezado con el número).

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
| √x − 4x³ + y + 8 | `(- (sqrt x) (* 4 (expt x 3)) (+ y 8))` | falso |
| 3x² + 2x + 1 | `(+ (* 3 (expt x 2)) (* 2 x) 1)` | verdadero |
| 3x³ − z·5 + 9 | `(* (- (* 3 (expt x 3)) z) (+ 5 9))` | falso |

**b.** Determinar la cantidad de elementos que posee la expresión Lisp que resultó verdadero e indique cuáles son.

## Ejercicio Nº 2

Analice la siguiente función:

```lisp
(defun analizo (X Y)
  (cond
    ((and (integerp X) (integerp Y)) (list X Y))
    ((and (consp X) (atom Y)) (cons Y X))
    ((not (and (numberp X) (numberp Y))) (append X Y))
  )
)
```

Determine el resultado que arrojaría si evalúo la misma con los siguientes parámetros:

a. `(analizo '(+ 1 (* 4 2)) (cadr '(8 6 5 (/ 9 3))))` — Rta: ______

b. `(analizo (+ 1 (* 4 2)) (cadr '(8 6 5 (/ 9 3))))` — Rta: ______

c. `(analizo '(+ 1 (* 4 2)) (cdr '(8 6 5 (/ 9 3))))` — Rta: ______

## Ejercicio Nº 3

Para preparar 1 docena de alfajores se necesitan: 100 gr de harina, 35 gr de azúcar, 350 gr de dulce de leche.

**a)** Definir una función predicado, la que a partir de la cantidad de docenas que se desean hacer, la que será ingresada por el operador, determine si alcanzan 2 kilos de harina y 1 kilo de azúcar y 3 kilos de dulce de leche. Recordar que 1 gramo = 0.001 kg.

**b)** Definir una función, la que a partir de la cantidad de docenas que se desea preparar, la que será ingresadas por parámetro, devuelva una lista donde:
- El primer elemento será la cantidad de docenas que se desea preparar.
- El resto de los elementos serán la cantidad de cada uno de los ingredientes que se necesitarán expresados en kilos. Recordar que 1 gramo = 0.001 kg.

**c)** Sabiendo que 1 tapa del alfajor tiene un radio de 3 cms, definir una función que permita calcular la superficie total de masa que se necesita para 1 docena de alfajores. Recordar que el área de un círculo = Pi * radio²
