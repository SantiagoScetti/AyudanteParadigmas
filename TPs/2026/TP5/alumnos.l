
(asociar '( 1 1 (1) (2 2) (3 3 3)) '(2 1))

(defun longitud(lista)
    (mapcar
        (lambda (x) 
            (if (listp x) 
                (length x)
                nil
            )
            )lista)
)

;p7
(defun asociar(L1 L2)
    (mapcar
        (lambda (x) 
            (if (not(numberp x)) 
                (list x (car(last L2)))
                NIL
            )
        )L1)
)

;punto 8

(sumo-ambos '(1 2 3 4 n) '(2 3 4 5 6))


(defun sumo-ambos (L1 L2)
    (if (and (consp L1) (consp L2))
        (mapcar 
            (lambda (x y) 
                (if (and (numberp x) (numberp y))
                    (+ x y)
                    nil
                )
            ) L1 L2)
        "Error: listas vacias"
    )
)

(listp '()) ----> T
(consp '()) ----> NIL


;RECU 2DO PARCIAL
3. Como la tripulación que maneja el puente de mando no tiene tiempo de leer números: necesitan un mapa visual. El hardware del barco espera recibir una lista de señales luminosas para encender focos rojos o verdes según el peligro de cada minuto de la ruta.
Desarrollar una función que reciba ambas listas y usando MAPCAR, retorne una lista donde 1 representa una situación de riesgo (luz roja) y 0 una situación segura (luz verde).

(20 21 22 18 19 11 0 1 2)

(1 1 2 3 5 4 8 15)

(defun P3 (temperaturass alturass) 
    (mapcar (lambda (x y) 
        (cond
            ((riesgo x y) 1)
            (t 0)
        )
    )temperaturass alturass)
)

(defun imprimirColores (l) 
    (mapcar (lambda (x) 
        (cond
            ((= x 1) '"roja")
            ((= x 0) '"verde")
            (t nil)
        )
    )l)
)


(defun riesgo (temperatura altura)
    (cond
        ((or (null temperatura)( null altura)) nil)
        ((or (< temperatura 10) (> altura 4.5)) t)
        (t nil)
    )
)

(imprimirColores (P3 '(20 21 22 18 19 11 0 1 2) '(1 1 2 3 5 4 8 15)))