Actividad Nº 3
A partir de una lista heterogénea que es ingresada por el operador, definir una función que permita el ingreso de dicha lista y pueda resolver cada una de las siguientes situaciones:
• Definir una función que permita devolver una lista cuyos elementos serán sublistas Cada sublista estará conformada por el elemento que sea una sublista de la lista ingresada por el operador junto con su longitud.
• A partir de una lista heterogénea que es ingresada como parámetro, definir una función que devuelva una lista cuyos elementos son el resultado de evaluar uno a uno si cada uno elemento de la lista ingresada como parámetro es una sublista.

(defun ingresoLista ()
  (let ((lista))
    (print "Ingrese la lista heterogénea:")
    (setq lista (read))
    (if (and (listp lista) (not (null lista)))
        (progn
          (pprint (Punto1A lista))
          (pprint (Punto1B lista)))
        (pprint "Debes ingresar una lista"))))

(defun Punto1A (lista)
  (cond
    ((endp lista) nil)
    ((listp (car lista)) (cons (list (car lista) (length (car lista))) (Punto1A (cdr lista))))
    (t (Punto1A (cdr lista)))))

(defun Punto1B (lista)
  (cond
    ((endp lista) nil)
    ((listp (car lista)) (cons T (Punto1B (cdr lista))))
    (t (cons "f" (Punto1B (cdr lista))))
  )
)




(4 (5 6 (3)) (5 8) 5 g 11 (A C C D))