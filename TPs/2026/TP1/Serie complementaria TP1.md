# Serie complementaria N°1
**Año:** 2.026

**Objetivo:**
● Repasar y afianzar los conceptos de las estructuras básicas del lenguaje de programación y su sintaxis.

## Actividad complementaria N° 1:
Escribe la expresión equivalente en LISP para las siguientes fórmulas matemáticas:
1. `5+(3×4)5+(3×4)`
2. `(10−2)/(3+1)(10−2)/(3+1)`
3. `x^2 + 2x + 1x` (Asume que existe la función `(expt x 2)` para `x^2`)
4. `(a + b) / (c - d)`
5. `(b x h) / 2`
6. `√(a^2 + b^2)`

## Actividad complementaria N° 2:
Sabiendo que LISP evaluará la expresión de ejemplo: `(+ (* 2 3) (- 10 5))` en el siguiente orden:
1. Primero se evalúa `(* 2 3)` → 6.
2. Luego `(- 10 5)` → 5.
3. Finalmente `(+ 6 5)` → 11.

Determina el resultado numérico de las siguientes expresiones de LISP sin utilizar la computadora y haciendo la reducción paso por paso hasta llegar al resultado final:
1. `(+ (* 2 3) (- 10 5))`
2. `(/ (* 4 5) (+ 2 3))`
3. `(- 100 (* 5 (+ 10 2)))`

## Actividad complementaria N° 3:
Intente pensar: ¿Qué valores se devuelven al evaluar estas expresiones? y luego compruebe su respuesta en su computadora.
1. `(+ 3 5)`
2. `(3 + 5)`
3. `(+ 3 (5 6))`

## Actividad complementaria N° 4 (Situaciones Problemáticas)
Para los siguientes ejercicios escriba la expresión algebraica que los resuelve y luego su versión para Common Lisp:

1. *El Costo del Cine*
Un grupo de amigos va al cine. Compran n entradas a 8 dólares cada una y 3 combos de palomitas a 5 dólares cada uno. El total se divide equitativamente entre los n amigos. ¿Cuánto debe pagar cada uno?
*Expresión algebraica:* `(8n + (3 * 5)) / n`

2. *Conversión de Temperatura*
Un científico necesita convertir una lectura de temperatura de grados Fahrenheit (F) a grados Celsius (C). La regla es: resta 32 al valor en Fahrenheit, multiplica el resultado por 5 y finalmente divide entre 9.
*Expresión Algebraica:* `(F − 32) * (5 / 9)`

3. *Interés Compuesto Simple*
Calcula el monto final (M) de una inversión inicial (P) tras un año, con una tasa de interés anual (r) expresada en decimal, usando la fórmula: `M=P(1+r)`
*Expresión Algebraica:* `P(1+r)`

4. *Caída Libre*
Un objeto se deja caer desde una altura inicial h0. La posición final h después de un tiempo t está dada por la gravedad g (9.8 m/s).
*Expresión algebraica:* `h0 − ½gt^2`

5. *El Rectángulo Áureo*
Tienes un rectángulo cuyo largo es L y su ancho es W. Quieres calcular el perímetro, pero luego restarle el área para un experimento geométrico extraño.
*Pista:* Perímetro = `2(L+W)` ; Área = `L*W`
*Expresión Algebraica:* `(2⋅(L+W)) − (L⋅W)`

6. *Promedio Ponderado*
Un estudiante tiene una nota de examen (E) que vale el 70% y una nota de tareas (T) que vale el 30%. Escribe la expresión para su nota final.
