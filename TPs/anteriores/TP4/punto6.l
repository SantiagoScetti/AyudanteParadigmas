6.a 

(defun acumulador(l)
        (cond
            ((endp l) 0)
            ((numberp (car l)) (+ (car l) (acumulador (cdr l))))
            (t (acumulador (cdr l)))
        ))

(defun comparar(l)
    (cond
        ((> (truncate(acumulador (first l))) (truncate(acumulador (last l)))) "La primera lista es mayor")
        ((< (truncate(acumulador (first l))) (truncate(acumulador (last l)))) "La segunda lista es mayor")
        (t "iguales")
    )
)


((122 33 12 10)(12 9 5 3))

(llamadaMasLarga '((122 33 12 10)(12 9 5 3)))

6. b
(defun llamadaMasLarga(l)
    (cond
        ((> (BuscarMax (car l)) (BuscarMax (cdr l))) (list "Normal" (max (car l))))
        ((< (BuscarMax(car l)) (BuscarMax (cdr l))) (list "extendido"  (max (cdr l))))
        (t "iguales") 
    )
)


(defun BuscarMax(lista)
    (max lista)
)

6. C
(defun llamadaMasCorta(l)
    (cond
        ((> (BuscarMin (car l)) (BuscarMin (cdr l))) (list "Normal" (min (car l))))
        ((< (BuscarMin(car l)) (BuscarMin (cdr l))) (list "extendido"  (min (cdr l))))
        (t "iguales") 
    )
)

(defun BuscarMin(lista)
    (min lista)
)