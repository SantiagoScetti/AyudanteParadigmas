# 05 · Programación funcional, parte 4: SETF y LET, lambda, DEFUN, ámbito, recursividad, TRACE, streams y documentación

Fuente: `diapositivas/PyL - 2026 - Funcional Parte 4.pdf` (36 diapositivas) · Prof. Msc. Ricardo Monzón
Programa: Unidad II, Temas 2 y 4.

## Índice

1. Asignación: SETF
2. Variables locales: LET y LET*
3. Funciones sin nombre: LAMBDA
4. Funciones definidas por el usuario
5. DEFUN
6. Ligadura de parámetros
7. Ámbito léxico y dinámico: DEFVAR, DEFPARAMETER, DEFCONSTANT
8. Asignación en paralelo y secuencial: DO*
9. Recursividad
10. Seguimiento de funciones: TRACE
11. Streams
12. Documentación y comentarios
13. Erratas y diferencias con Common Lisp estándar
14. Conceptos clave para el final

---

## 1. Asignación: SETF

- `SETF` se usa como `SETQ` para asignar valores a variables. Sintaxis: `(SETF {LUGAR FORM}+)`.
- **Diferencia con SETQ**: SETF usa la forma **lugar** para determinar una **localización o dirección** en la que hay que realizar la asignación. El lugar puede ser una variable o una forma de función aceptable que evalúa un lugar al que asignar un valor (por ejemplo `(car x)`).
- Como SETQ, realiza las evaluaciones y asignaciones **secuencialmente** y devuelve **el valor de la última evaluación**.

```lisp
(SETF NOMBRE "MARIA")              ; => "MARIA"
(SETF X '(A B C))                  ; => (A B C)
(SETF (CAR X) (CAR '(1 2 3)))      ; => 1
X                                  ; => (1 B C)
```

En el tercer ejemplo se ve la utilidad de SETF: se reemplaza el contenido de una **posición** por el resultado de una función.

## 2. Variables locales: LET y LET*

`(LET ({VARIABLE}* / {VARIABLE FORMA}*) {DECLARATIONS}* CUERPO)`

- `LET` permite crear **variables locales** interiores a una función. Consta de dos partes: **asignación de variables** y **cuerpo**.
- La asignación de variables es una lista de listas; cada una tiene un nombre de variable y una forma a evaluar.
- Las formas se evalúan asignando valores **en paralelo** a todas las variables. Para que se asignen **secuencialmente** se usa **`LET*`**.
- El cuerpo del LET es como el cuerpo de un DEFUN.
- Cualquier valor previo que tuvieran variables con el mismo nombre **se guarda y se restaura** al finalizar el LET.
- Las variables creadas en el LET son **locales** al LET: no pueden ser accedidas desde el exterior (igual que con DEFUN).

**LET vs. SET**

- Los parámetros del LET se ligan **solo dentro del cuerpo del LET**.
- Las asignaciones (SETF/SETQ) sobre un parámetro del LET **no crean ni modifican variables globales**.
- Las asignaciones sobre **variables libres** (las que no son parámetros del LET) **crean o cambian valores globales**.

```lisp
(SETF X 5)
(SETF E 0)
(SETF TRIPLE 0)
(LET ((D 2) (E 3) (CUADRUPLE))
  (SETF DOBLE (* D X))
  (SETF TRIPLE (* E X))
  (SETF CUADRUPLE (* 4 X)))        ; => 20
```

| Después del LET | Valor | Por qué |
|---|---|---|
| `D` | ERROR: unbound variable | Es local al LET |
| `E` | `0` | La `E` del LET era local; se restaura la global definida afuera |
| `DOBLE` | `10` | Variable libre: el SETF dentro del LET la creó como global |
| `TRIPLE` | `15` | Variable libre: el SETF la modificó (usó la `E` local, que valía 3) |
| `CUADRUPLE` | ERROR: unbound variable | Es parámetro del LET: local |

Los valores de las variables libres pueden modificarse durante la ejecución del LET.

## 3. Funciones sin nombre: LAMBDA

- A veces es deseable crear funciones **sin nombre**. Se conocen como **lambda-expresiones** y tienen una estructura semejante a la de las funciones.

```lisp
((lambda (p1 ... pn) cuerpo) a1 ... an)
```

- El comportamiento es semejante al de una función, con la diferencia de que `a1 ... an` ya son los argumentos pasados a la función.

```lisp
((lambda (x y) (cons (car x) (cdr y))) '(a b) '(c d))    ; => (A D)
((lambda (a b) (* a b)) 4 8)                             ; => 32
(mapcar (lambda (x) (* x 2)) '(1 2 3 4))                 ; => (2 4 6 8)   (uso típico)
```

## 4. Funciones definidas por el usuario

- Una **función** es un objeto Lisp que puede invocarse como un procedimiento. Puede tomar una serie de argumentos y **devolver uno o más valores, pero al menos uno**.
- Lisp tiene un gran número de funciones predefinidas, llamadas **primitivas**, y también permite definir funciones propias.
- Lisp es un lenguaje funcional en el que **todos los programas se escriben como colecciones de funciones y procedimientos**.
- La definición de la función se almacena en memoria como un **atributo/objeto del símbolo**.
- Una función se referencia por el nombre imprimible de un símbolo. La **llamada** es una lista cuyo primer elemento es el nombre de la función y el resto son los parámetros.
- Lisp comprueba que el primer elemento de la lista corresponda a alguna función predefinida o del usuario. Los **argumentos se evalúan antes** de pasárselos a la función.
- Si un argumento es a su vez una llamada a función, **se evalúa primero** y su resultado se pasa a la función principal.

```
ENTRADA:                    (+ 3 (* 2 4))
EVALUACION DE ARGUMENTOS:   (+ 3 8)
SALIDA:                     11
```

## 5. DEFUN

`(DEFUN nombre-función lambda-lista {declaraciones | string-doc} cuerpo)`

- **DEFUN** (DEfine FUNction) permite al usuario definir sus propias funciones.
- Una función consta de **tres partes: nombre, argumentos y cuerpo** (lo que se suele llamar lambda-expresión).
- `nombre-función` debe ser un **símbolo atómico**, como para una variable.
- La **lambda-lista** es el conjunto de argumentos que se pueden pasar.
- El **cuerpo** es cualquier forma a evaluarse en secuencia cuando se invoca la función.

```lisp
(defun PRIMERO (L) (CAR L))        ; => PRIMERO
(PRIMERO '(A B C))                 ; => A

(defun RESTO (L) (CDR L))          ; => RESTO
(RESTO '(A B C))                   ; => (B C)
```

El parámetro `L` es una **variable local**: solo es accesible desde el interior de la función. Si hay una variable externa con igual nombre, la `L` del cuerpo se refiere al argumento.

**Declaraciones y string de documentación**

- Las **declaraciones** proporcionan información extra al sistema; a menudo son mensajes utilizados por el compilador.
- Los **strings de documentación** describen comandos y pueden imprimirse al invocar la función de documentación.

```lisp
(defun CUADRADO (x)
  "Esta función devuelve el cuadrado de un número"
  (* x x)   ; fin de CUADRADO
  )                                ; => CUADRADO
(CUADRADO 3)                       ; => 9
```

**Qué sucede al definir y al llamar una función**

- Al definir `CUADRADO`, Lisp **crea un símbolo** `CUADRADO` e incorpora en su definición de función el valor correspondiente.
- **Evaluar un DEFUN devuelve el nombre de la función** (`CUADRADO`).
- Al **llamar** a la función, el valor que devuelve es el de la **última forma ejecutada** en el cuerpo.

```lisp
(cuadrado 3)                       ; => 9
(cuadrado 2)                       ; => 4
(cuadrado (cuadrado 3))            ; => 81
(cuadrado (+ -4 5 (/ 3 1)))        ; => 16
```

**Cantidad de argumentos**

```lisp
(defun SUMA-CUADRADO (x y)
  (+ (cuadrado x) (cuadrado y)))   ; => SUMA-CUADRADO
(suma-cuadrado 2 3)                ; => 13

(defun SALUDO () (print "hola a todos"))    ; función sin parámetros
(saludo)
; "hola a todos"      <- acción del PRINT
; "hola a todos"      <- valor devuelto por la función
```

## 6. Ligadura de parámetros en la función

- Las variables creadas en la lista de argumentos de un DEFUN (**parámetros formales**) son normalmente **locales** para la función.
- La lista de parámetros organiza un espacio en memoria para el ámbito de definición de la función, que será usado por los valores que se pasen en la llamada.

```lisp
(defun mi-funcion (varx) varx)     ; => MI-FUNCION
(mi-funcion "vale")                ; => "vale"
varx                               ; => ERROR, UNBOUND VARIABLE
```

Cuatro reglas:

1. La lista de parámetros **apunta a los mismos valores** que los correspondientes argumentos en la expresión de llamada.
2. Cuando termina la ejecución de la función **se desligan** los valores de la lista de parámetros.
3. Las variables de la lista de parámetros **no afectan** a las variables que se encuentran fuera del procedimiento.
4. Las variables ligadas de la lista de argumentos **no pueden ser accedidas por otras funciones** llamadas desde la misma (a no ser que se pasen como argumentos).

## 7. Ámbito léxico y dinámico

| | Ámbito léxico | Ámbito dinámico |
|---|---|---|
| Qué variables | Todas, a menos que se declaren de otra forma. Por ejemplo los parámetros de una función | Las variables declaradas **especiales** |
| Desde dónde se ven | Solo dentro del **texto** de la función (o forma) donde se definen | Son variables libres accesibles **desde cualquier parte del programa**, a partir del punto en que fueron definidas |
| Equivale a | Variable local | Variable **global** de otros lenguajes |

Para declarar variables especiales para todas las funciones, sin declararlas en cada una:

| Forma | Qué declara |
|---|---|
| `(DEFVAR nom-var [valor])` | Una **variable global** accesible desde cualquier función |
| `(DEFPARAMETER nom-var [valor])` | Igual que DEFVAR, pero se usa como **parámetro** y no como variable |
| `(DEFCONSTANT nom-var valor)` | Una **constante**: el valor permanece constante; si se intenta cambiar da error |

```lisp
(defconstant c 36)     ; => C
c                      ; => 36
(setf c 40)            ; => Error: C has constant value 36 and cannot be changed to 40
```

## 8. Asignación en paralelo y secuencial

| Asigna en paralelo | Asigna secuencialmente |
|---|---|
| `LET` | `LET*` |
| `DO` | `DO*` |
| `PROG` | `PROG*` |

Con asignación secuencial, una variable puede usar en su valor inicial a las variables declaradas antes que ella.

```lisp
; exponente con DO*: contador usa a exponente, ya inicializado
(defun exponente (m n)
  (do* ((resultado m (* m resultado))
        (exponente n (1- exponente))
        (contador (1- exponente) (1- exponente)))
       ((zerop contador) resultado)))

; exponente con DOTIMES y una variable local
(defun exponencial-con-times (m n)
  (let ((resultado 1))
    (dotimes (cuenta n resultado)
      (setf resultado (* m resultado)))))

(exponencial-con-times 4 3)        ; => 64
```

## 9. Recursividad

**Definición.** Se dice que un proceso es **recursivo cuando está basado en su propia definición**. En programación, la recursividad **no es una estructura de datos, sino una técnica de programación** que permite que un bloque de instrucciones se ejecute una cantidad n de veces. En muchas ocasiones **reemplaza a las estructuras repetitivas**.

En LISP es común que las funciones se llamen a sí mismas en el cuerpo de la función: eso es una **función recursiva**.

**Características de la programación recursiva**

- Implementación **intuitiva y elegante**.
- La traducción de la solución recursiva de un problema (**caso base y caso recursivo**) a código Lisp es prácticamente inmediata.
- Útil cuando hay **varios niveles de anidamiento**: la solución para un nivel es válida para el resto.
- La interpretación y comprensión del código **puede ser compleja**.

```lisp
; 1. Factorial (n!)
(defun factorial (n)
  (if (= n 0) 1
      (* n (factorial (- n 1)))))

; 2. Potencia (x^m)
(defun potencia (x m)
  (if (= m 0) 1
      (* x (potencia x (- m 1)))))

; 3. Fibonacci, método iterativo
(defun fibonacci (n)
  (do ((i 1 (1+ i))
       (fib1 0 fib)
       (fib 1 (+ fib fib1)))
      ((= i n) fib)))

; 3. Fibonacci, método recursivo
(defun fibo-recur (x)
  (if (< x 2)
      x
      (+ (fibo-recur (1- x)) (fibo-recur (- x 2)))))
```

En los tres casos recursivos se distinguen el **caso base** (el que corta: `n = 0`, `m = 0`, `x < 2`) y el **caso recursivo** (la llamada a sí misma con un argumento más chico).

## 10. Seguimiento de funciones: TRACE

- Para saber exactamente cómo trabaja una función en un punto del código, el *Break* y el depurador son indispensables, pero trabajosos y lentos.
- A veces alcanza con saber que una función fue llamada y qué valor devolvió. **TRACE** imprime **el nombre de la función y sus argumentos a la entrada**, y **el nombre y sus valores a la salida**, **sin cambiar el código fuente**.

| Forma | Efecto |
|---|---|
| `(trace f1 f2 ...)` | Activa el seguimiento de esas funciones |
| `(trace)` sin argumentos | Muestra la lista de funciones que están siendo seguidas |
| `(untrace f1 ...)` | Desactiva el seguimiento de esas funciones |
| `(untrace)` sin argumentos | Detiene el seguimiento de **todas** las funciones |

```lisp
(trace factorial fibo potencia)    ; => (FACTORIAL FIBO POTENCIA)

(fibo 4)
; Entering: FIBO, Argument list: (4)
;  Entering: FIBO, Argument list: (3)
;   Entering: FIBO, Argument list: (2)
;   Exiting: FIBO, Value: 1
;   Entering: FIBO, Argument list: (1)
;   Exiting: FIBO, Value: 1
;  Exiting: FIBO, Value: 2
;  Entering: FIBO, Argument list: (2)
;  Exiting: FIBO, Value: 1
; Exiting: FIBO, Value: 3
; 3
```

## 11. Streams

- Un **stream** es un tipo de datos que **mantiene la información sobre el dispositivo (fichero) al que está asociado**. Hace que las E/S sean **independientes del dispositivo**.
- Puede estar conectado a un fichero o a un terminal interactivo.

**Abrir y cerrar**

- `(OPEN nomfich &key :direction)` devuelve un stream. `nomfich` es un string, pathname o stream. `:direction` puede ser `:input` (lectura), `:output` (escritura) o `:io` (ambos).
- `(CLOSE stream)` cierra el stream: desaparece la ligadura entre el fichero y el stream.

```lisp
(setq f (open 'mine :direction :output))    ; crea un archivo llamado MINE
(print "Primer Hola Mundo" f)               ; escribe en el archivo
(print "Segundo Hola Mundo" f)
(close f)                                   ; cierra el archivo

(setq f (open 'mine :direction :input))     ; lo abre como entrada
(read f)                                    ; => "Primer Hola Mundo"
(read f)                                    ; => "Segundo Hola Mundo"
(close f)
```

**Predicados**

| Predicado | Da `T` si... |
|---|---|
| `(STREAMP objeto)` | el objeto es un stream |
| `(OUTPUT-STREAM-P stream)` | el stream es de salida |
| `(INPUT-STREAM-P stream)` | el stream es de entrada |

**Streams estándar**: `*standard-input*`, `*standard-output*`, `*error-output*`, `*terminal-io*`.

**Funciones de entrada**

| Función | Qué lee |
|---|---|
| `(READ-CHAR &optional stream)` | Un carácter; lo devuelve como objeto de tipo carácter |
| `(READ-LINE &optional stream)` | Caracteres hasta encontrar `#\newline`; devuelve la línea como string sin el newline |
| `(PEEK-CHAR &optional peek-type stream)` | Un carácter **sin eliminarlo** del stream: la próxima lectura devuelve el mismo. Si `peek-type` es `t`, salta los blancos |

**Manipulación de ficheros**

| Función | Qué hace |
|---|---|
| `(RENAME-FILE fichero nuevo-nombre)` | Cambia el nombre de un fichero |
| `(DELETE-FILE fichero)` | Borra un fichero |
| `(FILE-LENGTH stream)` | Devuelve la longitud del fichero (o `nil` si no puede determinarse) |
| `(LOAD fichero &key :verbose :print :if-does-not-exist)` | **Carga un fichero al intérprete**: el entorno pasa a contar con los objetos definidos en él |

Claves de LOAD: `:verbose` en `t` muestra un comentario con las características del fichero; `:print` en `t` muestra el valor de cada expresión cargada; `:if-does-not-exist` en `nil` devuelve `nil` y en `t` el error correspondiente.

## 12. Documentación y comentarios

Los comentarios empiezan con `;`. Por convenio:

| Cantidad | Uso |
|---|---|
| `;;;;` (4 y un blanco) | Al comienzo del fichero, para indicar su contenido |
| `;;;` (3 y un blanco) | Comentario sobre una función, en la línea posterior a su cabecera |
| `;;` (2 y un blanco) | Comentario de una línea de código, en la línea inmediatamente seguida |
| `;` (1, sin blanco) | Explicación de una línea de código en la misma línea |

```lisp
;;;; ***************************************************
;;;; Fichero: Ejemplo-comentario.lisp
;;;; Fecha-de-creación: 20/02/2014
;;;; Modulo: Apuntes de lisp.
;;;; Comentarios: Este fichero ha sido creado con fines didácticos.
;;;; Autores: Los profesores de Paradigmas - UNNE
;;;; ***************************************************

(defun pareja (x)
  ;;; Esta función devuelve la pareja del personaje que se pasa como valor del parámetro x.
  (case x
    ;; se realiza la selección.
    ((Peter-pan) "Campanilla")    ;Campanilla es una chica que vuela.
    ((Mortadelo) "Filemón")       ;Ambos son agentes de la T.I.A.
    (t "no tiene pareja")
    ) ;Fin de selección
  ) ;Fin de la función.
;;;; Fin del fichero.
```

## 13. Erratas y diferencias con Common Lisp estándar

- El título de la diapositiva dice "LET vs SET", pero los ejemplos usan `SETF`. La idea es la misma: asignar sobre una variable libre afecta a la global.
- En la forma general de lambda la diapositiva escribe los argumentos como `'(a1 ... an)`; son argumentos separados, como muestran los propios ejemplos.
- La traza de `(fibo 4)` de la diapositiva tiene la indentación corrida; arriba está acomodada. El valor final `3` es correcto.
- En el ejemplo de streams los comentarios dicen "retorna" para los `print` sobre el archivo: escriben en el archivo además de devolver el string.
- Los streams estándar se escriben `*standard-input*` y `*standard-output*` (con "d"); la diapositiva omite la "d".

## 14. Conceptos clave para el final

- SETF vs. SETQ: SETF asigna en un "lugar" (por ejemplo `(car x)`).
- LET: variables locales, asignación en paralelo, se restauran los valores previos; LET* es secuencial.
- Qué pasa con las variables libres asignadas dentro de un LET.
- Lambda-expresión: función sin nombre.
- DEFUN: tres partes; devuelve el nombre de la función; la llamada devuelve la última forma del cuerpo.
- Las cuatro reglas de la ligadura de parámetros.
- **Ámbito léxico vs. dinámico**; DEFVAR, DEFPARAMETER y DEFCONSTANT.
- Pares paralelo/secuencial: LET/LET*, DO/DO*, PROG/PROG*.
- Definición de recursividad ("técnica de programación, no estructura de datos"), sus cuatro características, caso base y caso recursivo.
- Para qué sirve TRACE y cómo se desactiva.
- Qué es un stream, OPEN con `:direction`, CLOSE y LOAD.
- La convención de 1 a 4 puntos y coma.
