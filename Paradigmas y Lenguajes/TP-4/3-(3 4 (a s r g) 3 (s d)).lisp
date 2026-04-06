3-(3 4 (a s r g) 3 (s d))
a.(defun sub_lista (l)
  (cond
    ((endp l) nil)
    ((listp (car l)) (cons (list (car l) (length (car l))) (sub_lista (cdr l))))
    (t (sub_lista (cdr l))))
)

b.(defun verificar_lista(l)
    (cond
        ((endp l) nil)
        ((listp (car l)) (cons t (verificar_lista(cdr l))))
        (t (cons nil (verificar_lista (cdr l))))
    )
)

4.'(21 45 62 32) '(11 10 9 7 8)
(defun resta-listas(l1 l2)
    (cond 
        ((or (endp l1) (endp l2)) nil)
        ((and (numberp (car l1)) (numberp (car l2))) (cons (- (car l1) (car l2)) (resta-listas (cdr l1) (cdr l2))))
        (t (resta-listas (cdr l1) (cdr l2))) 
    )
)

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
                            
                            
                            @((12 33 12 10)(12 9 5 3))
6.a (defun acumulador(l)
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

