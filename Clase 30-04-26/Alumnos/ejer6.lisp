(defun ingresarDatos (
    (let ((l_het) (valAtom))
            (print "ingrese lista heterogenea")
            (setq l_het (read))
            (print "ingrese valor atomico")
            (setq valAtom (read))
            (if (and (CONSP l_het) (atom valAtom) )
            (progn
                (predicado l_het)
                (detCant l_het valAtom)
                (devolverNueLista l_het valAtom)
            )
            )
    )
    )
)
(predicado '(10 A 20 -5 0 (s df s)))

(defun predicado (plh)
    (cond
        ( (NULL plh) T)
        ((not (atom (car plh))) nil)
        ;((atom (CAR plh)))   (predicado (cdr plh))  
        (t (predicado (cdr plh)))
    )
)

(detCant '(10 20 -5 0 5) 5)

(defun detCant (plh pA)
    (cond 
        ((NULL plh) 0)
        ((not (numberp (CAR plh))) ("No es numero" ))
        ((<= (CAR plh) pA) (+ 1 (detCant (CDR plh) pA))) ;pA es el atomo
        (t (detCant (CDR plh) pA))
    )
)


(act3_ret_lista '(10 20 -5 0 5) 0)
(defun act3_ret_lista (plh pA);
    (cond 
        ((null plh) nil)
        ((zerop pA) (error "Dividir por cero"))
        ;formar new list de sublists (cada una formada por elem_original y resultado división por pA)
        ((numberp (car plh)) (cons (cons (car plh) (/ (car plh) pA)) (act3_ret_lista (cdr plh) pA)))
        (t (act3_ret_lista (cdr plh) pA))
    )
)

; valor de prueba: (detCant_v2 '(10 30 -5 0) 2)
; output: ((10 . 5) (30 . 15) (-5 . -5/2) (0 . 0))





(defun devolverNueLista (pLh pA)
    (cond
        ((null pLh) nil) ; caso base
        ((and (numberp (CAR pLh)) (> (CAR pLh) 0))
            (cons (list (CAR pLh) (/ (CAR pLh) pA))  (devolverNueLista (CDR pLh) ))) 
        (t (devolverNueLista (CDR pLh) ))
    )
)