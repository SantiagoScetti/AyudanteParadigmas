((20 5)(10 5))

(defun punto9()
    (let ((L '()) )
        (print "ingresa la lista porfo")
        (setq L (READ))

        (if (consp L)
            (progn
                (print(puntoA (NTH 1 L )))
                (print(puntoB (car L)))
                (pprint (puntoC (car L) (cdr l) ))
            )
        )))

(Defun puntoA(l)
    (cond
        ((endp l) nil)
        ((and (atom (car l)) (> (car l) 0) (< (car l) 2)) (cons '"Debil" (puntoA (cdr l)) ))
        ((and (atom (car l)) (>= (car l) 2) (< (car l) 15)) (cons '"moderada" (puntoA (cdr l))))
        ((and (atom (car l)) (> (car l) 15) ) (cons '"fuerte" (puntoA (cdr l))))
        (t (puntoA (cdr l)))
    ))

(Defun puntoB(l)
    (and (numberp (car (last l))) (> (car (last l)) 0) )
)

(Defun puntoC(l1 L2)
    (cond
        ((> (acumulador l1) (acumulador l2)) (cons '"mes con más lluvias" l1) )
        ((< (acumulador l1) (acumulador l2)) (cons '"mes con más lluvias" l2) )
        (t "iguales")
    )
)

(defun acumulador (L)
    (cond
        ((endp L) 0)
        ((numberp (car L)) (+ (car L) (acumulador (cdr L))))
        (t (acumulador (cdr L)))
    ))