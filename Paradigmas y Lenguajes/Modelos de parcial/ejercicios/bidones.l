(defun ingresar-datos()
    (let((monto))
        (pprint "ingrese el monto a abonar")
        (setq monto (read))
        
        (progn
            (pprint (lista monto))
            (pprint (descuento monto))
            (pprint (sepuede monto))
        )))

(defun lista (monto) 
    (list
        (list "b10l" (truncate (/ monto 15000)))
        (list "b102" (truncate (/ monto 28000)))
        (list "b105" (truncate (/ monto 70000)))
    ))

(defun descuento (monto)
    (cond
        ((and (> monto 75000) (<= monto 200000)) (- monto 30000))
        ((> monto 200000)(- monto 50000))
        (T monto)
    ))

(defun sePuede (monto)
    (> monto 310000)
)