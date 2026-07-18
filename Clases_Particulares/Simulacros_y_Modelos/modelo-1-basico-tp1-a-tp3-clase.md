# Modelo 1 — Básico (TP1 a TP3) — Para hacer en clase
**Programación Funcional — Lenguaje LISP**

**Alcance:** solo temas de TP1, TP2 y TP3. **No se permite usar recursividad ni MAPCAR** (son de TP4 y TP5, todavía no vistos). Todo se resuelve con `defun`, `if`/`cond`, `car`/`cdr`/`cons`/`list`/`append` y las funciones aritméticas básicas.

## Importante: se descontarán puntos por
- No utilización de variables locales cuando sea necesario.
- IF anidados con COND o viceversa.
- Falta de validación en los casos que sea necesario.
- Falta de mensajes alusivos en el ingreso de datos.
- Uso excesivo o innecesario de variables auxiliares.

## Puntaje

| Ejercicio | Puntos |
|---|---|
| 1a | 1,5 |
| 1b | 1,0 |
| 2a | 1,0 |
| 2b | 1,0 |
| 2c | 1,0 |
| 3a | 1,5 |
| 3b | 2,0 |
| 3c | 1,0 |

---

## Ejercicio Nº 1

**a)** Indicar si la conversión a Lisp de las siguientes expresiones matemáticas son Verdadero o Falso.

| Expresión matemática | Expresión Lisp | Respuesta |
|---|---|---|
| √(a+b) − 2c³ | `(- (sqrt (+ a b)) (* 2 (expt c 3)))` | |
| 4x² + 3x − 7 | `(+ (* 4 (expt x 2)) (* 3 x) 7)` | |
| 5(m−n)² + 8 | `(+ (* 5 (expt (- m n) 2)) 8)` | |

**b)** De la o las expresiones Lisp que resultaron **verdadero**, elegí una e indicá cuántos elementos tiene a nivel superior (sin contar los paréntesis) y cuáles son.

---

## Ejercicio Nº 2

Analice la siguiente función:

```lisp
(defun revisar (a b)
  (cond
    ((and (numberp a) (listp b)) (cons a b))
    ((and (listp a) (atom b)) (append a (list b)))
    ((and (numberp a) (numberp b)) (list a b))
  )
)
```

Determine el resultado que arrojaría si se evalúa la misma con los siguientes parámetros:

a. `(revisar 5 '(2 8 1))` — Rta: ______

b. `(revisar '(1 2) (+ 3 4))` — Rta: ______

c. `(revisar (- 10 4) (* 2 3))` — Rta: ______

---

## Ejercicio Nº 3 — Vivero "El Brote Verde"

Para fertilizar 1 metro cuadrado de almácigo se necesitan: 80 gr de fertilizante, 40 ml de fungicida y 0.15 litros de agua.

**a)** Definir una función predicado, la que a partir de la cantidad de metros cuadrados que se desean fertilizar, dato que será ingresado por el operador, determine si alcanzan 2 kg de fertilizante, 1 litro de fungicida y 8 litros de agua. Recordar que 1 gramo = 0.001 kg y 1 ml = 0.001 litro.

**b)** Definir una función, la que a partir de la cantidad de m² que se desea fertilizar, la que será ingresada por parámetro, devuelva una lista donde:
- El primer elemento será la cantidad de m² a fertilizar.
- El resto de los elementos serán la cantidad de cada material necesario, expresado el fertilizante en kg, el fungicida en litros y el agua en litros.

**c)** Sabiendo que los almácigos tienen un ancho fijo de 1,2 metros, definir una función que permita calcular el largo del almácigo. Dicha función debe recibir como parámetro el área del almácigo. Recordar que área = ancho * largo.
