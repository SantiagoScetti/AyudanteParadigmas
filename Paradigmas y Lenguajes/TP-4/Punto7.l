((1 10000 12 14 15 68 28 10000)(1 14 77 88 55 44 32) 20)

(defun punto7()
    (let ((L '()))
        (print "ingresala lista porfo")
        (setq L(READ))

        (if (consp L)
            (progn
                (print(puntoA (car L)))
                (print(puntoB L))
                (pprint (puntoC (car L) (nth 1 L) (nth 2 l)))
            )
        )
    )
)

(defun puntoA (archiv)
    (= (first archiv) (last archiv))
)

(defun acumulador (L)
    (cond
        ((endp L) 0)
        ((numberp (car L)) (+ (car L) (acumulador (cdr L))))
        (t (acumulador (cdr L)))
    ))

(defun puntoB(l)
  (> (acumulador (nth 0 l)) (acumulador (nth 1 l)))
)

(defun puntoC(1ra 2da X)
   (mapcar
        (lambda (1ra 2da)
            (cond 
                ((> (+ 1RA 2DA) X ) ( + 1RA 2DA ))
                (t nil)
                )
        )
    1ra 2da)
)