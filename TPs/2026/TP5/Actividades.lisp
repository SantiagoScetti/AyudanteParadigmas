;; ====================================================================
;; PARADIGMAS Y LENGUAJES DE PROGRAMACION - UNIVERSIDAD NACIONAL DEL NORDESTE
;; LENGUAJE LISP - Trabajo Práctico N°5 (Año: 2.026)
;; ====================================================================

;; --------------------------------------------------------------------
;; Actividad N° 1: Evaluar funciones MAPCAR
;; --------------------------------------------------------------------

;; | Función aplicada                                                | Resultado                 |
;; | :---------------------------------------------------------------| :------------------------ |
;; | (mapcar 'atom '(a (b) () (()) "AA" 3))                          | (T NIL T NIL T T)         |
;; | (mapcar 'listp '(a (b) () (()) "AA" 3))                         | (NIL T T T NIL NIL)       |
;; | (mapcar '> '(5 8 3) '(4 9 2))                                   | (T NIL T)                 |
;; | (mapcar '< '(2 8 3) '(4 9 2) '(5 1 7))                          | (T NIL NIL)               |
;; | (mapcar '> '(5 8 3) '(4 9) '(3 8 1))                            | (T NIL)                   |
;; | (mapcar '+ '(1 2) '(3 4) '(2 2))                                | (6 8)                     |
;; | (mapcar '- '(1 8) '(3 4) '(2 2 9))                              | (-4 2)                    |
;; | (mapcar 'cons '(1 2) '((a b) (3 4) ((7 8))))                    | ((1 A B) (2 3 4))         |
;; | (mapcar 'length '((1 1 1) () ((8)) (a b)))                      | (3 0 1 2)                 |
;; | (mapcar 'list '(a b c d))                                       | ((A) (B) (C) (D))        |
;; | (mapcar 'car '((2 3 4) (a b) ((c)) ) )                          | (2 A (C))                 |
;;
;; () es NIL, y NIL cuenta como atomo y como lista a la vez: por eso en la
;; fila de ATOM da T y en la de LISTP tambien da T.
;; Cuando las listas no tienen el mismo largo, MAPCAR corta en la mas corta.


;; --------------------------------------------------------------------
;; Actividad N° 2 y N° 3: Evaluar si cada elemento es numérico
;; --------------------------------------------------------------------

;; Actividad 2: T o NIL
(defun evaluar-numericos (lista)

    (mapcar 'numberp lista)
)
;; Prueba: (evaluar-numericos '(1 A 2 "x" 3.5))  ; => (T NIL T NIL T)

;; Actividad 3: mismo criterio, cambia la leyenda a SI / NO
(defun evaluar-numericos-si-no (lista)

    (mapcar (lambda (x)
                (cond
                    ((numberp x) "SI")
                    (T "NO")
                )
            )
    lista)
)
;; Prueba: (evaluar-numericos-si-no '(1 A 2))  ; => ("SI" "NO" "SI")

(defun ingresar-lista-numericos ()

    (let (lista)
        (pprint "Ingrese la lista:")
        (setq lista (read))

        (list (evaluar-numericos lista) (evaluar-numericos-si-no lista))
    )
)


;; --------------------------------------------------------------------
;; Actividad N° 4: Elemento junto con su potencia
;; --------------------------------------------------------------------

(defun elevar-a-potencia (lista potencia)

    (mapcar (lambda (x) (list x (expt x potencia))) lista)
)
;; Prueba: (elevar-a-potencia '(2 3 4) 2)  ; => ((2 4) (3 9) (4 16))

(defun ingresar-lista-y-potencia ()

    (let (lista potencia)
        (pprint "Ingrese la lista de numeros:")
        (setq lista (read))
        (pprint "Ingrese el exponente de la potencia:")
        (setq potencia (read))

        (elevar-a-potencia lista potencia)
    )
)


;; --------------------------------------------------------------------
;; Actividad N° 5: Comparar cada elemento con cero
;; --------------------------------------------------------------------

(defun comparar-con-cero (lista)

    (mapcar (lambda (x)
            (cond
                ((and (numberp x) (> x 0))(list x '> 0))
                ((and (numberp x) (< x 0))(list x '< 0))
                ((and (numberp x) (= x 0))(list x '= 0))
                (T(list x 'NO-ES-NUMERO))
            )
        )
    lista)
)
;; Prueba: (comparar-con-cero '(-1 0 1 ñ))  ; => ((-1 < 0) (0 = 0) (1 > 0) (ñ NO-ES-NUMERO))

(defun ingresar-lista-comparar-cero ()

    (let (lista)
        (pprint "Ingrese la lista heterogenea:")
        (setq lista (read))

        (comparar-con-cero lista)
    )
)


;; --------------------------------------------------------------------
;; Actividad N° 6: Longitudes de los elementos que son sublistas
;; --------------------------------------------------------------------

;; "formada por las longitudes de AQUELLOS que sean sublistas" es un filtro
;; (el resultado no tiene el mismo largo que la lista original), y MAPCAR
;; siempre devuelve un resultado por cada entrada: no puede filtrar.
;; Se resuelve con recursion, reutilizando el criterio CONSP de siempre.
(defun longitudes-de-sublistas (lista)

    (cond
        ((null lista) nil)
        ((consp (car lista)) (cons (length (car lista)) (longitudes-de-sublistas (cdr lista))))
        (T (longitudes-de-sublistas (cdr lista)))
    )
)
;; Prueba: (longitudes-de-sublistas '(1 (2 3) A (4 5 6 7) "hola"))  ; => (2 4)

;; Version con MAPCAR: mantiene el largo original, dejando NIL en los
;; elementos que no son sublista (no es lo que pide el enunciado, que
;; quiere la lista formada SOLO por esas longitudes)
(defun longitudes-de-sublistas-mapcar (lista)

    (mapcar (lambda (x)
                (cond
                    ((consp x) (length x))
                    (T NIL)
                )
            )
    lista)
)
;; Prueba: (longitudes-de-sublistas-mapcar '(1 (2 3) A (4 5 6 7) "hola"))  ; => (NIL 2 NIL 4 NIL)

(defun ingresar-lista-para-longitudes ()

    (let (lista)
        (pprint "Ingrese la lista heterogenea:")
        (setq lista (read))

        (list (longitudes-de-sublistas lista) (longitudes-de-sublistas-mapcar lista))
    )
)


;; --------------------------------------------------------------------
;; Actividad N° 7: Asociar los no-numéricos de LISTA1 con el último de LISTA2
;; --------------------------------------------------------------------

;; Misma razon que en la Actividad 6: "cada elemento no-numerico" es un
;; filtro sobre LISTA1, asi que tampoco se resuelve con MAPCAR.
(defun asociar-no-numericos (lista1 lista2)

    (cond
        ((null lista1) nil)
        ((not (numberp (car lista1))) (cons (list (car lista1) (car (last lista2))) (asociar-no-numericos (cdr lista1) lista2)))
        (T (asociar-no-numericos (cdr lista1) lista2))
    )
)
;; Prueba: (asociar-no-numericos '(1 A 2 B) '(10 20 30))  ; => ((A 30) (B 30))

;; Version con MAPCAR: mantiene el largo de LISTA1, dejando NIL en los
;; elementos numericos en vez de sacarlos de la lista resultado
(defun asociar-no-numericos-mapcar (lista1 lista2)

    (mapcar (lambda (x)
                (cond
                    ((not (numberp x)) (list x (car (last lista2))))
                    (T NIL)
                )
            )
    lista1)
)
;; Prueba: (asociar-no-numericos-mapcar '(1 A 2 B) '(10 20 30))  ; => (NIL (A 30) NIL (B 30))

(defun ingresar-listas-para-asociar ()

    (let (lista1 lista2)
        (pprint "Ingrese la LISTA1:")
        (setq lista1 (read))
        (pprint "Ingrese la LISTA2:")
        (setq lista2 (read))

        (list (asociar-no-numericos lista1 lista2) (asociar-no-numericos-mapcar lista1 lista2))
    )
)


;; --------------------------------------------------------------------
;; Actividad N° 8: sumo-ambos
;; --------------------------------------------------------------------

(defun sumo-ambos (lista1 lista2)

    (mapcar '+ lista1 lista2)
)
;; Prueba: (sumo-ambos '(1 2 3) '(10 20 30))  ; => (11 22 33)

(defun ingresar-listas-para-sumar ()

    (let (lista1 lista2)
        (pprint "Ingrese la LISTA1:")
        (setq lista1 (read))
        (pprint "Ingrese la LISTA2:")
        (setq lista2 (read))

        (sumo-ambos lista1 lista2)
    )
)


;; --------------------------------------------------------------------
;; Actividad N° 9: ambos-enteros
;; --------------------------------------------------------------------

(defun ambos-enteros (lista1 lista2)

    (mapcar (lambda (x y)
                (cond
                    ((and (integerp x) (integerp y)) (list x y))
                    (T NIL)
                )
            )
    lista1 lista2)
)
;; Prueba: (ambos-enteros '(1 2.5 3) '(4 5 6.1))  ; => ((1 4) NIL NIL)

(defun ingresar-dos-listas-enteros ()

    (let (lista1 lista2)
        (pprint "Ingrese la primera lista (LISTA1):")
        (setq lista1 (read))
        (pprint "Ingrese la segunda lista (LISTA2):")
        (setq lista2 (read))

        (ambos-enteros lista1 lista2)
    )
)
