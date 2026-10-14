;gero POR LO MENOS LO INTENTASTES pero a arreglar: ->
(defun G-amigos ()
    (let ((CantAmg precioP))
        (pprint ´ingrese cantidad de amigos`)
        (setq CantAmg (read))
        (pprint ´ingrese precio pizza`)
        (setq precioP (read))

        (cond
            ((not (numberp CantAmg)) `error) 
            
            ;((= CantAmg 3) ` 8000 cada uno)
            
            ((< CantAmg 3) ((/ (*(ceiling(/ (* 3 cantidadA)8)) precio ) cantidadA)) )
                
                
                (calcualrPrecio precioP CantAmg)
        )
    )
)

(defun calcularProciones (CantAmg)

)
(defun calcualrPrecio(precioP CantAmg)

)


;Rocio El mejor ejemplo:
(defun cantidad-porciones (amigos)
  (* amigos 3)
)

(defun cantidad-de-pizzas (amigos)
  (ceiling (/ (cantidad-porciones amigos) 8.0))
)

(defun precio-total (precio amigos)
  (* precio (cantidad-de-pizzas amigos))
)

(defun cada-uno-paga (precio amigos)
  (/ (precio-total precio amigos) amigos)
)


;diego El mejor ejemplo X2
(Defun preciopizza(cantidadA precio)
    (/ (*(ceiling(/ (* 3 cantidadA)8)) precio ) cantidadA)
)