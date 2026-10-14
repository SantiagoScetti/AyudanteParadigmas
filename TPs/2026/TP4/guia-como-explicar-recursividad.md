# Guía del ayudante — Cómo explicar bien la recursividad (TP4)

Pensada para vos, no para repartir tal cual a los alumnos: son los errores que más se repiten cuando arman una función recursiva, con el código mal armado al lado del código corregido y la explicación de **por qué** falla.

---

## 1. La idea que hay que dejar clara antes de cualquier ejemplo

Una función recursiva necesita **dos ingredientes**, siempre:

1. **Caso base**: la condición donde la función NO se llama a sí misma y devuelve un valor directo. Sin esto, la recursión nunca para.
2. **Paso recursivo que se ACERCA al caso base**: cada llamada tiene que avanzar hacia el caso base (normalmente con `(cdr lista)`). Si no avanza, se llama a sí misma para siempre con el mismo dato.

Todo lo que sigue son formas distintas en que estos dos ingredientes se rompen.

---

## 2. Tabla rápida: síntoma → qué revisar

| Cuando ves esto... | Probablemente falta/sobra... |
|---|---|
| "Stack overflow" / se cuelga sin terminar | Falta el caso base, o el paso recursivo no avanza (le pasás la misma lista) |
| Error tipo "NIL no es un número" / "cannot car NIL" | El caso base devuelve el valor incorrecto, o falta un caso base para una situación puntual (lista de 1 elemento, segunda lista más corta) |
| El resultado da un número raro en vez de una lista (o viceversa) | Se mezcló el patrón "contar/sumar" (acumula con `+`) con el patrón "filtrar" (acumula con `cons`) |
| El resultado depende de si la función se llamó antes | Se usó una variable global (`setq` a algo no declarado en `let`) en vez de que el valor viaje por el `return` de la recursión |
| "Function X is undefined" | Typo en el nombre de la llamada recursiva (no coincide con el nombre del `defun`) |

---

## 3. Errores uno por uno

### 3.1 Falta el caso base
```lisp
; MAL
(defun sumar (lista)
    (+ (car lista) (sumar (cdr lista))))
```
Cuando `lista` llega a `nil`, `(car lista)` es `nil` y `(+ nil ...)` explota. Nunca hay un punto donde la función decida "ya terminé".

```lisp
; BIEN
(defun sumar (lista)
    (cond
        ((null lista) 0)
        (T (+ (car lista) (sumar (cdr lista))))))
```

### 3.2 Caso base con el valor incorrecto
```lisp
; MAL
(defun contar-pares (lista)
    (cond
        ((null lista) NIL)                              ; <- debería ser 0
        ((evenp (car lista)) (+ 1 (contar-pares (cdr lista))))
        (T (contar-pares (cdr lista)))))
```
El caso base "apaga" la recursión, pero el valor que devuelve tiene que poder combinarse con la operación que lo espera un nivel más arriba. Acá el nivel anterior hace `(+ 1 NIL)` y explota. Regla práctica: si vas a **sumar/contar**, el caso base es `0`; si vas a **armar una lista** (`cons`), el caso base es `nil`; si es un predicado, el caso base es `T` o `NIL` según lo que estés preguntando (ver 3.7).

```lisp
; BIEN
(defun contar-pares (lista)
    (cond
        ((null lista) 0)
        ((evenp (car lista)) (+ 1 (contar-pares (cdr lista))))
        (T (contar-pares (cdr lista)))))
```

### 3.3 El paso recursivo no avanza hacia el caso base
```lisp
; MAL
(defun contar-pares (lista)
    (cond
        ((null lista) 0)
        ((evenp (car lista)) (+ 1 (contar-pares lista)))    ; <- le pasa "lista" de nuevo
        (T (contar-pares (cdr lista)))))
```
Si el primer elemento es par, se vuelve a llamar con la **misma** lista: nunca cambia, nunca llega a `nil`, recursión infinita.

```lisp
; BIEN — siempre (cdr lista) en la llamada recursiva
(defun contar-pares (lista)
    (cond
        ((null lista) 0)
        ((evenp (car lista)) (+ 1 (contar-pares (cdr lista))))
        (T (contar-pares (cdr lista)))))
```

### 3.4 El caso base no está primero en el `cond`
```lisp
; MAL
(defun sumar (lista)
    (cond
        ((not (numberp (car lista))) (sumar (cdr lista)))  ; <- se evalúa antes que el caso base
        ((null lista) 0)
        (T (+ (car lista) (sumar (cdr lista))))))
```
`cond` evalúa las condiciones en orden y se queda con la primera que da verdadero. Acá, cuando `lista` es `nil`, se prueba primero `(numberp (car lista))`, y `(car nil)` ya explota antes de llegar a `(null lista)`.

**Regla de oro:** el caso base (`null`) va **siempre primero**.

```lisp
; BIEN
(defun sumar (lista)
    (cond
        ((null lista) 0)
        ((not (numberp (car lista))) (sumar (cdr lista)))
        (T (+ (car lista) (sumar (cdr lista))))))
```

### 3.5 Mezclar "contar/sumar" con "filtrar"
```lisp
; MAL — quiere la LISTA de los pares, pero suma en vez de encadenar con cons
(defun pares (lista)
    (cond
        ((null lista) 0)
        ((evenp (car lista)) (+ (car lista) (pares (cdr lista))))
        (T (pares (cdr lista)))))
```
Esto calcula la **suma** de los números pares, no arma una lista con ellos. Es el error más común cuando el enunciado dice "una nueva lista formada por..." y el alumno reacciona con reflejo de "sumar total" en vez de "acumular elementos".

```lisp
; BIEN — cons para acumular ELEMENTOS, nil como caso base de lista vacía
(defun pares (lista)
    (cond
        ((null lista) nil)
        ((evenp (car lista)) (cons (car lista) (pares (cdr lista))))
        (T (pares (cdr lista)))))
```
Truco para diferenciarlos con los alumnos: **si la respuesta es "cuántos" o "cuánto suma", el caso base es 0 y se combina con `+`. Si la respuesta es "cuáles son", el caso base es `nil` y se combina con `cons`.**

### 3.6 Recursión sobre dos listas: solo valida una
```lisp
; MAL
(defun diferencias (l1 l2)
    (cond
        ((null l1) nil)
        (T (cons (- (car l1) (car l2)) (diferencias (cdr l1) (cdr l2))))))
```
Si `l2` es más corta que `l1`, en algún momento `l1` todavía tiene elementos pero `l2` ya es `nil`, y `(car l2)` explota. Hay que cortar si **cualquiera** de las dos listas se vacía.

```lisp
; BIEN
(defun diferencias (l1 l2)
    (cond
        ((null l1) nil)
        ((null l2) nil)
        (T (cons (- (car l1) (car l2)) (diferencias (cdr l1) (cdr l2))))))
```

### 3.7 Comparar "consecutivos" (car vs cadr): falta el caso de 1 elemento
```lisp
; MAL
(defun ascendente-p (lista)
    (cond
        ((null lista) T)
        ((> (car lista) (cadr lista)) NIL)
        (T (ascendente-p (cdr lista)))))
```
Cuando a `lista` le queda un solo elemento, `(cadr lista)` es `nil`, y `(> numero nil)` explota. Falta el caso "queda 1 solo elemento, ya está ordenada por definición".

```lisp
; BIEN
(defun ascendente-p (lista)
    (cond
        ((null lista) T)
        ((null (cdr lista)) T)                    ; <- un solo elemento: no hay con qué comparar
        ((> (car lista) (cadr lista)) NIL)
        (T (ascendente-p (cdr lista)))))
```

### 3.8 Semilla del acumulador mal elegida (máximo/mínimo)
```lisp
; MAL — busca el máximo de una lista que puede tener negativos, arrancando en 0
(defun maximo (lista) (mayor-desde lista 0))
;; (maximo '(-5 -20 -3)) -> devuelve 0, ¡y el 0 ni siquiera está en la lista!
```
El acumulador tiene que arrancar con un valor que **no invente** un resultado que no existía en los datos.

```lisp
; BIEN — arrancar con el primer elemento de la lista, no con un número fijo
(defun maximo (lista) (mayor-desde (cdr lista) (car lista)))
;; Para MINIMO: mismo truco (arrancar con (car lista)), invirtiendo la comparación (< en vez de >).
;; Si usás un tope fijo, para MAXIMO tiene que ser un valor imposiblemente chico,
;; y para MINIMO, imposiblemente grande — nunca 0, salvo que el enunciado garantice que todo es >= 0.
```

### 3.9 Usar variables globales para "ir acumulando"
```lisp
; MAL
(defun sumar (lista)
    (cond
        ((null lista) total)                              ; <- "total" es global, no viene de ningún lado
        (T (setq total (+ total (car lista))) (sumar (cdr lista)))))
```
Además de descontar puntos (variable global), esto **no es recursión funcional real**: depende de un estado externo mutable. Si llamás a `sumar` dos veces seguidas sin resetear `total` a mano, el segundo resultado sale mal porque arrastra el valor de la llamada anterior.

```lisp
; BIEN — el resultado viaja en el valor de retorno, nunca en una variable de afuera
(defun sumar (lista)
    (cond
        ((null lista) 0)
        (T (+ (car lista) (sumar (cdr lista))))))
```

### 3.10 Typo en la llamada recursiva
```lisp
; MAL
(defun contar (lista)
    (cond
        ((null lista) 0)
        (T (+ 1 (contarLista (cdr lista))))))   ; <- "contarLista" no existe
```
Da error de "función indefinida". Parece una tontería, pero es de los errores más comunes bajo presión de tiempo en un parcial: revisar siempre que el nombre de la llamada recursiva sea **exactamente** el nombre del `defun`.

---

## 4. Checklist para pasarles antes de entregar cualquier función recursiva

- [ ] ¿Tiene un caso base (`null lista`, o equivalente) y está **primero** en el `cond`?
- [ ] ¿El valor del caso base es del tipo correcto para lo que lo va a usar (0 para sumar/contar, `nil` para armar lista, `T`/`NIL` para predicados)?
- [ ] ¿Todas las llamadas recursivas avanzan con `(cdr lista)` (o equivalente)? ¿Ninguna repite la lista tal cual?
- [ ] Si son dos listas: ¿se valida `null` de **ambas**, no solo de una?
- [ ] Si compara consecutivos (`car` vs `cadr`): ¿contempla el caso de 1 solo elemento?
- [ ] ¿El nombre de la llamada recursiva coincide exactamente con el nombre de la función?
- [ ] ¿No hay ninguna variable global (`setq` sobre algo no declarado en `let`)?
- [ ] ¿Probaron con lista vacía, lista de 1 elemento, y con datos "basura" (heterogéneos) si el enunciado lo permite?

---

## 5. Para practicar con ellos: "encontrá el error"

Dales el código y pedíles que digan qué pasa (sin correrlo) antes de mostrar la respuesta.

**Ejercicio A:**
```lisp
(defun productoria (lista)
    (cond
        ((null lista) 0)
        (T (* (car lista) (productoria (cdr lista))))))
```
<details><summary>Respuesta</summary>
El caso base de una productoria (multiplicación) tiene que ser <code>1</code>, no <code>0</code> — con 0 el resultado siempre da 0, porque cualquier número multiplicado por el resultado final (que arrastra el 0) se anula.
</details>

**Ejercicio B:**
```lisp
(defun ultimo (lista)
    (cond
        ((null (cdr lista)) (car lista))
        (T (ultimo lista))))
```
<details><summary>Respuesta</summary>
Falta <code>(cdr lista)</code> en la llamada recursiva del último renglón: <code>(ultimo lista)</code> nunca avanza, recursión infinita.
</details>

**Ejercicio C:**
```lisp
(defun contar-negativos (lista)
    (cond
        ((null lista) nil)
        ((< (car lista) 0) (+ 1 (contar-negativos (cdr lista))))
        (T (contar-negativos (cdr lista)))))
```
<details><summary>Respuesta</summary>
El caso base devuelve <code>nil</code> pero la función cuenta (usa <code>+</code>): en algún momento se intenta <code>(+ 1 nil)</code> y explota. El caso base de un contador tiene que ser <code>0</code>.
</details>
