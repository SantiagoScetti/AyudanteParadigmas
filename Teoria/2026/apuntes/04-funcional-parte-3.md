# 04 · Programación funcional, parte 3: condicionales, iteración, MAPCAR y entrada/salida

Fuente: `diapositivas/PyL - 2026 - Funcional Parte 3.pdf` (28 diapositivas) · Prof. Msc. Ricardo Monzón
Programa: Unidad II, Tema 4.

## Índice

1. Estructuras condicionales: IF, COND, WHEN, UNLESS, CASE, TYPECASE
2. Estructuras iterativas: LOOP, DO, DOTIMES, DOLIST
3. Funciones iterativas predefinidas: MAPCAR y MAPLIST
4. Entrada/salida simple: READ, PRINT, PRIN1, PRINC, PPRINT, FORMAT, TERPRI
5. Erratas y diferencias con Common Lisp estándar
6. Conceptos clave para el final

---

## 1. Estructuras condicionales

Los condicionales son formas que permiten tomar decisiones. **Verifican y ramifican**: verifican devolviendo NIL o NO-NIL (como cualquier función), y ramifican según el resultado.

Condicionales de Lisp: **IF, CASE, COND, WHEN, UNLESS, TYPECASE**.

| Forma | Sintaxis | Cuándo evalúa el cuerpo | Devuelve |
|---|---|---|---|
| `IF` | `(IF cond then [else])` | `then` si la condición es NO-NIL; `else` (opcional) si es NIL | El valor de la rama evaluada |
| `COND` | `(COND (test forma...) ...)` | Las formas de la **primera** cláusula cuyo test sea NO-NIL | El valor de la última forma de esa cláusula; `NIL` si ningún test se cumple |
| `WHEN` | `(WHEN test forma1 ... formaN)` | Todas las formas si el test es **verdadero** | La última forma, o `NIL` |
| `UNLESS` | `(UNLESS test forma1 ... formaN)` | Todas las formas si el test es **NIL** | La última forma, o `NIL` |
| `CASE` | `(CASE keyform (lista forma...) ...)` | Las formas de la cláusula cuya lista contiene el valor de la clave | El valor de esa cláusula |
| `TYPECASE` | `(TYPECASE keyform (tipo forma...) ...)` | Las formas de la cláusula cuyo **tipo** coincide con el del objeto | El valor de esa cláusula |

### IF

```lisp
(setq obj 5)
(if (numberp obj) "Es un número" "Esto no es un número")    ; => "Es un número"
(setq obj 'a)
(if (numberp obj) "Es un número" "Esto no es un número")    ; => "Esto no es un número"
```

### COND

- Permite expresar **varias condiciones**, ejecutándose **la primera que se cumple**.
- Acepta cualquier número de listas (cláusulas). Cada una tiene un **test** seguido de **cero o más formas consecuentes**.
- Los tests se evalúan **secuencialmente** hasta encontrar uno NO-NIL; se evalúan sus formas y **se sale del COND**. Las cláusulas posteriores no se evalúan aunque sus condiciones también sean ciertas.
- Una cláusula sin consecuentes devuelve el valor NO-NIL del propio test.
- Si todos los tests devuelven NIL, COND devuelve NIL.

```lisp
(COND (TEST1 FORMA11 FORMA12 ... FORMA1N)
      (TEST2)                              ; sin consecuente: devuelve el valor del test
      (TEST3 FORMA31 FORMA32 ... FORMA3M)
      ...
      (TESTR ...))

(setq a 4)
(cond ((numberp a) "Esto es un número")
      (t "Esto no es un número"))          ; => "Esto es un número"

(setq x 8)
(cond ((< x 0)   (print "NEGATIVO"))
      ((= x 0)   (print "CERO"))
      ((<= x 10) (print "VALOR EN RANGO"))
      (T         (print "VALOR MUY GRANDE") x))
; imprime "VALOR EN RANGO"
```

La cláusula `(T ...)` al final funciona como el "en otro caso".

### WHEN y UNLESS

- `WHEN` equivale a un IF **sin opción else**; si el test es verdadero, evalúa **todas** las formas restantes.
- `UNLESS` es lo contrario: evalúa las formas siempre que el test sea **NIL**.

```lisp
(setq a 4)
(when (equal a 4) (print (* a a)) (print "cierto"))
; imprime 16 y "cierto"; devuelve "cierto"
(when (equal a 3) (print (* a a)) (print "cierto"))      ; => NIL  (no evalúa nada más)

(unless (equal a 4) (print (* a a)) (print "cierto"))    ; => NIL
(unless (equal a 3) (print (* a a)) (print "cierto"))
; imprime 16 y "cierto"; devuelve "cierto"
```

### CASE

La clave se compara con los elementos de cada lista; si alguno coincide, se devuelve el resultado de esa cláusula.

```lisp
(setq mes 'jun)
(case mes
  ((ene mar may jul ag oct dic) 31)
  ((abr jun sep nov) 30)
  (feb (if (zerop (mod año 4)) 29 28)))      ; => 30
```

### TYPECASE

Realiza acciones según la **clase (tipo)** de un objeto.

```lisp
(SETQ X 2)
(TYPECASE X
  (string    "es un string")
  (integer   "es un entero")
  (symbol    (print '(es un símbolo)))
  (otherwise (print "operador") (print "desconocido")))    ; => "es un entero"
```

## 2. Estructuras iterativas

| Forma | Idea | Cómo termina | Valor |
|---|---|---|---|
| `LOOP` | Cicla continuamente evaluando las formas en secuencia | Con `RETURN` explícito | El del `RETURN` (NIL si no lleva valor) |
| `DO` | Lista de parámetros + test de final + cuerpo (similar a un while) | Cuando el test de final se cumple | La forma resultado del test |
| `DOTIMES` | Iteración controlada por un **contador** de 0 a n-1 | Al completar n vueltas | La forma resultado, o `NIL` |
| `DOLIST` | Recorre los **elementos de una lista** | Cuando la lista no tiene más elementos | El resultado, o `NIL` |

### LOOP

`(LOOP {FORMA}*)`. La terminación se indica con `RETURN`; en general, evaluar `RETURN` provoca la salida de cualquier sentencia iterativa.

```lisp
(setq x 1)
(loop
  (print x)
  (setq x (+ x 1))
  (if (= x 20) (return)))
; imprime del 1 al 19 y sale con NIL
```

### DO

```lisp
(DO ((var1 inic1 [paso1]) ...
     (varn inicn [pason]))        ; asignación de variables EN PARALELO
    (test-final resultado)        ; el test de final se evalúa ANTES que el cuerpo
  declaraciones
  cuerpo)
```

- Tres partes: **lista de parámetros, test de final y cuerpo**.
- La lista de parámetros liga las variables con sus valores iniciales y en cada ciclo les asigna nuevos valores según la función de incremento.
- Primero se activa la ligadura de los parámetros, **después se evalúa el test de final**, y si no se cumple se ejecuta el cuerpo. Se parece al `while ... do` de otros lenguajes.

```lisp
; exponente m^n con el incremento en el cuerpo
(setq m 3 n 4)
(do ((resultado 1) (exponente n))
    ((zerop exponente) resultado)          ; si exponente es 0, devuelve resultado
  (setq resultado (* m resultado))
  (setq exponente (- exponente 1)))        ; => 81

; lo mismo con los pasos en la lista de parámetros
(do ((resultado 1 (* m resultado))
     (exponente n (1- exponente)))
    ((zerop exponente) resultado))         ; => 81

; invertir una lista
(setq lista '(1 2 3 4))
(do ((l lista (cdr l))
     (resultado nil (cons (car l) resultado)))
    ((null l) resultado))                  ; => (4 3 2 1)
```

Seguimiento del último ejemplo:

| Iteración | `l` | `resultado` |
|---|---|---|
| 1 | `(1 2 3 4)` | `nil` |
| 2 | `(2 3 4)` | `(1)` |
| 3 | `(3 4)` | `(2 1)` |
| 4 | `(4)` | `(3 2 1)` |
| 5 | `()` | `(4 3 2 1)` |

### DOTIMES

`(DOTIMES (var forma-limite-superior [forma-resultado]) cuerpo)`

- Al comenzar se evalúa la forma límite superior, que produce un valor `n`.
- `var` toma los valores desde **0 hasta n-1**, de uno en uno; para cada valor se ejecuta el cuerpo.
- Al final se elimina la ligadura de la variable y se evalúa la forma resultado. Si no hay, devuelve `NIL`.

```lisp
(dotimes (cont 4) (print (* cont cont)))
; imprime 0 1 4 9 ; devuelve NIL

(dotimes (x 5 '(fin)) (print (list x x)))
; imprime (0 0) (1 1) (2 2) (3 3) (4 4) ; devuelve (FIN)
```

### DOLIST

`(DOLIST (VAR L [resultado]) S1 ... SN)`

Asigna a `VAR` el primer elemento de `L`, evalúa `S1 ... SN`, y repite con el siguiente elemento. Cuando `L` no tiene más elementos, devuelve `resultado` (o `NIL` si no se indica).

```lisp
(dolist (x '(a b c))
  (print x))
; imprime A B C ; devuelve NIL
```

## 3. Funciones iterativas predefinidas

| Función | A qué aplica `fn` | Resultado |
|---|---|---|
| `(MAPCAR fn lista1 ... listan)` | A los sucesivos **CAR** de las listas (elemento a elemento) | Una lista con los resultados de cada llamada |
| `(MAPLIST fn lista1 ... listan)` | A los sucesivos **CDR** de las listas (la lista completa, luego sin el primero, etc.) | Una lista con los resultados de cada llamada |

Ambas usan `LIST` para construir el resultado.

```lisp
; MAPCAR
(mapcar '+ '(7 8 9) '(1 2 3))                   ; => (8 10 12)
(mapcar 'oddp '(7 8 9))                         ; => (T NIL T)
(mapcar 'atom '(A (B) 3))                       ; => (T NIL T)
(mapcar (lambda (x) (* x 2)) '(1 2 3 4))        ; => (2 4 6 8)

; MAPLIST
(maplist '+ '(7 8 9) '(1 2 3))                  ; => ((8 10 12) (10 12) (12))
(maplist 'cons '(1 2 3) '(a b c))               ; => (((1 2 3) A B C) ((2 3) B C) ((3) C))
```

Cómo leer MAPLIST: en la primera vuelta `fn` recibe las listas enteras, en la segunda los CDR, en la tercera los CDDR. Por eso `(maplist '+ '(7 8 9) '(1 2 3))` suma primero `(7 8 9)+(1 2 3)`, después `(8 9)+(2 3)` y por último `(9)+(3)`.

Propiedad útil de MAPCAR: **la salida tiene la misma longitud que la entrada** (una respuesta por elemento). Con una lista de entrada no filtra ni acumula.

## 4. Entrada/salida simple

- Las primitivas más usadas son **READ, PRINT y FORMAT**.
- Dispositivos por defecto: entrada el **teclado**, salida la **pantalla**; se pueden redireccionar. Todas las funciones toman un argumento opcional *input-stream* u *output-stream*.
- Si ese argumento no se da o es `nil`, se toma el valor de la variable `*standard-input*` (o la salida estándar). Si es `t`, se usa `*terminal-io*`.

### Entrada: READ

`(READ &optional stream)` lee **un objeto Lisp** del teclado y lo devuelve. **Detiene la ejecución** del programa hasta que se termine con RETURN.

```lisp
(read)             ; se tipea 35  => 35
(setq a (read))    ; se tipea HOLA => HOLA
a                  ; => HOLA
```

### Salida

| Función | Salto de línea | Strings con comillas | Detalle |
|---|---|---|---|
| `(PRINT obj)` | Sí: escribe en una **nueva línea** | Sí | Escribe los objetos por su tipo, tal como serían aceptados por READ; agrega un blanco detrás |
| `(PRIN1 obj)` | No: la próxima impresión queda al lado | Sí | Igual que PRINT pero sin salto de línea |
| `(PRINC obj)` | No | **No**: imprime los strings sin comillas | No escribe los objetos por su tipo |
| `(PPRINT obj)` | Introduce solo un Return | Sí | No realiza la segunda evaluación: devuelve `NIL` |
| `(TERPRI)` | Realiza un salto de línea | | |
| `(FORMAT destino control-string args...)` | Con la directiva `~%` | Según la directiva | Mecanismo más generalizado de salida |

```lisp
(print 'a)        ; imprime A con #\Newline
(print '(a b))    ; imprime (A B) con #\Newline
(print "hi")      ; imprime "hi" con #\Newline

(prin1 'a)        ; imprime A sin #\Newline
(prin1 "hi")      ; imprime "hi" sin #\Newline

(princ 'a)        ; imprime A sin #\Newline
(princ "hi")      ; imprime hi sin #\Newline   (sin comillas)

(pprint 'a)       ; imprime A      ; devuelve NIL
(pprint "abcd")   ; imprime "abcd" ; devuelve NIL
```

### FORMAT

`(FORMAT destino control-string &rest argumentos)`

- **destino**: `nil` (no imprime; crea un string y lo devuelve), `t` (salida por defecto, devuelve NIL) o un *stream*.
- **control-string**: el texto a escribir más las **directivas**, que comienzan con `~`.
- **argumentos**: los parámetros para las directivas.

| Directiva | Efecto |
|---|---|
| `~A` | Imprime un objeto cualquiera |
| `~D` | Imprime un número en base 10 |
| `~S` | Imprime una expresión simbólica |
| `~n@A` | Justifica a la derecha en `n` espacios (el `@` con `~A`) |
| `~%` | Inserta una nueva línea (no usa argumentos) |
| `~|` | Nueva página (no usa argumentos) |

```lisp
(FORMAT T "STRING DE SALIDA")
; imprime STRING DE SALIDA ; devuelve NIL

(SETQ VAR 5)
(FORMAT T "STRING QUE INCLUYE ~A" VAR)
; imprime STRING QUE INCLUYE 5 ; devuelve NIL

(FORMAT NIL "STRING QUE INCLUYE ~A" VAR)
; => "STRING QUE INCLUYE 5"      (no imprime: devuelve el string)

(FORMAT T "~%LA PRIMERA RESPUESTA ES ~5@A ~%Y LA SEGUNDA RESPUESTA ES ~3@A " (* 5 3 2) (/ 3 5))
; LA PRIMERA RESPUESTA ES    30
; Y LA SEGUNDA RESPUESTA ES 0.6

(format nil "hola soy ~a, ~a" "yo" "Bonn")    ; => "hola soy yo, Bonn"
```

**Comparación de las salidas con el mismo string**

| Expresión | Lo que se imprime | Lo que devuelve |
|---|---|---|
| `(princ "hola")` | `hola` | `"hola"` |
| `(print "hola")` | `"hola"` (en línea nueva) | `"hola"` |
| `(prin1 "hola")` | `"hola"` | `"hola"` |
| `(format t "hola")` | `hola` | `NIL` |
| `(format nil "hola")` | nada | `"hola"` |

Por esto, al llamar desde el intérprete a una función que termina en `print`, el valor aparece dos veces: una por la impresión y otra porque es el valor devuelto.

## 5. Erratas y diferencias con Common Lisp estándar

- `(mapcar '+ ...)` con el símbolo quoteado funciona; la forma habitual en Common Lisp es `#'+`.
- En `(dotimes (x 5 '(fin)) ...)` la diapositiva muestra `fin` como valor final; el valor devuelto es la lista `(FIN)`.
- `(/ 3 5)` impreso como `0.6` vale en el intérprete de la cátedra; SBCL imprime el racional `3/5`.
- En las diapositivas de PRINT, PRIN1 y PRINC los comentarios de los ejemplos están corridos una línea; los correctos son los de la sección 4.
- La variable de la salida estándar es `*standard-output*`; la diapositiva menciona solo `*standard-input*` para ambos casos.

## 6. Conceptos clave para el final

- Los 6 condicionales y cuándo evalúa cada uno; WHEN vs. UNLESS.
- COND: se evalúa la primera cláusula cuyo test es NO-NIL y se sale; valor si ninguna se cumple; `T` como caso por defecto.
- Las 4 formas iterativas y cómo termina cada una.
- DO: tres partes, asignación en paralelo, el test se evalúa antes que el cuerpo.
- DOTIMES cuenta de 0 a n-1.
- MAPCAR (sobre los CAR) vs. MAPLIST (sobre los CDR).
- Diferencias entre PRINT, PRIN1, PRINC y PPRINT.
- FORMAT: destino `t` vs. `nil`, y las directivas `~A`, `~D`, `~S`, `~%`.
