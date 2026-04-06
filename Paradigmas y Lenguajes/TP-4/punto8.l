(1 a 12 c (a) nil 28 (((3))) 40)  2

(defun punto8()
    (let ((L '()) (N 0) )
        (print "ingresa la lista porfo")
        (setq L(READ))
        (print "ingresa el nro porfo")
        (setq N(READ))

        (if (AND (consp L) (numberp N))
            (progn
                (Pprint(puntoA l ))
                (pprint(puntoB l N ))
                (pprint (puntoC L N))
            ))))

(Defun puntoA(l)
    (cond
        ((endp l) t)
        ((and (atom (car l)) (puntoA(cdr l))) t )
        (t nil)
    )
)
(Defun puntoB(L N)
    (cond
        ((endp l) 0)
        ((and (numberp (car l)) (<= (car l) N)) (+ 1 (puntoB (cdr l) n)))
        (t (puntoB (cdr L) N ))
    )
)

(DEFUN puntoC (L N)
    (cond
        ((endp l) nil)
        ((and (numberp (car l)) (> (car l) 0)) (cons (list (car l) (/ (car l) n)) (puntoC (cdr l) N )))
        (t (puntoC (cdr l) N ))  
    )
)
