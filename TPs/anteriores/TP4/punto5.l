5.(defun pares(l)
    (cond
        ((endp l) nil)
        ((and (numberp (car l)) (evenp (car l))) (cons (car l) (pares (cdr l))))
        (t (pares (cdr l)))
    )
)

(defun impares(l2)
    (cond
        ((endp l2) nil)
        ((and (numberp (car l2)) (oddp (car l2))) (cons (car l2) (impares (cdr l2))))
        (t (impares (cdr l2)))
    )
)

(defun armarlista (l)
    (list (pares l) (impares l))
)   