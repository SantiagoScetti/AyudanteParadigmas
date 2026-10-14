azucar 80
cafe 1500

1/4 del monto para el azucar y 3/4 para el café

(defun ejer3 ()
    (let ((monto 0))
        (pprint "ingresar el monto")
        (setq monto(read))

        (if (> monto 0)
           (progn
            (pprint(cantidad-azucar monto))
            (pprint(2k-cafe monto))
           )
           (pprint "monto no válido")
        )))

(defun cantidad-azucar (monto)
    (list monto (float (/ (* 0.25 monto) 80))))

(defun 2k-cafe (monto)
    (>= (* 0.75 monto) 3000))
    