;a 
(defun rio ()
    (let ((nivel))
        (print `ingrese nivel del rio`)
        (setq nivel (read))

        (dispersion nivel)
    )
)

;b
(defun dispersion (lista)
    (cond 
        ((< 30 cm) `despiersion pareja)
        (or((>100 cm) `locos))
        (t ` normales)
    )
)

; solucion mas prolija:
(defun ingreso()
       (let ((valorB) (valorA))
        (pprint "ingrese el valor bajo del nivel de rio")
        (setq valorB (read))
         (pprint "ingrese el valor alto del nivel de rio")
        (setq valorA (read))
        
        ;(dispersion valorA ValorB)

        (clasificacion((dispersion valorA ValorB)))
       )
)

(defun dispersion (valorA ValorB)
    (cond
       ((not(and (numberp valorA) (numberp ValorB))) 'Error)
        (-(max valorB valorA) (min valorB valorA))
    )
)


(defun clasificacion(dispersion)
     (cond 
         ((< dispersion 30) "Dias parejos")
         ((> dispersion 60) "Dias locos")
         (t "Dias Norales")
     )
)
;---------------------------------------------------


;diego
(DEFUN CAUDAL ()
    (Let ((MAX) (MIN))

        (PRINT "ingrese el valor MAX")
        (SETQ MAX (READ))

        (PRINT "ingrese el valor MIN")
        (SETQ MIN (READ))

        (- MAX MIN)
    
        (COND
            ((< (- MAX MIN) 30) 'CHICA)
            ((> (- MAX MIN) 100) 'LOCOS)
            (T 'NORMALES)
        )
    )
)

; juan martin
(defun dispersion (min max)
  (- max min)
)

(defun tipo-dia (minimo maximo)
  (cond
    ((< (dispersion minimo maximo) 30) 'PAREJOS)
    ((> (dispersion minimo maximo) 100) 'LOCOS)
    (t 'NORMALES)
  )
)
(defun ingreso()
       (let ((valorB) (valorA))
        (pprint "ingrese el valor bajo del nivel de rio")
        (setq valorB (read))
         (pprint "ingrese el valor alto del nivel de rio")
        (setq valorA (read))
        
        ;(dispersion valorA ValorB)
        (dispersion valorB valorA)
        (tipo-dia valorB valorA)
       )
)