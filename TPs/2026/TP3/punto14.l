; Rocio el mejor
(defun peso-pino (alturaPino)
    (cond
        ((<= alturaPino 3) (* (* 100 alturaPino) 3))
        (t (+ 900 (* (- (* 100 alturaPino) 300) 2)))
    )
)

(defun es-peso-util (pesoPino)
    (and (>= pesoPino 400)
         (<= pesoPino 1000)
    )
)


(defun sirve-pino (altura)
    (Es-peso-util (peso-pino altura))
)


;geronimo 
a-
(defun peso-pino (alt)
    (cond
        ((<= alturaPino 3) (* (* 100 alturaPino) 3))
        (t (+ 900 (* (- (* 100 alturaPino) 300) 2)))
    )
)

b-
(defun esPeso (pesoK)
  (and (>= pesoK 400) (<= pesoK 1000)
  )
)

c-
(defun sirvePino (altura)
  (esPeso (peso-pino altura))
)

;diego
(defun pesopino (altura)
    (cond
        ((<= altura 300) (* altura 300))

        ;t (+ 900 (* (- (* altura 100 ) 300) 2)))
        (t (+ 900 (* (- (* altura 100) 300) 2)))
    )
)

B-
(defun espeso-util (peso)
     (and (<= peso 1000)
          (>= peso 400)
    )
)

C-
(defun sirvepino (altura)
    (and (> altura 134)(< altura 350))
)