# ANEXO — TEORÍA Y TRAZADO DE FUNCIONES
### Práctica extra para el extraordinario

Dos cosas que la cátedra toma además del código:
1. **Trazar funciones** — te dan una función ya escrita y tenés que decir **qué devuelve** con ciertos parámetros (Ejercicio 1 del Primer Parcial 2023).
2. **Cuestionario teórico** — conceptos de paradigmas, LISP, cons, predicados, etc.

> Las respuestas están al final, en la sección **SOLUCIONES**. Resolvé primero a mano.

---

## PARTE 1 — Trazado de funciones (¿qué devuelve?)

### Ejercicio 1.1
```lisp
(defun clasifica (x y)
    (cond
        ((and (numberp x) (numberp y)) (+ x y))
        ((and (listp x) (numberp y))   (cons y x))
        ((and (numberp x) (listp y))   (append y (list x)))
        (T (list x y))))
```
Indicá el resultado de cada evaluación **y** decí cuántos elementos tiene el resultado y si cada uno es átomo o lista:

a) `(clasifica 4 6)`
b) `(clasifica '(1 2) 9)`
c) `(clasifica 7 '(3 4))`
d) `(clasifica 'a 'b)`
e) `(clasifica (car '(8 2)) (cdr '(8 2)))`

---

### Ejercicio 1.2
Recordá cómo evalúa LISP estas funciones. ¿Qué devuelve cada una?

a) `(car '(+ 10 20 30))`
b) `(cdr '(a b c))`
c) `(cadr '(10 (20 30) 40))`
d) `(caddr '(10 (20 30) 40))`
e) `(last '(5 15 25))`
f) `(append '(1 2) '(3 4))`
g) `(cons '(1 2) '(3 4))`
h) `(list '(1 2) '(3 4))`
i) `(member 3 '(1 2 3 4 5))`
j) `(reverse '(1 2 3))`

> **Ojo con la diferencia clásica** entre `cons`, `list` y `append` (g, h, f): es lo que más se confunde.

---

### Ejercicio 1.3
```lisp
(defun misterio (lista)
    (cond
        ((null lista) 0)
        ((evenp (car lista)) (+ (car lista) (misterio (cdr lista))))
        (T (misterio (cdr lista)))))
```
a) ¿Qué hace la función en una frase?
b) `(misterio '(1 2 3 4 5 6))` = ?
c) `(misterio '(1 3 5))` = ?
d) `(misterio '())` = ?

---

### Ejercicio 1.4 — Trazá estos MAPCAR
¿Qué devuelve cada uno? (Acordate: con varias listas, `mapcar` toma un elemento de cada una y se **detiene en la más corta**.)

a) `(mapcar 'atom '(a (b) 3 (c d)))`
b) `(mapcar 'listp '(a (b) 3 (c d)))`
c) `(mapcar '+ '(1 2 3) '(10 20 30))`
d) `(mapcar '> '(5 8 3) '(4 9 2))`
e) `(mapcar 'list '(a b c))`
f) `(mapcar 'length '((1 1) () (8 8 8)))`
g) `(mapcar '- '(10 20 30) '(1 2))`   *(ojo: distinto largo)*

---

### Ejercicio 1.5 — Trazá estas LAMBDA
*(Gotcha clásico: un `if` **sin** rama "else" devuelve `NIL` cuando la condición es falsa.)*

a) `((lambda (x) (if (> (car x) 0) 'POSITIVO)) '(5 6 7))`
b) `((lambda (x) (if (> (car x) 0) 'POSITIVO)) '(-5 6 7))`
c) `((lambda (a) (reverse (cdr a))) '((2 3 4) a b c))`
d) `((lambda (x) (if (and (numberp (car x)) (evenp (car x))) (+ 10 (car x)) 0)) '(7 6 7))`

---

## PARTE 2 — Cuestionario teórico

Marcá la opción correcta (o V/F).

**1.** "Esta programación se basa en un subconjunto del cálculo de predicados, con sentencias conocidas como cláusulas de Horn." Corresponde al paradigma:
a) Imperativo · b) Procedimental · c) Funcional · d) Lógico · e) Ninguna

**2.** (V/F) En el paradigma **imperativo** se describe *qué* se quiere resolver, y en el **declarativo** se describe *paso a paso* cómo resolverlo.

**3.** Un **predicado** es una función que devuelve:
a) Otra función · b) Una lista · c) Un string · d) Un valor booleano · e) Ninguna

**4.** Una **lista punteada** es una lista donde:
a) Hay varios puntos · b) Está vacía · c) El `cdr` de un cons apunta a otra lista · d) El `cdr` de un cons apunta a un átomo · e) Ninguna

**5.** (V/F) Una función **destructiva** es aquella que manipula los valores dados como parámetros pero **no** modifica los valores de los parámetros.

**6.** (V/F) Las **operaciones aritméticas** modifican el valor de sus argumentos.

**7.** El ciclo del **Lisp Listener** (REPL) es:
a) Read → Eval → Print · b) Print → Eval → Read · c) Eval → Read → Print · d) Read → Print → Eval

**8.** (V/F) Los únicos fundamentos de control de LISP puro son la **recursividad** y los **condicionales**.

**9.** Para recorrer **una** lista transformando cada elemento, la función propia de LISP recomendada es:
a) `setq` · b) `mapcar` · c) `nconc` · d) `read`

**10.** Según las reglas de estilo de la cátedra, ¿cuál es la alternativa **no destructiva** correcta?
a) `nconc` en vez de `append` · b) `delete` en vez de `remove` · c) `reverse` en vez de `nreverse` · d) Ninguna

**11.** (V/F) Está permitido y recomendado usar variables **globales** para guardar resultados intermedios entre funciones.

**12.** ¿Cuándo conviene usar `IF` y cuándo `COND`?

---

---

# SOLUCIONES

## Parte 1 — Trazado

### 1.1
a) `(clasifica 4 6)` → ambos números → `(+ 4 6)` = **`10`**. Un elemento, átomo (número).
b) `(clasifica '(1 2) 9)` → x lista, y número → `(cons 9 '(1 2))` = **`(9 1 2)`**. Tres elementos, todos átomos.
c) `(clasifica 7 '(3 4))` → x número, y lista → `(append '(3 4) (list 7))` = **`(3 4 7)`**. Tres elementos, todos átomos.
d) `(clasifica 'a 'b)` → ninguna de las anteriores → `(list 'a 'b)` = **`(A B)`**. Dos elementos, ambos átomos.
e) `(clasifica (car '(8 2)) (cdr '(8 2)))` → `x = 8` (átomo número), `y = (2)` (lista). x número e y lista → `(append '(2) (list 8))` = **`(2 8)`**. Dos elementos, ambos átomos.

> Nota: `(2)` **es una lista** (de un elemento), no un átomo. Por eso entra por la 3ra rama.

### 1.2
a) `+` (el símbolo, **no** evalúa la operación porque está citada con `'`)
b) `(B C)`
c) `(20 30)`  ← el 2º elemento *es* una sublista
d) `40`
e) `(25)`  ← `last` devuelve **una lista** con el último elemento, no el átomo
f) `(1 2 3 4)`  ← `append` une los elementos
g) `((1 2) 3 4)`  ← `cons` agrega `(1 2)` **adelante** como primer elemento
h) `((1 2) (3 4))`  ← `list` arma una lista con los dos argumentos tal cual
i) `(3 4 5)`  ← `member` devuelve la sublista **desde** donde encontró el 3
j) `(3 2 1)`

### 1.3
a) Suma **solo los números pares** de la lista (ignora los impares), recursivamente.
b) `(misterio '(1 2 3 4 5 6))` = 2 + 4 + 6 = **`12`**
c) `(misterio '(1 3 5))` = **`0`** (no hay pares)
d) `(misterio '())` = **`0`** (caso base)

### 1.4
a) `(T NIL T NIL)` — `atom`: `a`→T, `(b)`→NIL, `3`→T, `(c d)`→NIL.
b) `(NIL T NIL T)` — `listp` es lo contrario de `atom`.
c) `(11 22 33)` — suma posición a posición.
d) `(T NIL T)` — 5>4 T, 8>9 NIL, 3>2 T.
e) `((A) (B) (C))` — `list` arma una sublista con cada elemento.
f) `(2 0 3)` — largos: `(1 1)`→2, `()`→0, `(8 8 8)`→3.
g) `(9 18)` — se detiene en la lista más corta (2 elementos): 10−1, 20−2.

### 1.5
a) `POSITIVO` — `(car x)`=5, 5>0 → devuelve `POSITIVO`.
b) `NIL` — `(car x)`=−5, no es >0, y el `if` **no tiene else** → `NIL`.
c) `(C B A)` — `(cdr a)`=`(a b c)`, `reverse` → `(c b a)`.
d) `0` — `(car x)`=7, `(evenp 7)`=NIL → cae en el else → `0`.

## Parte 2 — Teoría

1. **d)** Lógico.
2. **Falso.** Es al revés: el imperativo describe el *cómo* paso a paso; el declarativo, el *qué*.
3. **d)** Un valor booleano (T/NIL).
4. **d)** El `cdr` de un cons apunta a un átomo.
5. **Falso.** Una destructiva **sí** modifica los valores de los parámetros (por eso se evitan).
6. **Falso.** Las aritméticas **no** modifican sus argumentos.
7. **a)** Read → Eval → Print.
8. **Verdadero.**
9. **b)** `mapcar`.
10. **c)** `reverse` en vez de `nreverse` (las no destructivas son `append`, `reverse`, `remove`).
11. **Falso.** Las variables globales **descuentan**. Se pasan los datos por parámetro y se devuelven con `return` implícito (el valor de la función).
12. `IF` cuando hay **exactamente 2 ramas** (verdadero / falso). `COND` cuando hay **1 o más ramas**, o para reemplazar `IF` anidados. Nunca anidar `IF` dentro de `COND` ni viceversa.
