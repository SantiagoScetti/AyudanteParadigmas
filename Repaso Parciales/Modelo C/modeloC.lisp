1: El equipo quiere saber si la playlist es "intensa". Desarrollar una función predicado que reciba la
lista y un umbral (número) y determine si todas las canciones duran más que el umbral. 


(defun intensa (lista n)
  (cond
    ((endp lista) T)
    ((and(numberp(car lista))(numberp n)(> (car lista) n)) (intensa ((cdr lista) n)))
    (T nil)
  )
)

;Francisco Meza
(defun playlistint (lista umbral)
  (cond
    ((null lista) t)
    ((> (car lista) umbral) (playlistint (cdr lista) umbral))
    (t nil)
  )
)

2:  Para reorganizar la biblioteca, desarrollar una función que reciba la lista y devuelva una nueva
lista formada por dos sublistas, donde: (2 p)
● la primera sublista contiene las canciones que duran más de 60 segundos (tal cual, en
segundos);
● la segunda sublista contiene las que duran 60 o menos, pero expresadas en minutos
(dividir la duración por 60).

(defun mas_60 (lista)
  (cond 
      ((endp lista) NIL)
      ((and(numberp(car lista))(> (car lista) 60)) (cons (car lista)(mas_60 (cdr lista))))
      (T (mas_60 (cdr lista)))
  )
)

(defun menos_60 (lista)
  (cond 
      ((endp lista) NIL)
      ((and (numberp(car lista))(<= (car lista) 60)) (cons (/ (car lista) 60.0) (menos_60 (cdr lista))))
      (T (menos_60 (cdr lista)))
  )
)


(defun reorganizar (lista)
    (if (consp lista)
        (list (mas_60 lista) (menos_60 lista))
        nil
    )
)
(reorganizar '(55 55 65 65 55 78 98 1 0 100))




; punto 3 Desarrollar una función que reciba la lista y un umbral (número) y determine la cantidad de
;canciones que duran menos o igual que el umbral. (1.5 p)

(defun contar-intensas (lista umbral)
   (cond
      ((endp lista) 0)
      ( (>= (car lista) umbral) (+ 1 (contar-intensas (cdr lista) umbral)) )
      (T (contar-intensas (cdr lista) umbral) )
      )
)


(contar-intensas '(55 55 65 65 55 78 98 1 0 100) 60)


;punto 4 

(defun intensa-si-no (duracion umbral); este recibe el atomo de duracion y el umbral
  (if (> duracion umbral)
  'SI
  'NO
  )
)


(defun Recorrido (lista umbral)
    (mapcar (intensa-si-no lista umbral) )
)

(defun Recorrido (lista umbral)
  (mapcar #'(lambda (x) (intensa-si-no x umbral)) lista))

  ;Asi? 

  (Recorrido '(55 55 65 65 55 78 98 1 0 100) 60)


(defun marcar-largas (lista umbral)
    (mapcar (lambda (dur)
                (cond
                    ((not (numberp dur)) 'NO)
                    ((> dur umbral) 'SI)
                    (T 'NO)))
            lista)
)

  (marcar-largas '(55 55 65 65 55 78 98 1 0 100) 60)
