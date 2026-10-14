(Defun parcialP3
    (let ((mes1 0)(mes2 0) (mes3 0))
    (pprint "ingrersa el 1er mes")
    (setq mes1(read))
    (pprint "ingrersa el 2do mes")
    (setq mes2(read))
    (pprint "ingrersa el 3er mes")
    (setq mes3(read))

    (if (and
            (and (numberp mes1)(numberp mes2)(numberp mes3))
            (and(> 0 mes1)(> 0 mes2)(> 0 mes3)))
        (progn
            (pprint(consumo-prom mes1 mes2 mes3))
            (pprint(comprobar-igualdad mes1 mes2 mes3))
            (pprint(ejer-listas(consumo-prom mes1 mes2 mes3))))
        (pprint "Error, alguno de los valores no es un número positivo")
    )))

(defun consumo-prom (x y z)
    (/ (+ x y z) 3)
)

(defun comprobar-igualdad (x y z)
    (= x y z)
)

(defun ejer-listas (promedio)
    (cond
        ((<= promedio 80) (list "bajo" promedio))
        ((and (> promedio 81)(< promedio 120)) (list "medio" promedio))
        ((>= promedio 121) (list "alto" promedio))
    ))