'((Prenda1 100)(Prenda2 200)(Prenda3 300))

(defun punto2 (lista)
    (/ (acumulador lista) (length lista))
)

(defun acumulador (lista)
    (cond
        ((null lista) 0)
        ((numberp (cadr (car lista))) (cadr (car lista)))
        (t (+ (cadr (car lista)) (acumulador (cdr lista))))
    )
)

;(last '(2 1 5))

(punto2 '((Prenda1 100) (Prenda2 200) (Prenda3 300)))


