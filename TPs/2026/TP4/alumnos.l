Actividad N 6

(defun ingreso()
   (let ((l))
     (pprint "Ingrese una lista Heterogenea")
     (setq l (read))
    
     (pprint "Ingrese un atomo")
     (setq A (read))
    
     (if (and (consp l) (atom A))
        (progn
            (pprint (predicado l))
            (pprint (diferencia l A))
            (pprint (sublistas l A))
        )
      )
   )
)

(defun predicado(l)
   (cond 
      ((endp l) T)
      ((atom (car l))(predicado (cdr l)))
      (t nil)
    )
 )


(defun diferencia (l A)
   (cond
     ((endp) 0)
     ((and (numberp (car l)) (<= (car l) A))  (+ 1 (diferencia (cdr l) A )))
     (t (+ 0 (diferencia (cdr l) A )))
   )
)

(4 6 8 (1) Ñ )
 2
 ((4 2)  (6 3) (8 4) )

(defun sublistas(l A)
  (cond 
     ((endp l) NIL)
     ((and (numberp (car l)) (> (car l) 0)) (cons(list (car l) (/ (car l) A)) (sublistas  (cdr l) A)))
     (t (sublistas  (cdr l) A) )
   )
)

-----------------------------------------------------------------------------

((5 4 6 8 9)(10 2 56 20))

(defun cuandohablomas (L)

  (cond
    ((> (suma (car L))
         (suma (cdr L)))
     "NORMAL")

    ((< (suma (car L))
         (suma (cdr L)))
     "REDUCIDO")

    (t "IGUAL")
  )
) 

(defun suma (L)
  (cond
    ((endp L) 0)
    (    (numberp (car L))  (+ (car L) (suma (cdr L)))    )
    (t (suma (cdr L)))
  )
)



((5 4 6 8 9)(10 2 56 20))

(defun llamadaMasLarga (L)
  (cond
    ((> (mayor (car L))
         (mayor (cadr L)))
     (list (mayor (car L)) '"NORMAL"))

    ((< (mayor (car L))
         (mayor (cadr L)))
      (list (mayor (cadr L)) "REDUCIDO"))

    (t "IGUAL"))
)


(9)
(defun mayor (L)
  (cond
    ((endp (cdr L)) (car L))

    ((> (car l) (mayor (cdr l))) (car l))

    (t (mayor (cdr L))))
)
-

(defun mayor(l)
    (cond
            ((null (cdr l)) (car l))
            (t(max(car l) (mayor (cdr l))))
    )
)