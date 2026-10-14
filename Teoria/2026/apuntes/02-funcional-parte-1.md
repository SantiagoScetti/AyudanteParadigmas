# 02 · Programación funcional, parte 1: introducción a LISP, tipos de datos, evaluación y números

Fuente: `diapositivas/PyL - 2026 - Funcional Parte 1.pdf` (42 diapositivas) · Prof. Msc. Ricardo Monzón
Programa: Unidad II, Tema 2.

## Índice

1. Introducción a LISP
2. Características de Common Lisp
3. Expresiones y tipos de valores
4. Tipo ATOM
5. Tipo CONS y listas
6. Listas punteadas
7. Evaluación: Lisp Listener y regla de evaluación
8. QUOTE
9. Funciones aritméticas
10. Funciones matemáticas (y las que modifican: INCF, DECF)
11. Predicados numéricos y de comparación
12. Operaciones aritméticas con listas
13. Erratas y diferencias con Common Lisp estándar
14. Conceptos clave para el final

---

## 1. Introducción a LISP

- Lisp fue propuesto por **John McCarthy a finales de los 50**.
- Implementa el **modelo de las funciones recursivas**, que proporcionan una definición sintáctica y semánticamente clara.
- **Las listas son la base tanto de los programas como de los datos.** Programas y datos son equivalentes.
- LISP es un acrónimo de **LISt Processing**.
- Proporciona un conjunto potente de funciones que manipulan listas, **implementadas internamente como punteros**.
- **Originalmente fue un lenguaje simple y pequeño**, consistente en funciones de construcción y acceso a listas, definición de nuevas funciones, pocos predicados para detectar igualdades y funciones para evaluar llamadas a funciones.
- Los principales **fundamentos de control son la recursión y las condicionales simples**.
- Todo programa LISP consiste de una función.
- **No posee asignaciones** (en su concepción pura).
- La principal estructura de datos es la **Lista**.
- Muchos programas de **Inteligencia Artificial** se implementaron en LISP, y muchos entornos modernos para sistemas expertos están implementados en Lisp.
- Usa **notación prefija o polaca**, y cumple el **principio de homoiconicidad**: el código tiene la misma estructura que los datos.

## 2. Características de Common Lisp

Se trabaja sobre Common Lisp. Sus seis características:

| Característica | Qué significa |
|---|---|
| **Portabilidad** | Excluye las características que no puedan ser implementadas en la mayoría de las máquinas. Diseñado para construir programas lo menos dependientes posible de las máquinas. |
| **Consistencia** | Muchas implementaciones LISP son internamente inconsistentes: el intérprete y el compilador pueden asignar distintas semánticas al mismo programa. La diferencia radica en que el intérprete considera que todas las variables tienen **alcance dinámico**. Common Lisp busca evitarlo. |
| **Expresividad** | Recoge las construcciones más útiles y comprensibles de dialectos Lisp anteriores. |
| **Eficiencia** | Tiene muchas características diseñadas para facilitar la producción de código compilado de alta calidad. |
| **Potencia** | Suministrada por multitud de paquetes que corren sobre el núcleo. |
| **Estabilidad** | El corazón cambia lentamente y solo cuando el grupo de expertos encargados del estándar lo decide por mutuo acuerdo, después de examinar y experimentar con las nuevas características. |

## 3. Expresiones y tipos de valores

- En Lisp **todo son expresiones evaluables**.
- La **regla de oro** de Lisp es la **evaluación de sus expresiones**. Existen diferentes reglas de evaluación según el tipo de expresión.
- Lisp **siempre trabaja internamente con apuntadores**: cada atributo no contiene el dato sino un apuntador al mismo.
- A menos que se diga lo contrario, convierte automáticamente las **minúsculas en mayúsculas**.

**Tipos de valores**

- El tipo **atom** (atómicos): un número, un carácter, un símbolo, un string.
- El tipo **cons**: una lista.
- Adicionalmente: una estructura definida por el usuario y tipos de datos propios del usuario.

El tipado es **totalmente dinámico** (depende del momento en que se hace la asignación). En un lenguaje convencional es necesario declarar el tipo; en Lisp no es necesario, aunque lo permite.

## 4. Tipo ATOM

Los átomos son estructuras básicas. Un átomo es un **elemento indivisible que tiene significado propio**.

**Números.** Lisp evalúa un número devolviendo ese mismo número: un número se apunta a sí mismo (en general, un átomo se apunta a sí mismo).

| Tipo | Ejemplos | Detalle |
|---|---|---|
| Enteros | `-2`, `-1`, `0`, `1`, `2` | No existe límite en la magnitud de un entero |
| Racionales | `-2/3`, `4/6`, `20/2`, `5465764576/764` | numerador / denominador |
| Coma flotante | `0.0`, `-0.5` | |
| Complejos | `#C(5 -3)`, `#C(5/3 7.0)` | `#C(5/3 7.0)` = `#C(1.66666 7.0)` |

**Caracteres y strings.** Se usan para manipular texto; se evalúan a sí mismos.

- Caracteres: comienzan con `#\` (`#\a`, `#\A`). Especiales no imprimibles: `#\SPACE`, `#\NEWLINE`.
- Strings: `"A"`, `"hola"`. Se pueden considerar series o vectores de caracteres. Su representación comienza y termina con `"`.

**Átomos simbólicos.** Representan algo más, como el nombre de una función o el valor de una variable.

- Todo nombre de variable debe ser un símbolo atómico. Ejemplos válidos: `A`, `CONT`, `VALOR-FINAL`, `UNA-LISTA`, `ENT45`.
- La evaluación de una **variable** es más complicada que la de los átomos simples: LISP intenta devolver **el valor de la variable**.
- Los nombres de símbolos **no distinguen mayúsculas de minúsculas** y pueden ser cualquier secuencia de caracteres alfanuméricos y de notación, **excepto**: `( ) . ' " ;`
- Un nombre de símbolo no puede estar compuesto solo por caracteres numéricos (un número se representa a sí mismo y es una constante).

**Constantes especiales.** Símbolos reservados que apuntan a sí mismos:

| Constante | Significado |
|---|---|
| `T` | true |
| `NIL` | false **o** lista vacía `()` |

## 5. Tipo CONS y listas

- La forma más importante y versátil de agrupar objetos es la **lista**: `(mesa silla lámpara estanterías)`.
- Una **lista** es una estructura básica de datos **y** una estructura de un programa en Lisp. Está delimitada por paréntesis y formada por una secuencia de átomos y/o listas, separados por un espacio. Puede no tener elementos: `NIL` o `()`.

```lisp
(1 2 3 4)            ; lista de enteros
(a b c d)            ; lista de variables
(#\a #\b #\c #\d)    ; lista de caracteres
(4 algo de "si")     ; lista con entero, variables y string
(sqrt 2)             ; lista con una función
(+ 1 3)              ; lista con una función
(a b (c d) e)        ; lista con átomos y sublistas
NIL  o  ()           ; lista vacía
```

Todos los programas en Lisp se describen mediante funciones que se **definen y llaman con listas**.

**La estructura CONS**

- Un **CONS** es una estructura de información que contiene **dos componentes: el CAR y el CDR**. Su utilización fundamental es representar listas.
- Una **lista se define recursivamente**: o es la lista vacía, o es un CONS cuyo componente CDR es una lista.
- Una lista es una **cadena de CONSES enlazados por sus CDR y terminada por NIL**.
- Los componentes CAR de los conses son los **elementos** de la lista. Hay **un CONS por cada elemento**. La lista vacía no tiene ningún elemento.
- El **CAR** contiene un apuntador al primer elemento. El **CDR** contiene un apuntador al siguiente CONS, o a `NIL` si no hay más elementos. Una lista es **unidireccional**.
- El átomo `A` **no** es una estructura CONS. La lista vacía `()` **no tiene** estructura CONS.

**Diagramas de cajas** (figuras de las diap. 18 a 21, redibujadas). Cada caja es un CONS: `[CAR | CDR]`; `/` significa CDR = NIL.

```
(A)                     [ A | / ]

(1 2 3)                 [ 1 | *-]--> [ 2 | *-]--> [ 3 | / ]

(A (B C))               [ A | *-]--> [ * | / ]
                                       |
                                       v
                                     [ B | *-]--> [ C | / ]
```

## 6. Listas punteadas

- Cuando el **CDR de un CONS apunta a un átomo** (en lugar de a otro CONS o a NIL), la lista formada es una **lista punteada** (*dotted list*), también llamada **par punteado**.

```
(A 4)      lista común        [ A | *-]--> [ 4 | / ]      (2 casillas CONS)

(A . 4)    lista punteada     [ A | 4 ]                    (1 casilla CONS)
```

- **Ventaja**: ahorro de una casilla CONS.
- **Desventajas**: se pierde flexibilidad, porque el tratamiento de la lista no puede depender de la marca de fin de lista; y no admite modificarla añadiendo nuevas casillas CONS (se eliminaría el último elemento).
- Sintaxis: después del punto debe aparecer **un objeto simple y luego el paréntesis de cierre**. Ejemplo erróneo: `(LU MA MI JU VI SEMANA SABADO . DOMINGO FIN-DE-SEMANA)`.

```
((LAS-LISTAS . PUEDEN) TENER VARIAS ESTRUCTURAS)

  [ * | *-]--> [TENER | *-]--> [VARIAS | *-]--> [ESTRUCTURAS | / ]
    |
    v
  [LAS-LISTAS | PUEDEN]                      <- par punteado: 1 casilla

((LAS-LISTAS PUEDEN) TENER VARIAS ESTRUCTURAS)

  [ * | *-]--> [TENER | *-]--> [VARIAS | *-]--> [ESTRUCTURAS | / ]
    |
    v
  [LAS-LISTAS | *-]--> [PUEDEN | / ]         <- lista propia: 2 casillas
```

## 7. Evaluación: el Lisp Listener

- El **Lisp Listener** es el ciclo evaluador que realiza continuamente Lisp; siempre está a la espera de entradas.
- Cuando recibe una entrada, la evalúa (espera el return si es atómica, o el paréntesis de cierre si es una lista), imprime el resultado y recomienza.
- Es el ciclo **READ-EVAL-PRINT**, expresado con funciones Lisp como `(PRINT (EVAL (READ)))`.
- El **evaluador** es el mecanismo que ejecuta las formas y los programas. Lisp siempre trata de evaluar todo lo que se le suministre, a través de la función `eval`: `(eval form)` evalúa la forma y devuelve el valor.

```lisp
> 3                          ; => 3
> "esto es un string"        ; => "esto es un string"
> A                          ; => Error: The variable A is unbound.
> T                          ; => T
> NIL                        ; => NIL
> (quote (+ 2 3))            ; => (+ 2 3)
> (eval (quote (+ 2 3)))     ; => 5
```

**Regla de evaluación de una expresión S**

1. Si S es un **átomo numérico** `a`, el resultado es ese mismo átomo.
2. Si S es de la forma `(f a1 a2 ... an)`, el intérprete **evalúa recursivamente cada argumento** `ai`, obteniendo valores `v1 ... vn`, y luego calcula el resultado de **aplicar f** a dichos valores.

```lisp
> (+ 1 2 3 (* 3 4))    ; => 18   (f es +; los argumentos son 1, 2, 3 y (* 3 4))
```

## 8. QUOTE o `'`

- Como LISP evalúa recursivamente cada argumento, a veces es fundamental **evitar la evaluación**: por ejemplo cuando un argumento es una lista que no denota la aplicación de una función sino una lista de elementos como **estructura de datos**.
- `quote` provoca que un objeto **no sea evaluado**. Es la forma de pasar una lista como datos.
- Se escribe `(QUOTE OBJETO)` o `'OBJETO`.

```lisp
> (quote X)            ; => X
> 'X                   ; => X
> A                    ; => Error: The variable A is unbound.
> 'A                   ; => A
> '(+ 2 3)             ; => (+ 2 3)
> (+ 2 3)              ; => 5
> (* (+ 2 3) (/ 12 4)) ; => 15
```

## 9. Funciones aritméticas

Reglas generales:

- Requieren que **todos sus argumentos sean números**; un argumento no numérico provoca error.
- Operan sobre enteros y reales, ajustando cuando son de distinto tipo. Devuelven **decimal cuando algún argumento no es entero**.
- **Ninguna modifica el valor de sus argumentos**, solo devuelven un resultado.

| Función | Qué hace | Un argumento | Sin argumentos | Ejemplos |
|---|---|---|---|---|
| `+` | Suma de todos los argumentos | lo suma a cero | `0` | `(+ 1 2 3)` → `6`; `(+ 1.0 2 3)` → `6.0` |
| `-` | Restas sucesivas: al primero le resta la suma del resto | lo resta de cero (cambia el signo) | error | `(- 10 1 2 3)` → `4`; `(- 10 1 2.0 3)` → `4.0` |
| `*` | Producto de todos los argumentos | lo multiplica por uno | `1` | `(* 1 2 3)` → `6`; `(* 1 2 3.0)` → `6.0` |
| `/` | Divide el primero por el producto del resto | lo divide por uno (según la diapositiva) | error | `(/ 30 2 4)` → `3` (según la diapositiva); `(/ 30 2.0 4)` → `3.75` |

**Obtener enteros**

| Función | Qué hace | Ejemplo |
|---|---|---|
| `(truncate expr)` | Trunca tendiendo hacia 0 | `(truncate 3.14)` → `3` y `0.14...` |
| `(round expr)` | Redondea al entero más cercano | `(round 3.123)` → `3` y `0.123...`; `(round 3.723)` → `4` y `-0.277...` |

Ambas **entregan dos resultados**: el de la operación y el **remanente**.

**Otras funciones aritméticas**

| Función | Qué hace | Ejemplo |
|---|---|---|
| `(float expr)` | Convierte un entero en coma flotante | `(float 8)` → `8.0` |
| `(rational expr)` | Convierte un real en racional | `(rational 2.5)` → `5/2` |
| `(rem a b)`, `(mod a b)` | Remanente de la división | `(rem 7 2)` → `1` |
| `(abs expr)` | Valor absoluto | `(abs -8)` → `8` |
| `(signum expr)` | Signo: `0` para 0, `1` positivos, `-1` negativos | `(signum -8)` → `-1` |
| `(max n n ...)` | Mayor de una lista de números | `(max 2 5 3 1)` → `5` |
| `(min n n ...)` | Menor | `(min 2 5 3 1)` → `1` |
| `(gcd n n ...)` | Máximo común divisor. Sin argumentos: `0`. Un argumento: ese mismo | `(gcd 12 34 56)` → `2` |
| `(lcm n n ...)` | Mínimo común múltiplo. Sin argumentos: error. Un argumento: ese mismo | `(lcm 12 34 56)` → `2856` |

## 10. Funciones matemáticas

| Función | Qué hace | Ejemplos |
|---|---|---|
| `(sqrt n)` | Raíz cuadrada | `(sqrt 16)` → `4.0`; `(sqrt 2)` → `1.414...`; `(sqrt -4)` → `#C(0.0 2.0)` |
| `(expt base exp)` | Potencia | `(expt 2 3)` → `8`; `(expt 3 -2)` → `0.1111`; `(expt 3 0)` → `1` |

Hasta aquí, **ninguna función modifica el valor de sus argumentos**.

**Las que sí modifican: INCF y DECF**

| Función | Qué hace |
|---|---|
| `(incf var [delta])` | Incrementa `var` en `delta` (por defecto 1). `var` debe ser una variable |
| `(decf var [delta])` | Decrementa `var` en `delta` (por defecto 1) |

```lisp
; suponemos que C vale 5
> (incf C 10)    ; => 15
> C              ; => 15
> (incf C)       ; => 16
> C              ; => 16

; en cambio, con C = 5, una operación aritmética NO modifica C:
> (- C 1)        ; => 4
> C              ; => 5

> (decf C 10)    ; => -5     (con C = 5)
> (decf C)       ; => -6
> C              ; => -6
```

INCF y DECF **modifican el valor de los argumentos** pasados como parámetros: son el primer ejemplo de funciones destructivas (ver apunte 03).

## 11. Predicados

Los **predicados** son **funciones booleanas**: devuelven solo los valores `T` o `NIL`.

**De comparación de números**

| Predicado | Significado | Ejemplos |
|---|---|---|
| `(= n n ...)` | Igualdad | `(= 3 3.0)` → `T` |
| `(/= n n ...)` | No igual | `(/= 3 3.0)` → `NIL` |
| `(< n n ...)` | Secuencia estrictamente creciente | `(< 3 5 8)` → `T`; `(< 3 5 4)` → `NIL` |
| `(> n n ...)` | Secuencia estrictamente decreciente | `(> 8 5 3)` → `T`; `(> 8 3 5)` → `NIL` |
| `(<= n n ...)` | Secuencia no estrictamente creciente | `(<= 5 5 8)` → `T`; `(<= 9 9 4)` → `NIL` |
| `(>= n n ...)` | Secuencia no estrictamente decreciente | `(>= 9 7 7)` → `T`; `(>= 8 9 8)` → `NIL` |

**Predicados numéricos** (aceptan un solo argumento)

| Predicado | Verifica | Argumento | Ejemplos |
|---|---|---|---|
| `(numberp obj)` | Si es un número | cualquier tipo | `(numberp 7)` → `T`; `(numberp 'nombre)` → `NIL` |
| `(integerp obj)` | Si es un entero | cualquier tipo | `(integerp 7)` → `T`; `(integerp 'nombre)` → `NIL` |
| `(oddp entero)` | Si es impar | debe ser entero | `(oddp -7)` → `T` |
| `(evenp entero)` | Si es par | debe ser entero | `(evenp 8)` → `T`; `(evenp 'nombre)` → ERROR |
| `(zerop n)` | Si es cero | debe ser numérico | `(zerop 0.0)` → `T`; `(zerop 'nombre)` → ERROR |

Para recordar: `numberp` e `integerp` aceptan cualquier objeto y devuelven NIL si no corresponde; `oddp`, `evenp` y `zerop` dan **error** si el argumento no es del tipo esperado.

## 12. Operaciones aritméticas con listas

En el intérprete de la cátedra (XLISP-STAT) los operadores aritméticos aceptan listas como términos. Reglas ("Consideraciones"):

1. Los términos solo pueden ser **numéricos**.
2. Un término puede ser el resultado de otra función matemática.
3. Si **todos los términos son átomos**, el resultado es un **átomo**.
4. Si **al menos un término es una lista**, el resultado es una **lista con la estructura de la lista de mayor profundidad**.
5. Si hay **más de una lista**, deben ser de la **misma longitud en el primer nivel**, independientemente de la profundidad.
6. La operación se ejecuta **de izquierda a derecha, término a término**, y dentro de cada término, elemento a elemento.

| Caso | Ejemplo | Salida |
|---|---|---|
| Átomos | `(+ 1 -2 3.5)` | `2.5` |
| | `(- 1 '-2 3.5)` | `-0.5` |
| | `(* 1 '-2 3.5)` | `-7.0` |
| | `(/ 1 -2 3.5)` | `-0.142857...` |
| Listas de igual longitud | `(+ '(1 -2 3.5) '(4 5 6))` | `(5 3 9.5)` |
| | `(+ '(1 -2 3.5) '(4 5 6) '((2 4) (3) (((5) 2))))` | `((7 9) (6) (((14.5) 11.5)))` |
| | `(- '(1 -2 3.5) '(4 5 6))` | `(-3 -7 -2.5)` |
| | `(* '(1 -2 3.5) '(4 5 6))` | `(4 -10 21.0)` |
| | `(/ '(1 -2 3.5) '(4 5 6))` | `(0.25 -0.4 0.583)` |
| Listas de distinta longitud | `(+ '(1 2 3) '(4 5))` | Error: arguments not all the same length |
| Átomos y listas | `(+ 1 '(2 -3 4) 5)` | `(8 3 10)` |
| | `(+ 1 '(2 -3 4) 5 '(4 7))` | Error: arguments not all the same length |
| | `(+ 1 '(2 -3 4) 5 '(4 (7) ((2))))` | `(12 (10) ((12)))` |
| | `(- 1 '(2 -3 4) 5)` | `(-6 -1 -8)` |
| | `(* 1 '(2 -3 4) 5)` | `(10 -15 20)` |
| | `(/ 1 '(2 -3 4) 5)` | `(0.1 -0.066 0.05)` |

Con `expt`:

| Argumento 1 | Argumento 2 | Ejemplo | Salida |
|---|---|---|---|
| número | número | `(expt 3 2)` | `9` |
| número | función | `(expt 3 (- 6 4))` | `9` |
| función | función | `(expt (/ 21 7) (- 6 4))` | `9` |
| número | lista | `(expt 2 '(1 2 3))` | `(2 4 8)` |
| lista | número | `(expt '(1 2 3) 2)` | `(1 4 9)` |
| lista | lista | `(expt '(1 2 3) '(3 3 3))` | `(1 8 27)` |
| lista | lista | `(expt '(3 3 3) '(1 2 3))` | `(3 9 27)` |
| lista | lista (distinta longitud) | `(expt '(3 3) '(1 2 3))` | Error: arguments not all the same length |

## 13. Erratas y diferencias con Common Lisp estándar

Para corregir o explicar, conviene saber qué es propio del intérprete de la cátedra. En el final vale lo que dicen las diapositivas.

- **Aritmética sobre listas** (sección 12): funciona en XLISP-STAT. En Common Lisp estándar (SBCL, CLISP) `(+ '(1 2) '(3 4))` da error de tipo.
- La diapositiva de INCF muestra `(- 1 C)` → `4` con C = 5; el valor correcto de esa expresión es `-4`. La intención es `(- C 1)` → `4`, que es como quedó arriba.
- La diapositiva muestra `(eval quote(+ 2 3))`; la forma correcta es `(eval (quote (+ 2 3)))`.
- `(expt 3 -2)`: la diapositiva dice `0,1111`; SBCL devuelve el racional `1/9`.
- `(/ 30 2 4)`: la diapositiva dice `3`; SBCL devuelve `15/4`. Con un solo argumento, `(/ 4)` devuelve el recíproco `1/4`, no "dividido por uno".
- `(oddp 5.8)`: la diapositiva dice `NIL`; en Common Lisp estándar es error (el argumento debe ser entero, como dice la propia definición).
- "No posee asignaciones" se refiere al LISP puro; Common Lisp tiene `setq` y `setf` (apuntes 03 y 05).

## 14. Conceptos clave para el final

- Origen: McCarthy, fines de los 50; LISt Processing; modelo de funciones recursivas.
- Programas y datos son equivalentes (homoiconicidad); notación prefija.
- Fundamentos de control del LISP original: recursión y condicionales simples.
- Las 6 características de Common Lisp (portabilidad, consistencia, expresividad, eficiencia, potencia, estabilidad).
- Tipos de valores: atom y cons; tipado dinámico.
- Qué es un átomo; `T` y `NIL` (false o lista vacía).
- Definición de CONS (CAR y CDR), definición recursiva de lista, un CONS por elemento; saber dibujar cajas.
- Lista punteada: cuándo se forma, ventaja y desventajas.
- Lisp Listener: ciclo `(PRINT (EVAL (READ)))`.
- Regla de evaluación y para qué sirve `quote`.
- Las funciones aritméticas no modifican argumentos; `incf` y `decf` sí.
- Qué es un predicado; cuáles dan error con argumentos no numéricos.
- Reglas de la aritmética con listas (estructura de la lista de mayor profundidad; misma longitud en el primer nivel).
