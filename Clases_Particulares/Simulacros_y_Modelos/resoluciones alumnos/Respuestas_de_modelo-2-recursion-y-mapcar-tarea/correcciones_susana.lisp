; =============================================================================
; CORRECCIONES - SUSANA                                         NOTA:  1 / 10
; Modelo 2 - Recursividad y MAPCAR (biblioteca: (DIAS ESTADO PAGINAS))
; =============================================================================
; Entrego solo el punto a), y sin terminar. Los otros 8 puntos estan en blanco.
; La nota es esa por eso: no es que este mal pensado, es que falta el examen.
;
; Lo que hay en la hoja son PRUEBAS DE ACCESORES: fue anotando, para cada
; sublista, que combinacion de car/cdr usaba y que le daba. Como paso previo
; esta bien (se nota que probo en el interprete y anoto los resultados reales,
; incluso los NIL), pero todavia no es una funcion.
; =============================================================================


; -----------------------------------------------------------------------------
; LOS 4 ERRORES DE LO QUE ESCRIBIO
;
; 1. NO HAY COND. El cuerpo del DEFUN son expresiones sueltas, una abajo de la
;    otra. LISP las evalua todas y devuelve la ULTIMA: no decide nada. Una
;    funcion que tiene que elegir entre casos necesita un COND.
;
; 2. NO HAY COMPARACION. Escribio (car (cdr (car lista))) y al lado la palabra
;    Bien. Poner el valor esperado al lado no compara: hay que preguntarlo.
;         (equal (car (cdr (car lista))) 'BIEN)
;    Y los atomos van SIEMPRE con comilla: 'BIEN, 'DANADO. Sin comilla LISP los
;    toma como variables y tira "variable no definida".
;
; 3. FALTAN PARENTESIS. El (defun Predicado (lista) ... nunca cierra, asi que
;    la funcion no se define.
;
; 4. ESTA RESOLVIENDO A MANO CADA SUBLISTA: un accesor para el 1ro, otro para
;    el 2do, otro para el 3ro. Eso solo funciona si la lista tiene exactamente
;    5 prestamos. La recursion existe para no depender de cuantos hay: se mira
;    SIEMPRE el primero, (car lista), y se vuelve a llamar con (cdr lista).
;
; DETALLE: escribio la lista dos veces, una con "danado" y otra con "dañado".
; Tienen que ser iguales siempre, si no el EQUAL nunca da T. Va DANADO, sin
; enie, como dice el enunciado.
; -----------------------------------------------------------------------------


; -----------------------------------------------------------------------------
; LOS ACCESORES, CORREGIDOS (con su lista)
; lista = ((5 BIEN 100) (6 DANADO 75) (8 BIEN 200) (2 BIEN 400) (10 DANADO 90))
;
;   1er estado:  (car (cdr (car lista)))            -> BIEN     BIEN HECHO
;   2do estado:  (car (cdr (car (cdr lista))))      -> DANADO   BIEN HECHO
;   3er estado:  (car (cdr (car (cddr lista))))     -> BIEN
;   4to estado:  (car (cdr (car (cdddr lista))))    -> BIEN
;   5to estado:  (car (cdr (car (cddddr lista))))   -> DANADO
;
; Los dos primeros los saco perfectos. Del tercero en adelante escribio
;     (car (cddr (cddr (cdr lista))))
; y le dio NIL: se paso de largo del final de la lista. Hay que separar los
; dos pasos, que se le mezclaron:
;
;   PASO 1 - moverse HASTA la sublista que quiero, con cdr:
;              (car lista)          la 1ra
;              (car (cdr lista))    la 2da
;              (car (cddr lista))   la 3ra
;              (car (cdddr lista))  la 4ta
;   PASO 2 - ya teniendo la sublista, sacarle el dato (siempre igual):
;              (car sublista)         DIAS
;              (car (cdr sublista))   ESTADO
;              (car (cddr sublista))  PAGINAS
;
; Atajos, es lo mismo escrito mas corto:
;              (caar lista)   -> DIAS del 1ro
;              (cadar lista)  -> ESTADO del 1ro
;              (caddar lista) -> PAGINAS del 1ro
; -----------------------------------------------------------------------------


; -----------------------------------------------------------------------------
; a) EL PUNTO QUE INTENTO, RESUELTO
;
; Con recursion no hace falta ningun accesor especial para el 3ro, el 4to ni
; el 5to: siempre se mira el primero y se sigue con el resto.
; El caso base es T porque una lista vacia cumple "todos estan bien": no
; quedo ninguno mal.
; -----------------------------------------------------------------------------
(defun predicado (lista)
    (cond
        ((null lista) T)
        ((not (equal (cadar lista) 'BIEN)) NIL)
        (t (predicado (cdr lista)))
    )
)

; (predicado '((5 BIEN 100) (6 DANADO 75) (8 BIEN 200)))  -> NIL
; (predicado '((5 BIEN 100) (8 BIEN 200)))                -> T


; -----------------------------------------------------------------------------
; PARA PRACTICAR, EN ESTE ORDEN
;   1) Contar cuantos prestamos hay (punto c). Es el molde mas simple:
;        caso base 0, y  (t (+ 1 (funcion (cdr lista))))
;   2) El punto b, que es el c con una condicion adentro.
;   3) Recien despues el a, que es el mismo molde devolviendo T/NIL.
; Si le salen esos tres, el resto del examen es el mismo molde con cambios.
; -----------------------------------------------------------------------------
