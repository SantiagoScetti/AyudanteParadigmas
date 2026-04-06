Actividad Nº 9:
Definir la función sumo-ambos, la que a partir de 2 Listas no vacías: LISTA1 y LISTA2, devuelva 
una nueva Lista con el resultado de sumar elemento a elemento, los elementos de la misma 
posición. (1° elemento de LISTA1 con el 1° elemento de LISTA”, 2° elemento de LISTA1 con el 2° 
elemento de LISTA”, ….

(defun p9 (l1 l2)
    (if (and (consp l1) (consp l2))
        (mapcar (lambda(x y)
            (if (and (numberp x)(numberp y))
                (+ x y)
                (print "no number")
            )
        )l1 l2)
        (pprint "error")
    )
)

