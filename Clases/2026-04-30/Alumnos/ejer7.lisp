;Actividad N° 7: Historial de Llamadas (FunTel)
(cuandoHabloMas '((10 20) (5 5))) ; Debería devolver algo como Normal o lista 1
(cuandoHabloMas '((10 10) (5 15))) ;Debería devolver IGUAL
(cuandoHabloMas '(() (10 20)))

(LlamadaMasLarga '((10 50 5) (20 30))) ;Debería devolver (50 Normal) 
(LlamadaMasLarga '((50) (50)))
(LlamadaMasLarga '(() (20 30)))


(LlamadaMasCorta '((10 50) (5 30))) ;Debería devolver (5 Reducido)
(LlamadaMasCorta '((0 50) ()))

; ok
; historial de llamadas está organizado de una
; forma particular: en una lista con dos sublistas
;

(defun sumarLista (lista)
    (cond
        ((null lista) 0)
        (t (+ (car lista) (sumarLista (cdr lista))))
    )
)

;profe yo hice de otra forma sacando los maximos de cada horario


;(cuandoHabloMas '((10 2) (5 5 5)))

(defun cuandoHabloMas (lista)
    (cond
        (( > (sumarLista (car lista)) (sumarLista (cadr lista))) " Habla mas en Horario Normal")
        ((< (sumarLista (car lista)) (sumarLista (cadr lista))) "Hablas mas en el Horario Reducido")
        (t  "Habla IGUAL en ambos horarios")
    )
)

;(maximo '((10 2) (5 5 5)))
(defun maximo (lista max)
    (cond
        ((null lista) max)
        ((> (car lista) max)  (maximo (cdr lista)(car lista)))
        (t (maximo (cdr lista) max))
    )
) 


(LlamadaMasCorta '((10 50) (5 30)))

(defun llamadaMasLarga (lista) 
    (cond 
        ((> (maximo (car lista) 0) (maximo (cadr lista) 0))
            (list (maximo (car lista)0) "Llamada mas larga en Horario normal"))
            
        ((< (maximo (car lista) 0) (maximo (cadr lista) 0))
            (list (maximo (cadr lista) 0 ) "LLamada mas larga en Horario Reducido"))
            
        (t "La llamada es igual en ambos horarios")
    )
)
 
(min 10 50)
(#'min (10 50))


(defun minimo  (lista min) 
  (cond 
    ((null lista) min)
   ((< (car lista) min)
    (minimo (cdr lista)(car lista)))
   (t (minimo (cdr lista) min))
   )
   )


 (defun llamadaMasCorta (lista)
    (cond 
        ((< (minimo (car lista) 999999)(minimo (cadr lista) 999999)) (list (minimo (car lista) 999999) "Llamada mas corta en Horario Normal"))
        ((> (minimo (car lista) 999999) (minimo (cadr lista) 999999)) (list (minimo (cadr lista) 999999) "Llamada mas corta en Horario Reducido"))
        (t "La llamada mas corta es igual en ambos horario")
    )
)






(llamadaMasLarga '((10 2) (5 5 5)))


((10 2) (5 5 5))


((10 2 s) (5 5 5) s)

;asi hice yo el ejercicio completo del 7
(defun llamadaMasLarga (hor-normal)
  (cond ((null hor-normal) NIL) 
        ((> (CAR (hor-normal) ) (CADR hor-normal) ) ) 
	    (t (lamadaMasLarga (CDR hor-normal)))
        (pprint ("Llamada mas larga registrada en horario normal"))
  )
)

(defun llamadaMasLarga2 (hor-red)
  (cond ((null hor-red) NIL)
        ((> (CAR (hor-red)) (CADR hor-red) ) )
	(t (lamadaMasLarga2 (CDR hor-red))) 
    (pprint ("Llamada mas larga registrada en horario reducido"))
  )
)

(llamadaMasLarga(l)

    llamadaMasLarga (car l)
    lamadaMasLarga2 (cdr l) 
)





(LlamadaMasCorta '(10 50))

(defun llamadaMasCorta (hor_normal)
  (cond 
        ((endp hor_normal) 0)
        ((< (CAR hor_normal) (CADR hor_normal)) (llamadaMasCorta (cdr hor_normal))) 
        (t (llamadaMasCorta (CDR hor_normal)))
  )
)


(defun llamadaMasCorta2 (hor_red)
  (cond 
        ((endp hor_red) NIL)
        ((<= (CAR hor_red) (CADR hor_red)) (llamadaMasCorta2 (cdr hor_red))) 
        (t (llamadaMasCorta2 (CDR hor_red)) )

        ;(print "Llamada mas larga registrada en horario reducido") no
  )
)


(defun sumarTotRed (hor_red)
  ((endp hor_red) 0)
  (+ (CAR hor_red) (sumarTotRed (CDR hor_red)))
  (+ (sumarTotRed (CDR hor_red)))
)

(defun sumarTotNormal (hor_normal)
  ((endp hor_normal) 0)
  (+ (CAR hor_normal) (sumarTotNormal (CDR hor_normal)))
  (+ (sumarTotNormal (CDR hor_normal)))
)

(defun cuandoHabloMas ((car l) (cdr l))
  ( (> (sumarTotNormal hor_normal) (sumarTotRed hor_red))  'Hablo mas en el horario normal)
  ( (> (sumarTotRed hor_red) (sumarTotNormal hor_normal)) 'Hablo mas en el horario reducido)
  ( (= (sumarTotRed hor_red) (sumarTotNormal hor_normal) ) 'El usuario hablo la misma cantidad de minutos en ambos horarios)

)


;Yle 
(LlamadaMasCorta '((10 50) (5 30))) ;Debería devolver (5 Reducido)
(LlamadaMasCorta '((0 50) (4 5)))


;Seria con LISTP profe en este caso cuando es una lista con sublistas para comprobar eso

(defun comparar-llamadas (historial operador selector) 
    (let ((normal (apply selector (car historial))) (reducido (apply selector (cadr historial))))
        (cond 
            ((funcall operador normal reducido)(list 'Horario-Normal normal))
            ((funcall operador reducido normal)(list 'horario-reducido reducido))
            (t (list 'iguales normal))
        )
    )
)


(defun LlamadaMasCorta(historial)

    (comparar-llamadas historial #'< #'min) 
)

(defun LlamadaMasLarga(historial)
    (comparar-llamadas historial #'> #'max)
)


  