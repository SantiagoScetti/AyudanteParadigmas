Actividad Nº 8: 
Definir una función, la que a partir de dos listas ingresadas como parámetro, devuelva una nueva 
lista que asocie cada elemento no-numérico de la LISTA1 con el último elemento de la LISTA2

(defun P8 (l1 L2)
    (mapcar (lambda (x)
                (cond
                    ((numberp x) nil)
                    ((not (numberp x)) (cons x (last l2)))
                    (t nil)
                )
            ) 
    l1)
)