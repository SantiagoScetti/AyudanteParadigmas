# Guía del ayudante — Cómo explicar bien MAPCAR (TP5)

Pensada para vos: los errores más comunes al armar un `mapcar`, con el código mal armado al lado del corregido y la explicación de **por qué** falla. Incluye la resolución a la duda sobre `#'` vs `'`.

---

## 1. La idea que hay que dejar clara antes de cualquier ejemplo

`mapcar` recorre una o varias listas y devuelve una lista **nueva, del mismo largo**, con el resultado de aplicarle una función a cada elemento (o a cada combinación de elementos, si son varias listas). No hace falta escribir el recorrido a mano con recursión — pero **la función que le pasás tiene que devolver siempre un valor por cada elemento que recibe**, ni más ni menos.

```lisp
(mapcar 'evenp '(1 2 3 4))          ;; -> (NIL T NIL T)
(mapcar '+ '(1 2 3) '(10 20 30))    ;; -> (11 22 33)      dos listas en paralelo
```

## 2. Dos formas de decirle a MAPCAR qué función aplicar — y tu duda sobre `#'`

**a) Nombrar una función ya definida**, pasándola con comilla simple:
```lisp
(mapcar 'car lista-de-sublistas)
```
**Sobre el `#'`:** en el XLISP que usa la cátedra, `'nombre-funcion` y `#'nombre-funcion` son **equivalentes** para este uso — ambos le indican a `mapcar` "aplicá la función que tiene este nombre". Si ves a un alumno escribir `#'estado` en vez de `'estado`, no está mal, pero conviene sugerirles que usen la comilla simple (`'`) para no manejar dos sintaxis distintas para la misma idea (ya usan `'` para citar listas y símbolos en todo lo demás). La diferencia entre `'` y `#'` importa en otros Lisps más estrictos (Common Lisp "de verdad", donde variables y funciones viven en espacios separados), pero acá no es el problema que les va a hacer perder puntos.

**b) Escribir la función ahí mismo, sin nombre, con `lambda`:**
```lisp
(mapcar (lambda (x) (* x 2)) lista)
```
Esta es la forma que **conviene usar siempre** que:
- la lógica necesita un `cond`/`if` adentro (más de un resultado posible), o
- depende de un dato extra que no viene de ninguna lista (un umbral, un límite, un texto fijo).

No hace falta `#'(lambda ...)`: alcanza con `(lambda (parametros) cuerpo)` tal cual.

---

## 3. Errores uno por uno

### 3.1 Pasar un dato suelto como si fuera otra lista
```lisp
; MAL
(defun mayores-a (lista umbral)
    (mapcar 'mayor-p lista umbral))     ; <- "umbral" es UN número, no una lista
```
`mapcar` espera que **todos** los argumentos después de la función sean listas, y toma un elemento de cada una por vuelta. Si `umbral` es un átomo (por ejemplo `50`), esto da error directamente. Es el error más común: confundir "un dato fijo que necesito adentro" con "otra lista para recorrer en paralelo".

```lisp
; BIEN — el lambda "ve" umbral porque es un parámetro de la función que lo contiene
(defun mayores-a (lista umbral)
    (mapcar (lambda (x) (> x umbral)) lista))
```
Esto se llama **cierre léxico** (*closure*): el `lambda` puede usar cualquier variable que esté visible en la función donde está escrito, sin que se la tengas que pasar como si fuera una lista más.

### 3.2 Multiplicar funciones auxiliares sueltas en vez de un lambda con `cond`
```lisp
; MAL — funciona, pero es innecesariamente largo y disperso
(defun rapido-p (dias) (<= dias 7))
(defun normal-p (dias) (and (> dias 7) (<= dias 15)))
(defun etiqueta (dias)
    (cond
        ((rapido-p dias) "rapido")
        ((normal-p dias) "normal")
        (T "demorado")))
(defun categorizar (lista)
    (mapcar 'etiqueta (mapcar 'car lista)))
```
No está "mal" en el sentido de que rompa una regla, pero son cuatro funciones y dos pasadas de `mapcar` para resolver algo que es un solo criterio de clasificación. Es más difícil de leer y de corregir en un parcial con tiempo limitado.

```lisp
; BIEN (preferido para este curso) — un solo mapcar, un lambda, un cond adentro
(defun categorizar-prestamos (lista)
    (mapcar (lambda (prestamo)
                (cond
                    ((<= (car prestamo) 7) "rapido")
                    ((<= (car prestamo) 15) "normal")
                    (T "demorado")))
            lista))
```
Este es el estilo que conviene fijar como "el ejemplo canónico" al que los alumnos tienen que parecerse: **un `mapcar`, un `lambda` que recibe el elemento completo de la lista, y un `cond` adentro que decide qué devolver.**

### 3.3 El lambda no declara tantos parámetros como listas le pasás
```lisp
; MAL
(defun sumar-de-a-dos (l1 l2)
    (mapcar (lambda (x) (+ x x)) l1 l2))   ; <- el lambda declara 1 parametro, pero mapcar le pasa 2
```
Error de cantidad de argumentos: `mapcar` va a tomar un elemento de `l1` **y** uno de `l2` en cada vuelta, y se los pasa juntos al lambda — si el lambda solo tiene un parámetro declarado, no sabe dónde poner el segundo.

```lisp
; BIEN
(defun sumar-de-a-dos (l1 l2)
    (mapcar (lambda (x y) (+ x y)) l1 l2))
```
**Recordatorio para remarcarles:** esto se puede extender a 3 o más listas en paralelo, no solo 2:
```lisp
(mapcar (lambda (x y z) (+ x y z)) lista1 lista2 lista3)
```
Y si las listas tienen **distinto largo**, `mapcar` se detiene en la más corta (no explota, pero puede "perder" datos de la más larga sin que se note — vale la pena recalcarles que revisen el enunciado si eso es un problema para el caso que les toca).

### 3.4 No validar el tipo de dato antes de operar
```lisp
; MAL
(defun duplicar (lista)
    (mapcar (lambda (x) (* x 2)) lista))
;; (duplicar '(1 2 A 4)) -> error, A no es numero
```
El TP5 lo dice explícitamente: "para aplicar funciones numéricas, sus argumentos deben ser numéricos. Se deberán evaluar los mismos de ser necesario." Si la lista puede traer datos heterogéneos, hay que revisarlo **dentro del lambda**, no asumir que todo es número.

```lisp
; BIEN
(defun duplicar (lista)
    (mapcar (lambda (x) (if (numberp x) (* x 2) x)) lista))
;; (duplicar '(1 2 A 4)) -> (2 4 A 8)
```

### 3.5 Usar MAPCAR para "filtrar" (quedarse solo con algunos)
```lisp
; MAL — MAPCAR siempre devuelve un resultado por cada entrada, nunca "menos"
(defun solo-pares (lista)
    (mapcar (lambda (x) (if (evenp x) x nil)) lista))
;; (solo-pares '(1 2 3 4)) -> (NIL 2 NIL 4)     <- no es lo que pedía el enunciado
```
Si el enunciado dice "una lista formada **solamente** por los que cumplen tal condición", eso es un **filtro**, y un filtro cambia el largo de la lista — `mapcar` nunca puede hacer eso, porque por definición devuelve un resultado por cada elemento de entrada.

```lisp
; BIEN — un filtro se resuelve con recursión (cons cuando cumple, se salta cuando no)
(defun solo-pares (lista)
    (cond
        ((null lista) nil)
        ((evenp (car lista)) (cons (car lista) (solo-pares (cdr lista))))
        (T (solo-pares (cdr lista)))))
```
**Pregunta clave para que se hagan siempre antes de escribir el código:** *"¿el resultado tiene que tener el mismo largo que la lista original?"* Si sí → `mapcar`. Si no (puede tener menos elementos) → recursión.

---

## 4. Checklist para pasarles antes de entregar cualquier MAPCAR

- [ ] ¿La función que le paso a `mapcar` devuelve exactamente **un** valor por cada elemento? (si necesito "menos" resultados que elementos, no es un `mapcar`, es un filtro con recursión)
- [ ] ¿Todo dato que uso adentro y **no** viene de una lista (umbral, límite, texto fijo) está capturado por un `lambda`, no pasado como si fuera otra lista?
- [ ] Si paso varias listas, ¿el `lambda` declara **la misma cantidad** de parámetros que listas le paso?
- [ ] Si la lógica tiene 2 o más casos, ¿usé `cond` **adentro** del `lambda`, en vez de tres funciones sueltas?
- [ ] ¿Validé `numberp` (u otro tipo) antes de aplicar una operación aritmética, si la lista puede traer datos heterogéneos?
- [ ] ¿Usé `'nombre-funcion` (comilla simple) de forma consistente, en vez de mezclar con `#'`?

---

## 5. Para practicar con ellos: "encontrá el error"

**Ejercicio A:**
```lisp
(defun marcar-riesgo (lista limite)
    (mapcar (lambda (x) (cond ((> x limite) 1) (T 0))) lista limite))
```
<details><summary>Respuesta</summary>
<code>limite</code> se pasó como si fuera otra lista para recorrer en paralelo, pero es un solo número. Hay que sacarlo de los argumentos de <code>mapcar</code> y dejar que el <code>lambda</code> lo capture directamente (cierre léxico): <code>(mapcar (lambda (x) (cond ((> x limite) 1) (T 0))) lista)</code>.
</details>

**Ejercicio B:**
```lisp
(defun comparar (l1 l2)
    (mapcar (lambda (a) (> a a)) l1 l2))
```
<details><summary>Respuesta</summary>
El <code>lambda</code> declara un solo parámetro (<code>a</code>) pero <code>mapcar</code> le va a pasar dos valores por vuelta (uno de <code>l1</code> y uno de <code>l2</code>). Además la comparación usa <code>a</code> contra sí mismo en vez de comparar los dos valores. Correcto: <code>(mapcar (lambda (a b) (> a b)) l1 l2)</code>.
</details>

**Ejercicio C:**
```lisp
(defun impares-de-la-lista (lista)
    (mapcar (lambda (x) (if (oddp x) x)) lista))
```
<details><summary>Respuesta</summary>
Esto no filtra: devuelve un valor por cada elemento (el impar, o <code>NIL</code> si no lo es), entonces el resultado queda con <code>NIL</code> mezclados donde había pares, no una lista "solo con los impares". Si el enunciado pide quedarse solo con los impares, es un filtro → resolverlo con recursión y <code>cons</code>, no con <code>mapcar</code>.
</details>
