; PRACTICA - REUTILIZAR FUNCIONES - SOLUCION DE REFERENCIA
; Verduleria "La Huerta":  PRODUCTO = (PRODUCTO STOCK PRECIO)
;
; LA IDEA DE TODA LA PRACTICA:
; Despues del punto 0 no se vuelve a escribir car/cadr/caddr sobre un producto.
; Cada dato sale de su accesor. Y en el punto 3 ni siquiera se usan los
; accesores: se usan las funciones que la alumna escribio en el punto 1.
;
; Como leer el resultado: si en la solucion de un punto aparece un numero o una
; cuenta que ya estaba en un punto anterior, ese punto esta mal aunque de bien.


; =============================================================================
; PUNTO 0 - LOS ACCESORES (regalados)
; Una sola linea cada uno. Son el unico lugar de todo el programa donde se
; escribe car, cadr y caddr sobre un producto.
; =============================================================================
(defun nombre-de (producto)
    (car producto)
)

(defun stock-de (producto)
    (cadr producto)
)

(defun precio-de (producto)
    (caddr producto)
)


; =============================================================================
; PUNTO 1.a - PREDICADO SOBRE UN PRODUCTO
; Un predicado devuelve T o NIL: la comparacion ya devuelve eso, no hace falta
; IF ni COND. Y el stock sale de stock-de, no de (cadr producto).
; =============================================================================
(defun hay-poco-p (producto)
    (< (stock-de producto) 5)
)


; =============================================================================
; PUNTO 1.b - CUENTA SOBRE UN PRODUCTO
; Los dos datos salen de sus accesores.
; =============================================================================
(defun valor-del-producto (producto)
    (* (stock-de producto) (precio-de producto))
)


; =============================================================================
; PUNTO 2.a - RECURSION QUE CUENTA
; Devuelve un numero, asi que el caso base es 0 y se combina con (+ 1 ...).
; (car lista) es el producto que se esta mirando; de ahi en adelante, accesor.
; =============================================================================
(defun contar-sin-stock (lista)
    (cond
        ((null lista) 0)
        ((= (stock-de (car lista)) 0) (+ 1 (contar-sin-stock (cdr lista))))
        (T (contar-sin-stock (cdr lista)))
    )
)


; =============================================================================
; PUNTO 2.b - RECURSION QUE CORTA TEMPRANO, CON PARAMETRO
; Molde de "existe al menos uno": caso base NIL, corta con T apenas encuentra.
; El MONTO no cambia nunca, pero hay que volver a pasarlo en cada llamada: si
; se olvida, la funcion no compila por cantidad de argumentos.
; =============================================================================
(defun existe-caro-p (lista monto)
    (cond
        ((null lista) NIL)
        ((> (precio-de (car lista)) monto) T)
        (T (existe-caro-p (cdr lista) monto))
    )
)


; =============================================================================
; PUNTO 3.a - EL PUNTO DEL EJERCICIO
; Aca NO se compara contra 5. Eso ya lo sabe hay-poco-p, del punto 1.a.
; Si en esta funcion aparece un 5, esta mal aunque devuelva lo correcto:
; significa que se escribio dos veces la misma regla, y el dia que la verduleria
; cambie el minimo a 10 hay que acordarse de tocar los dos lugares.
;
; Es un filtro, asi que la salida es mas corta que la entrada: CONS y caso base
; NIL. Y lo que se guarda es el NOMBRE, no la sublista entera.
; =============================================================================
(defun listar-faltantes (lista)
    (cond
        ((null lista) NIL)
        ((hay-poco-p (car lista))
            (cons (nombre-de (car lista)) (listar-faltantes (cdr lista))))
        (T (listar-faltantes (cdr lista)))
    )
)


; =============================================================================
; PUNTO 3.b - EL OTRO PUNTO DEL EJERCICIO
; Aca NO aparece el *. La multiplicacion ya la sabe valor-del-producto.
; Sumar es: el valor del primero, mas lo que sumen todos los demas.
; =============================================================================
(defun valor-total (lista)
    (cond
        ((null lista) 0)
        (T (+ (valor-del-producto (car lista)) (valor-total (cdr lista))))
    )
)


; =============================================================================
; PUNTO 4 - MAPCAR
; La salida tiene un elemento por cada producto, asi que es MAPCAR.
; La decision va en una auxiliar: adentro del LAMBDA, un COND metido en un LIST
; se vuelve ilegible.
; Ojo con "mayor o igual": va >= y no >.
; =============================================================================
(defun etiqueta-de (producto)
    (cond
        ((>= (precio-de producto) 3000) 'CARO)
        (T 'BARATO)
    )
)

(defun generar-cartel (lista)
    (mapcar (lambda (producto)
                (list (nombre-de producto) (etiqueta-de producto)))
            lista)
)


; =============================================================================
; ENCONTRA EL ERROR - RESPUESTAS
;
; A)  (defun stock-de (car producto) (cddr producto))
;     Tres errores en una linea:
;       1. Redefine una funcion que YA EXISTE. La del punto 0 andaba bien.
;       2. Al primer parametro lo llamo CAR, que es el nombre de una funcion de
;          LISP. Nunca ponerle a una variable el nombre de una funcion.
;       3. Tiene DOS parametros, asi que todas las llamadas de antes, que le
;          pasan uno solo, pasan a dar "Too few arguments". Y encima devuelve
;          (cddr producto), que es la LISTA (2500), no el numero 2500.
;
; B)  ((> (precio-de (car lista)) PRECIO) ...)
;     PRECIO no es una variable: es el NOMBRE DEL CAMPO en el enunciado.
;     Adentro de la funcion los unicos datos que existen son los parametros, y
;     esta funcion recibe LISTA nada mas. Al correrla:
;     "variable PRECIO has no value". Si hace falta un monto, se recibe como
;     parametro y se vuelve a pasar en cada llamada recursiva.
;
; C)  ((= (precio-de (car lista))) ...)
;     Al = le falta el segundo valor: quedo comparando el precio contra nada.
;     En LISP (= x) con un solo argumento devuelve T SIEMPRE, porque un numero
;     es igual a si mismo. Entonces la condicion se cumple en todas las vueltas
;     y la funcion devuelve TODOS los nombres en vez de filtrar.
;     Es el peor tipo de error: no avisa, corre y devuelve cualquier cosa.
;     Va (= (precio-de (car lista)) precio).
; =============================================================================


; =============================================================================
; DATOS DE PRUEBA
; (setq verduleria '((TOMATE 3 2500) (PAPA 20 1200) (LECHUGA 0 3500)
;                    (CEBOLLA 2 1800) (ZAPALLO 0 3000) (MORRON 8 4200)))
;
;   (nombre-de (car verduleria))       -> TOMATE
;   (stock-de (car verduleria))        -> 3
;   (precio-de (car verduleria))       -> 2500
;   (hay-poco-p (car verduleria))      -> T
;   (hay-poco-p '(PAPA 20 1200))       -> NIL
;   (valor-del-producto (car verduleria)) -> 7500
;   (contar-sin-stock verduleria)      -> 2     (LECHUGA y ZAPALLO)
;   (existe-caro-p verduleria 4000)    -> T     (MORRON, 4200)
;   (existe-caro-p verduleria 5000)    -> NIL
;   (listar-faltantes verduleria)      -> (TOMATE LECHUGA CEBOLLA ZAPALLO)
;   (valor-total verduleria)           -> 68700
;   (generar-cartel verduleria)        -> ((TOMATE BARATO) (PAPA BARATO)
;                                          (LECHUGA CARO) (CEBOLLA BARATO)
;                                          (ZAPALLO CARO) (MORRON CARO))
; =============================================================================
