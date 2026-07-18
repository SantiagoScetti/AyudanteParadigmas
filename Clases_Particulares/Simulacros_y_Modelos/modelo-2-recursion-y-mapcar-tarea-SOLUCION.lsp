; MODELO 2 - RECURSION Y MAPCAR - TAREA - SOLUCION DE REFERENCIA
; Biblioteca: lista de sublistas (DIAS ESTADO)

; a) Predicado UNIVERSAL: todos devueltos BIEN
(defun todos-bien-p (lista)
    (cond
        ((null lista) T)
        ((not (equal (cadr (car lista)) 'BIEN)) NIL)
        (T (todos-bien-p (cdr lista)))
    )
)

; b) Contar con condicion: dias > cantidad
(defun contar-demorados (lista dias)
    (cond
        ((null lista) 0)
        ((> (car (car lista)) dias) (+ 1 (contar-demorados (cdr lista) dias)))
        (T (contar-demorados (cdr lista) dias))
    )
)

; c) Contar todos los prestamos
(defun cantidad-prestamos (lista)
    (cond
        ((null lista) 0)
        (T (+ 1 (cantidad-prestamos (cdr lista))))
    )
)

; d) MAPCAR sobre una lista: extraer los dias
(defun dias-prestamo (lista)
    (mapcar 'car lista)
)

; e) Recursion: filtrar los danados
(defun danados (lista)
    (cond
        ((null lista) nil)
        ((equal (cadr (car lista)) 'DANADO) (cons (car lista) (danados (cdr lista))))
        (T (danados (cdr lista)))
    )
)

; f) MAPCAR con COND adentro: mensaje segun tramo de dias
(defun categorizar-prestamos (lista)
    (mapcar (lambda (prestamo)
                (cond
                    ((<= (car prestamo) 7) "rapido")
                    ((<= (car prestamo) 15) "normal")
                    (T "demorado")))
            lista)
)

; Datos de prueba: ((5 BIEN) (20 DANADO) (10 BIEN) (3 DANADO))
;   todos-bien-p -> NIL (hay dos DANADO)
;   contar-demorados con dias 7 -> 2  (20 y 10)
;   cantidad-prestamos -> 4
;   dias-prestamo -> (5 20 10 3)
;   danados -> ((20 DANADO) (3 DANADO))
;   categorizar-prestamos -> ("rapido" "demorado" "normal" "rapido")
