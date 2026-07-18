# Modelo 1 — Básico (TP1 a TP3) — Para llevar de tarea
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
| 3(p+q) − r² | `(- (* 3 (+ p q)) (expt r 2))` | |
| √y + 2z − 9 | `(+ (sqrt y) (* 2 z) 9)` | |
| 6(a−b)² + 4 | `(+ (* 6 (expt (- a b) 2)) 4)` | |

**b)** De la o las expresiones Lisp que resultaron **verdadero**, elegí una e indicá cuántos elementos tiene a nivel superior (sin contar los paréntesis) y cuáles son.

---

## Ejercicio Nº 2

Analice la siguiente función:

```lisp
(defun clasificar (x y)
  (cond
    ((and (listp x) (numberp y)) (list y x))
    ((and (numberp x) (atom y)) (cons x (list y)))
    ((and (listp x) (listp y)) (append y x))
  )
)
```

Determine el resultado que arrojaría si se evalúa la misma con los siguientes parámetros:

a. `(clasificar '(4 9) (- 20 15))` — Rta: ______

b. `(clasificar (+ 2 3) 'hola)` — Rta: ______

c. `(clasificar '(1 2) '(3 4))` — Rta: ______

---

## Ejercicio Nº 3 — Ferretería "Todo Tornillo"

Para instalar 1 metro lineal de estantería se necesitan: 120 gr de tornillos, 30 ml de adhesivo y 0.05 litros de barniz.

**a)** Definir una función predicado, la que a partir de la cantidad de metros lineales que se desean instalar, dato que será ingresado por el operador, determine si alcanzan 3 kg de tornillos, 1,5 litros de adhesivo y 4 litros de barniz. Recordar que 1 gramo = 0.001 kg y 1 ml = 0.001 litro.

**b)** Definir una función, la que a partir de la cantidad de metros lineales que se desea instalar, la que será ingresada por parámetro, devuelva una lista donde:
- El primer elemento será la cantidad de metros lineales a instalar.
- El resto de los elementos serán la cantidad de cada material necesario, expresado los tornillos en kg, el adhesivo en litros y el barniz en litros.

**c)** Sabiendo que cada estante individual mide 0,9 metros, definir una función que, a partir de la cantidad de metros lineales ingresada como parámetro, calcule la cantidad de estantes necesarios. Tener en cuenta que no se pueden comprar estantes parciales (si sobra una fracción, se necesita un estante entero más).
