(defun P3 ()
    (let ((L nil))
        (print "Ingrese lista: ")
        (setq L (read))
        (if (listp L)
            (mapcar 'numberp L)  ;comprueba numberp con cada elemento de la lista L
            (pprint "debe Ingresar una lista")
        )
    ))