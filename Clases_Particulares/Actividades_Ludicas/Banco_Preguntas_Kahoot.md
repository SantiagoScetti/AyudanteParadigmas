# Banco de Preguntas - Kahoot Práctico

## Preguntas TP 1 a 3 (Para Semana 1)

**Pregunta 1:** ¿Qué devuelve la siguiente expresión en LISP?
`(+ (* 2 3) (- 10 5))`
- A) 11 (Correcta)
- B) 16
- C) -1
- D) Error

**Pregunta 2:** Dada la lista `L = (A B (C D) E)`. ¿Qué instrucción utilizamos para extraer la sublista `(C D)`?
- A) `(caddr L)` (Correcta)
- B) `(cddr L)`
- C) `(cadr L)`
- D) `(car L)`

**Pregunta 3:** Si `L = (1 2 3)`, ¿Qué hace la función `(cons 0 L)`?
- A) Devuelve `(0 (1 2 3))`
- B) Devuelve `(0 1 2 3)` (Correcta)
- C) Devuelve `(1 2 3 0)`
- D) Reemplaza el 1 por el 0.

## Preguntas TP 4 y 5 (Para Semana 2)

**Pregunta 4:** ¿Qué devuelve la siguiente expresión?
`(mapcar 'length '((1 2) (3) () (4 5 6)))`
- A) `(2 1 0 3)` (Correcta)
- B) `4`
- C) `(2 1 1 3)`
- D) Error, no se puede aplicar a una lista vacía.

**Pregunta 5:** Observa la siguiente función:
```lisp
(defun mist (x)
  (cond ((null x) 0)
        (t (+ 1 (mist (cdr x))))))
```
¿Qué hace esta función si recibe la lista `'(A B C)`?
- A) Suma los elementos de la lista.
- B) Devuelve la longitud de la lista (Devuelve 3). (Correcta)
- C) Devuelve `(1 1 1)`.
- D) Causa un error.

**Pregunta 6:** ¿Qué devuelve `(mapcar '> '(5 2 8) '(3 4 5))`?
- A) `(T NIL T)` (Correcta)
- B) `(T F T)`
- C) `(5 4 8)`
- D) `(2 -2 3)`
