Actividad Nº 2
A partir de una lista con las Notas de los parciales de un alumno, que es ingresada por el operador, definir una función predicado llamada Aprobado. La función debe evaluar si la materia está aprobada. Una materia está aprobada si todas las notas son 4 o valores mayores a 4

(defun ingresoNotas()
    (let ((notas))
        (print "ingrese la lista con las notas del alumno")
        (setq notas (READ))
            (if (and(listp notas) (not(eql notas nil)))
                (aprobado notas)
                (pprint "Debes ingresar una lista")
            )
            
    ))

(defun aprobado(notas)
    (cond
        ((endp notas) t)
        ((>= (car notas) 4 )(aprobado (cdr notas)))
        (t nil)
    )
)