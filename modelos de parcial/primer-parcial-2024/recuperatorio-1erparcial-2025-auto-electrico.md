# Recuperatorio 1er Parcial – Programación Funcional (24/5/2025) — Tema (auto eléctrico)

> Transcripción de examen manuscrito. Se omiten los datos personales del alumno. El número de Tema no es legible en la foto (la parte superior de la hoja quedó fuera de encuadre); por el contenido, es una variante distinta a la de "pintura" (Tema 3) y a la de "alfajores".

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
| √x − 4x³ + 8 | `(- (sqrt x) (+ (* 4 (expt x 2)) 8))` | *(no visible en la foto)* |
| 3x² + 2x + 1 | `(+ (* 3 (expt x 2)) (* 2 (+ x 1)))` | *(no visible en la foto)* |
| 3x³ − z·5 + 9 | `(+ (- (* 3 (expt x 3)) (* z 5)) 9)` | *(no visible en la foto)* |

**b.** Determinar la cantidad de elementos que posee la o las expresiones Lisp que hayan resultado verdadero e indique cuáles son.

## Ejercicio Nº 2

Analice la siguiente función:

```lisp
(defun analizo (X Y)
  (cond
    ((or (integerp X) (integerp Y)) (list X Y))
    ((not (and (numberp X) (numberp Y))) (append X Y))
    ((and (atom X) (consp Y)) (cons X Y))
  )
)
```

Determine el resultado que arrojaría si evalúo la misma con los siguientes parámetros:

a. `(analizo (- 10 (* 7 2)) (cadr '(* 6 (/ 9 3))))` — Rta: ______

b. `(analizo '(- 10 (* 7 2)) (member 6 '(* 6 (/ 9 3))))` — Rta: ______

c. `(analizo (- 10 (* 7 2)) (last '(* 6 5 (/ 9 3))))` — Rta: ______

## Ejercicio Nº 3

Para dar mantenimiento a 1 auto eléctrico se necesitan: 50 ml de aceite dieléctrico, 20 gr de pasta térmica, 1 filtro de aire.

**a)** Definir una función predicado, la que a partir de la cantidad de vehículos eléctricos que deben ser reparados, dato que será ingresado por el operador, determine si alcanzan 1 litro de aceite dieléctrico y 500gr de pasta térmica y 20 filtros de aire. Recordar que 1 ml = 0.001 litro.

**b)** Definir una función, la que a partir de la cantidad de vehículos eléctricos que se desea dar mantenimiento, la que será ingresadas por parámetro, devuelva una lista donde:
- El primer elemento será la cantidad de vehículos eléctricos.
- El resto de los elementos serán la cantidad de cada uno de los materiales que se necesitarán expresados el aceite en litros y la pasta en gramos.

**c)** Sabiendo que la autonomía de un auto eléctrico depende de la velocidad, definir una función que permita calcular la autonomía para una velocidad x que ingresa por parámetro. Siendo la fórmula: −0,1x² + 6x
