; MODELO 2 - RECURSION Y MAPCAR - CLASE - SOLUCION DE REFERENCIA
; Taller mecanico: lista de sublistas (COSTO TIEMPO)

; a) Predicado UNIVERSAL: todas las reparaciones <= limite de horas
(defun todas-tiempo-ok-p (lista limite)
    (cond
        ((null lista) T)
        ((> (cadr (car lista)) limite) NIL)
        (T (todas-tiempo-ok-p (cdr lista) limite))
    )
)

; b) Contar con condicion: costo > valor
(defun contar-caras (lista valor)
    (cond
        ((null lista) 0)
        ((> (car (car lista)) valor) (+ 1 (contar-caras (cdr lista) valor)))
        (T (contar-caras (cdr lista) valor))
    )
)

; c) Contar todos los elementos
(defun cantidad-reparaciones (lista)
    (cond
        ((null lista) 0)
        (T (+ 1 (cantidad-reparaciones (cdr lista))))
    )
)

; d) MAPCAR sobre una lista: extraer los tiempos
(defun tiempos (lista)
    (mapcar 'cadr lista)
)

; e) Recursion: filtrar por costo > 50000
(defun caras (lista)
    (cond
        ((null lista) nil)
        ((> (car (car lista)) 50000) (cons (car lista) (caras (cdr lista))))
        (T (caras (cdr lista)))
    )
)

; f) MAPCAR con COND adentro: mensaje segun tramo de costo
(defun categorizar (lista)
    (mapcar (lambda (rep)
                (cond
                    ((<= (car rep) 20000) "economica")
                    ((<= (car rep) 60000) "moderada")
                    (T "cara")))
            lista)
)

; Datos de prueba: ((45000 3) (70000 6) (15000 1) (60000 2))
;   todas-tiempo-ok-p -> con limite 5: NIL (la 2da tiene 6 horas)
;   contar-caras con valor 40000 -> 3  (45000, 70000 y 60000)
;   cantidad-reparaciones -> 4
;   tiempos -> (3 6 1 2)
;   caras -> ((70000 6) (60000 2))
;   categorizar -> ("moderada" "cara" "economica" "moderada")
