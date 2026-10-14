 ; Actividad N° 5: 
En una pequeña ciudad, el área de meteorología decidió llevar un registro detallado de las 
temperaturas máximas durante el mes de enero. Para ello, un operador carga día a día los 
valores en una lista llamada, donde cada elemento representa la temperatura máxima de un 
día del mes. 
A partir de este registro, el equipo necesita analizar la información para obtener distintos 
datos  releva


(defun pedir-datos-num ()
  (format t "Ingrese un numero (o la palabra FIN para terminar): ")
  (let ((entrada (read)))
    (cond ((equal entrada 'fin) nil)
          ((numberp entrada) (cons entrada (pedir-datos-num)))
          (t (format t "Dato no válido, por favor ingrese un número o FIN para terminar.")
            (pedir-datos-num)))))

(defun dias_menos_38 (l) 
  (cond ((null l) 0)
        ((< (car l) 38) (+ 1 (dias_menos_38 (cdr l))))
        (t (dias_menos_38 (cdr l))))
)


(defun temperatura_prom_enero(l)
  (cond ((null l) 0)
        (t (/ (+ (car l) (temperatura_prom_enero (cdr l))) (length l)))
  )
)




(es_ascendente '(30 32 32 1))
(defun es_ascendente(l)

  (cond ((or (null l) (null (cdr l))) t)
        ((> (car l) (cadr l)) nil)
        (t (es_ascendente(cdr l)))
  )
)
; (temperatura_prom_enero '(30 35 30 38))
; (30 35 38)

 (defun esRepetido (lista)
    (cond
        ((null lista) nil)
        ((member (car lista)(cdr lista)) (esRepetido (cdr lista)))          ;¿el primero ya está en el resto?
        (t (cons (car lista) (esRepetido (cdr lista))))
    )
)





; actividad 6
(defun ingreso_lista ()
    (format t "Ingrese lista heterogenea: ")
    (read))

(defun ingreso_valores_atomicos ()
    (format t "Ingrese átomo: ")
    (read))


; 1. definir funcion predicate ( determine si la misma contiene únicamente valores atómicos.)
(defun tiene_solamente_valores_atom (L)
    (cond
        ((null L) t)
        ((atom (car L)) (tiene_solamente_valores_atom (cdr L)) )
        (t (tiene_solamente_valores_atom (cdr L)))
    )
)


; 2. Una función, la que a partir de la lista y el valor atómico, determine
; la cantidad de valores que sean menores o iguales al valor atómico
(defun retornar_cant_valores_lessorequal_valor-atom () ())






