# 03 · Programación funcional, parte 2: listas, asignación, funciones destructivas, igualdad, lógica y bloques

Fuente: `diapositivas/PyL - 2026 - Funcional Parte 2.pdf` (44 diapositivas) · Prof. Msc. Ricardo Monzón
Programa: Unidad II, Temas 2, 3 y 4.

## Índice

1. Expresiones simbólicas y formas
2. Funciones de selección: CAR, CDR, C****R, LAST, ELT
3. Asignación: SETQ
4. Funciones de construcción: CONS, LIST, APPEND
5. Otras funciones de listas: BUTLAST, NTH, NTHCDR, REVERSE
6. Funciones destructivas: RPLACA, RPLACD, NCONC, PUSH, POP
7. LENGTH y MEMBER
8. Ligaduras: MAKUNBOUND, FMAKUNBOUND, BOUNDP, FBOUNDP
9. Predicados sobre tipos de datos
10. Predicados de igualdad: `=`, EQ, EQL, EQUAL, EQUALP
11. Operadores lógicos: AND, OR, NOT
12. Secuencia de acciones: PROGN, PROG1, PROG2, PROG*
13. Erratas y diferencias con Common Lisp estándar
14. Conceptos clave para el final

---

## 1. Expresiones simbólicas y formas

- Los átomos y las listas son **expresiones simbólicas** (S-expresiones). Cualquier átomo válido o lista lo es.

```lisp
; átomos
5    A    "A ES UN STRING"
; listas
(UNA LISTA DE ELEMENTOS)
(((A)))
(+ 3 (* X (/ 100 (- Y Z))))
(DEFUN ADD2 (X) (+ X 2))
```

- Una **forma** es un objeto que **puede ser evaluado**. A un átomo no se lo considera una forma tipo lista.
- Las listas son conjuntos **ordenados** de átomos o listas conectados.

## 2. Funciones de selección

| Función | Devuelve |
|---|---|
| `CAR` | El **primer elemento** de la lista |
| `CDR` | **Toda la lista menos el primer elemento** |
| `C****R` | Concatenación de CAR y CDR: `CADR`, `CDDR`, `CADADR`, etc. |

**CAR** — sintaxis `(CAR LISTA)`, más técnicamente `(CAR CONS)`.

`(CAR (1 2 3))` no funciona: Lisp intenta evaluar `(1 2 3)` buscando una función llamada `1` con argumentos 2 y 3, y da ERROR. Hay que usar `quote`.

```lisp
(CAR '(1 2 3))          ; => 1
(CAR '(A B C))          ; => A
(CAR '(A B (C D) E))    ; => A
(CAR '((A B) C))        ; => (A B)
(CAR '((A B C)))        ; => (A B C)
(CAR 'A)                ; => ERROR
```

- No se puede obtener el CAR de un átomo. En general **no se puede aplicar ninguna función de lista a los átomos**.
- CAR **no genera un nuevo valor**: da como resultado la **dirección de un elemento que existe**.

**CDR** — sintaxis `(CDR LISTA)` o `(CDR CONS)`. Para listas propias (no punteadas) devuelve la lista sin el primer elemento. Sus argumentos deben ser de tipo CONS.

```lisp
(CDR '(A B C))          ; => (B C)
(CDR '(A B (C D) E))    ; => (B (C D) E)
(CDR '((A B) C))        ; => (C)
(CDR '((A B C)))        ; => NIL
(CDR 'A)                ; => ERROR
(CDR '(A . B))          ; => B      (en una lista punteada el CDR puede ser un átomo)
```

**C****R** — abreviación de CAR y CDR. El `*` se sustituye por `A` (CAR) o `D` (CDR). Se pueden sustituir **hasta cuatro posiciones**. Las letras se aplican **de derecha a izquierda**.

```lisp
(CADR '(A B C))                 ; => B        equivale a (CAR (CDR '(A B C)))
(CDAR '((A B C) D E))           ; => (B C)    equivale a (CDR (CAR '((A B C) D E)))
(CADDR '(A B C D E))            ; => C
(CAR (CDDDDR '(A B C D E)))     ; => E
```

**LAST** — devuelve la **última estructura CONS** de la lista (una lista de un elemento, no el elemento suelto).

```lisp
(LAST '(A B C))       ; => (C)
(LAST '(A (B C)))     ; => ((B C))
(LAST '(1 2 3.5))     ; => (3.5)
(LAST '((A B C)))     ; => ((A B C))
```

**ELT** — `(ELT LISTA INDICE)` devuelve el elemento en la posición índice. El primer elemento tiene índice **0**.

```lisp
(ELT '(A (B C)) 1)        ; => (B C)
(ELT '(A B) 3)            ; => ERROR
(ELT '(A B C D E) 2)      ; => C      (posiciones 0,1,2,3,4: el 2 es la tercera)
```

## 3. Asignación: SETQ

- `SETQ` asigna un valor a una variable. Sintaxis: `(SETQ {VAR FORM}+)`, es decir `(SETQ VAR FORM VAR FORM ...)`.
- La **Q** es un mnemotécnico de `quote`: **los argumentos impares (las variables) no se evalúan**.
- Debe haber un **número par** de argumentos; si es impar da error.
- Las evaluaciones y asignaciones se realizan **secuencialmente** (primero se evalúa, luego se asigna).
- Devuelve **el resultado de la última evaluación**.

```lisp
(SETQ X 5)                              ; => 5
(SETQ NOMBRE "MARIA")                   ; => "MARIA"
(SETQ FRUTA (CAR '(MANZANA PERA)))      ; => MANZANA
(SETQ LISTA1 '(A B C))                  ; => (A B C)
(SETQ X 5 Y 6 Z 7)                      ; => 7
(SETQ X 5 Y 6 Z)                        ; => Error: too few arguments
```

## 4. Funciones de construcción de listas

Son tres: **CONS, LIST y APPEND**.

| Función | Argumentos | Qué construye | Puede crear listas impropias |
|---|---|---|---|
| `(CONS SEXP SEXP)` | Exactamente dos; átomos o listas | Una **nueva estructura cons**: el CAR es la primera SEXP y el CDR la segunda | Sí (si la segunda es un átomo) |
| `(LIST SEXP ...)` | Cualquier cantidad (`&REST`); átomos o listas | Una lista con **todos los argumentos como elementos** | No: solo listas propias |
| `(APPEND LISTA ... SEXP)` | Cualquier cantidad; **todos listas excepto el último** | Una nueva lista **concatenando** las listas dadas | Sí (si el último es un átomo) |

```lisp
; CONS
(CONS 'A '(B C D))                  ; => (A B C D)
(CONS '(X Y) '(B C D))              ; => ((X Y) B C D)
(CONS '((X Y) (W Z)) '((A B)))      ; => (((X Y) (W Z)) (A B))
(CONS 'A NIL)                       ; => (A)
(CONS NIL '(A))                     ; => (NIL A)
(CONS 'A 'B)                        ; => (A . B)        lista punteada ("impropia")
(CONS '(A B) 'C)                    ; => ((A B) . C)

; LIST
(LIST 'A 'B 'C)                     ; => (A B C)
(LIST '(A) '(B) '(C))               ; => ((A) (B) (C))
(LIST 'A '(B C))                    ; => (A (B C))

; APPEND
(APPEND '(A) '(B) '(C))             ; => (A B C)
(APPEND '(A) '(B C))                ; => (A B C)
(APPEND '((A)) '((B)) '((C)))       ; => ((A) (B) (C))
(APPEND '(A) NIL)                   ; => (A)          NIL es una lista
(APPEND NIL '(B C))                 ; => (B C)
(APPEND 'A '(B C))                  ; => ERROR
(APPEND '(A) '(B) 'C)               ; => (A B . C)
```

Comparación con los mismos argumentos `'(1 2)` y `'(3 4)`:

| Expresión | Resultado | Cantidad de elementos |
|---|---|---|
| `(cons '(1 2) '(3 4))` | `((1 2) 3 4)` | 3 |
| `(list '(1 2) '(3 4))` | `((1 2) (3 4))` | 2 |
| `(append '(1 2) '(3 4))` | `(1 2 3 4)` | 4 |

## 5. Otras funciones de listas (no destructivas)

| Función | Qué hace | Ejemplo |
|---|---|---|
| `(BUTLAST lista n)` | Nueva lista **sin los n últimos** elementos. No modifica la original | `(setq b '(3 4 5 6))`, `(butlast b 2)` → `(3 4)`; `b` sigue siendo `(3 4 5 6)` |
| `(NTH n lista)` | Elemento en la posición `n` (el primero es 0) | `(setq b '(4 5 6))`, `(nth 1 b)` → `5`; `(nth 0 b)` → `4` |
| `(NTHCDR n lista)` | El CDR de la lista a partir del elemento `n` | `(setq b '(4 5 6 7 8))`, `(nthcdr 3 b)` → `(7 8)`; `(nthcdr 1 b)` → `(5 6 7 8)` |
| `(REVERSE lista)` | El reverso de la lista. No modifica la original | `(reverse '(4 5 6 7 8))` → `(8 7 6 5 4)` |

Para conservar el resultado de una función no destructiva hay que asignarlo: `(setq lista (butlast lista n))`, `(setq lista1 (reverse b))`.

## 6. Funciones destructivas

**Definición.** A diferencia de las anteriores (llamadas **no destructivas**), las funciones **destructivas** son aquellas que **modifican el contenido de algún parámetro**.

| Función | Qué hace | Equivalente no destructivo |
|---|---|---|
| `(RPLACA lista elem)` | Sustituye el **CAR** de la lista con `elem` | |
| `(RPLACD lista elem)` | Sustituye el **CDR** de la lista con `elem` | |
| `(NCONC lista1 ... listan)` | Concatena como APPEND, pero **modificando** lista1 y las sucesivas hasta la n-1 | `APPEND` |
| `(PUSH item lista)` | Añade `item` al **principio** de la lista | `(setq lista (cons item lista))` |
| `(POP lista)` | Elimina el **primer elemento** de la lista (y lo devuelve) | `(setq lista (cdr lista))` |
| `INCF`, `DECF` | Incrementan o decrementan una variable (apunte 02) | `(+ var delta)` |

```lisp
; RPLACA
(setq a '(1 2 3))       ; => (1 2 3)
(rplaca a 7)            ; => (7 2 3)
a                       ; => (7 2 3)        a cambió

; RPLACD
(rplacd a '(9))         ; => (7 9)
a                       ; => (7 9)
(rplacd a 6)            ; => (7 . 6)        queda una lista punteada
a                       ; => (7 . 6)

; NCONC
(setq a '(1 2) b '(3 4) c '(5 6) d '(7 8))   ; => (7 8)
(nconc a b c d)         ; => (1 2 3 4 5 6 7 8)
a                       ; => (1 2 3 4 5 6 7 8)
b                       ; => (3 4 5 6 7 8)
c                       ; => (5 6 7 8)
d                       ; => (7 8)          la última no cambia

; PUSH y POP
(setq b '(4 5 6))       ; => (4 5 6)
(push 9 b)              ; => (9 4 5 6)
b                       ; => (9 4 5 6)
(pop b)                 ; => 9
b                       ; => (4 5 6)
```

**Comparación destructiva vs. no destructiva** (pregunta típica de final)

| | No destructiva | Destructiva |
|---|---|---|
| Efecto sobre los argumentos | No los modifica; devuelve un valor nuevo | Modifica el contenido de algún parámetro |
| Para conservar el resultado | Hay que asignarlo con `setq` | Ya queda guardado en la variable |
| Ejemplo 1 | `(append a b)`: `a` no cambia | `(nconc a b)`: `a` queda con la concatenación |
| Ejemplo 2 | `(reverse b)`, `(butlast b 2)`, `(cons 9 b)` | `(push 9 b)`, `(pop b)`, `(rplaca a 7)`, `(incf c)` |

## 7. LENGTH y MEMBER

**LENGTH** — devuelve el número de elementos en el **nivel superior** de la lista (o secuencia).

```lisp
(LENGTH '(A B C))       ; => 3
(LENGTH '(A B . C))     ; => 2    (el segundo elemento es uno solo, el par punteado)
(LENGTH '())            ; => 0
```

**MEMBER** — `(MEMBER ITEM LISTA {&KEY :TEST / :TEST-NOT / :KEY})`

- Busca en el **nivel superior** de la lista un elemento igual (por defecto con **EQL**) al ítem.
- Si lo encuentra, devuelve **la lista cuyo CAR es el elemento buscado y cuyo CDR es el resto** de la lista. Si no, devuelve `NIL`.
- `:TEST` compara el ítem con cada elemento usando el operador indicado, hasta el primero que dé NO-NIL.
- `:TEST-NOT` es igual pero se detiene en el primer elemento cuya evaluación dé NIL.
- `:KEY` aplica la función indicada antes de comparar.

```lisp
(MEMBER 'C '(A B C D E F))                          ; => (C D E F)
(MEMBER 'Z '(A B C D E F))                          ; => NIL
(MEMBER 'J '(A B (I J) F))                          ; => NIL   (solo mira el nivel superior)
(MEMBER '(X Y) '(A B C (X Y) D))                    ; => NIL   (compara con EQL)
(MEMBER '(X Y) '(A B C (X Y) D) :TEST #'EQUAL)      ; => ((X Y) D)
(MEMBER '7 '(3 5 7 9) :TEST-NOT #'>)                ; => (7 9)
```

## 8. Ligaduras de símbolos

| Función | Qué hace | Ejemplo |
|---|---|---|
| `(MAKUNBOUND sym)` | **Desliga** un símbolo de su **valor** | `(setq a 4)`, `(makunbound 'a)`, `a` → Error: The variable A is unbound |
| `(FMAKUNBOUND sym)` | **Desliga** un símbolo de una **función** | `(fmakunbound 'mi-suma)` |
| `(BOUNDP sym)` | Predicado: `T` si el símbolo tiene un **valor** ligado | `(setq a 1)`, `(boundp 'a)` → `T` |
| `(FBOUNDP sym)` | Predicado: `T` si el símbolo tiene una **definición de función** ligada | `(fboundp 'car)` → `T`; `(fboundp 'f2)` → `NIL` |

## 9. Predicados sobre tipos de datos

Todos devuelven `T` si son ciertos o `NIL` si no.

| Predicado | Es cierto cuando... |
|---|---|
| `(ATOM obj)` | el objeto **no** es una construcción CONS |
| `(CONSP obj)` | el objeto es CONS |
| `(LISTP obj)` | el objeto es CONS **o NIL** (la lista vacía) |
| `(NULL obj)` | el objeto es NIL |
| `(TYPEP obj tipo)` | el objeto pertenece al tipo especificado |

Caso que suele confundir: `NIL` es átomo y lista a la vez. `(atom nil)` → `T`, `(listp nil)` → `T`, `(consp nil)` → `NIL`.

## 10. Predicados de igualdad

Los objetos Lisp pueden verificarse a **diferentes niveles de igualdad**:

| Nivel | Predicado | Qué compara | Para qué usarlo (resumen de la cátedra) |
|---|---|---|---|
| Igualdad numérica | `=` | Valores numéricos | Números |
| Identidad referencial | `EQ` | Si X e Y están referenciados por **punteros iguales** | Caracteres, símbolos y enteros pequeños (hasta 255) |
| Identidad representacional | `EQL` | Si representan el **mismo valor** (misma posición en memoria); acepta solo dos argumentos | Números **del mismo tipo** y variables. No es fiable con strings |
| Igualdad estructural | `EQUAL` | Si son **estructuralmente iguales**: sus valores imprimibles son iguales; acepta solo dos argumentos | **Listas y strings** |
| Igualdad de valores | `EQUALP` | El mismo valor sin distinguir mayúsculas (*case insensitive*) y sin distinguir tipo numérico | Strings y caracteres sin importar mayúsculas, números de distinto tipo, arreglos |

```lisp
; EQ
(eq 'a 'a)        ; => T
(eq 1 1)          ; => T
(eq 256 256)      ; => NIL   (solo hasta 255)
(eq 1 1.0)        ; => NIL
(eq "a" "a")      ; => NIL

; EQL
(EQL 5 5)                 ; => T
(EQL 5 5.0)               ; => NIL
(SETQ L '(A B C))
(EQL '(A B C) L)          ; => NIL  (no fiable: son dos listas distintas en memoria)
(SETQ M L)
(EQL L M)                 ; => T    (dos variables apuntan al mismo sitio)
(SETQ N '(A B C))
(EQL L N)                 ; => NIL

; EQUAL
(EQUAL 5.0 5)             ; => NIL
(EQUAL NIL ())            ; => T
(SETQ A 'WORD B 'WORD)
(EQUAL A B)               ; => T
(EQUAL '(A B C) L)        ; => T
(EQUAL L M)               ; => T
(EQUAL L N)               ; => T
(EQUAL L A)               ; => NIL

; EQUALP
(EQUALP 5 5)              ; => T
(EQUALP 5 5.0)            ; => T
(EQUALP "a" "A")          ; => T
```

**Tabla comparativa** (figura de la diap. 36, "PREDICADOS DE IGUALDAD (7)")

| Argumentos | eq | eql | equal | equalp |
|---|---|---|---|---|
| `(fn 'a 'a)` | T | T | T | T |
| `(fn 1 1)` | T | T | T | T |
| `(fn 1 1.0)` | NIL | NIL | NIL | T |
| `(fn 1.0 1.0)` | NIL | T | T | T |
| `(fn "a" "a")` | NIL | NIL | T | T |
| `(fn '(a b) '(a b))` | NIL | NIL | T | T |
| con `(setq a '(a b))`, `(setq b a)`, `(setq c '(a b))`: | | | | |
| `(fn a b)` | T | T | T | T |
| `(fn a c)` | NIL | NIL | T | T |
| `(fn '(a b) '(A B))` | NIL | NIL | T | T |
| `(fn '(a b) '(c d))` | NIL | NIL | NIL | NIL |
| `(fn "a" "A")` | NIL | NIL | NIL | T |
| `(fn "abc" "abcD")` | NIL | NIL | NIL | NIL |

Lectura de la tabla: cada predicado es más permisivo que el anterior (`eq` ⊂ `eql` ⊂ `equal` ⊂ `equalp`). Si uno da `T`, todos los de su derecha dan `T`.

## 11. Operadores lógicos

- Lisp tiene tres operadores lógicos como primitivas: **AND, OR y NOT**. Los demás pueden crearse a partir de estos.
- AND y OR **no evalúan necesariamente todos los argumentos** (evaluación en cortocircuito). Por eso **importa el orden** de los argumentos.

| Operador | Evaluación | Devuelve |
|---|---|---|
| `(AND form ...)` | En orden. Se detiene en el **primer NIL** | `NIL` si alguno es NIL; si todos son NO-NIL, **el resultado de la última evaluación** |
| `(OR form ...)` | En orden. Se detiene en el **primer NO-NIL** | El valor de ese primer NO-NIL; si todos son NIL, el resultado de la última (NIL) |
| `(NOT form)` | Un único argumento | `T` si el argumento es NIL; en otro caso `NIL` |

```lisp
; AND
(AND T (< 2 5) (> 7 4) (* 2 5))               ; => 10
(SETQ X 3 CONT 0)
(INCF CONT)
(AND (<= CONT 10) (NUMBERP X) (* 2 X))        ; => 6
(AND (EVENP X) (/ X 2))                       ; => NIL

; OR
(OR NIL (= 4 5) (NULL '(A B)) (REM 23 13))    ; => 10
(SETQ X 10)
(OR (< 0 X) (DECF X))                         ; => T    (no llega a evaluar DECF)
(OR (> 0 X) (DECF X))                         ; => 9    (el primero es NIL; evalúa DECF)

; NOT
(NOT NIL)                 ; => T
(NOT T)                   ; => NIL
(NOT (EQUAL 'A 'A))       ; => NIL
(SETQ X '(A B C))
(NOT (ATOM X))            ; => T
```

## 12. Secuencia de acciones (bloques)

- Un **bloque** es una secuencia de sentencias que deben ejecutarse **secuencialmente en el orden en que aparecen**.
- Algunos bloques se crean de forma **implícita** (por ejemplo en `loop`); para crearlos de forma **explícita** se usa la familia **prog**.

| Forma | Evalúa | Devuelve |
|---|---|---|
| `(progn s1 ... sn)` | Todas, en secuencia (puede no tener sentencias) | El valor de la **última** |
| `(prog1 s1 ... sn)` | Todas | El valor de la **primera** |
| `(prog2 s1 ... sn)` | Todas | El valor de la **segunda** |

```lisp
(progn (setq a 23) (setq b 35) (setq c (* a b)))    ; => 805
(prog1 (setq a 23) (setq b 35) (setq c (* a b)))    ; => 23
(prog2 (setq a 23) (setq b 35) (setq c (* a b)))    ; => 35
c                                                    ; => 805   (igual se evaluó todo)
```

- Si el bloque declara **variables locales**, la asignación de sus valores se hace **en paralelo** (igual que `LET`). Para que sea **secuencial** se usa `PROG*`.
- La devolución de un valor puede hacerse explícita con `(RETURN resultado)`.

## 13. Erratas y diferencias con Common Lisp estándar

En el final vale lo que dicen las diapositivas; esto es para saber explicar si un alumno prueba en SBCL.

- En la diapositiva de C****R los resultados aparecen desalineados; los correctos son los de la sección 2.
- En la diapositiva de EQ la sintaxis figura como `(EQL SEXPR SEXPR)`; debería decir `(EQ SEXPR SEXPR)`.
- `(eq 256 256)` → `NIL` y "solo hasta 255" es comportamiento del intérprete de la cátedra. El estándar no garantiza nada sobre `eq` con números; por eso se recomienda `eql`.
- OR: la definición dice que al encontrar un NO-NIL "se devuelve T", pero los ejemplos de la misma diapositiva muestran que devuelve **el valor** de ese argumento (10, 9). Lo correcto es lo segundo.
- Último ejemplo de OR, `(OR (CONSP X) (EVENP X) (/ X 2))` → `5` con el comentario "ambas dan NIL": con X = 10, `(evenp x)` es `T` y el OR devolvería `T`. El ejemplo no cierra con los valores de la diapositiva.
- En la diapositiva de EQL, los resultados de `(EQL A B)` con `A` y `B` ligados al símbolo `WORD` quedan desalineados. Dos variables con el mismo símbolo son `eql` (`T`), como muestra la primera fila de la tabla comparativa.
- La "sintaxis completa" que la diapositiva atribuye a PROGN (con variables e inicializaciones) corresponde en realidad a `PROG`. `PROGN` solo agrupa formas.
- `(length '(a b . c))` → `2` vale en el intérprete de la cátedra; SBCL da error porque no es una lista propia.

## 14. Conceptos clave para el final

- S-expresión y forma.
- CAR, CDR y sus combinaciones (se leen de derecha a izquierda, hasta 4 letras); LAST devuelve un cons.
- SETQ: número par de argumentos, no evalúa las variables, devuelve la última evaluación.
- Diferencia entre CONS, LIST y APPEND con los mismos argumentos.
- **Función destructiva vs. no destructiva**, con dos ejemplos de cada una (pregunta del modelo de final).
- MEMBER devuelve el resto de la lista desde el elemento, compara con EQL y solo en el nivel superior.
- ATOM, CONSP, LISTP, NULL; el caso de NIL.
- Los cinco niveles de igualdad y la tabla comparativa.
- AND y OR con cortocircuito: qué valor devuelven.
- PROGN, PROG1, PROG2: cuál valor devuelve cada uno.
