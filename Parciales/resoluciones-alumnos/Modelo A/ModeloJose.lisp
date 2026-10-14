; parcial de parctica modelo Extraordinario A 

;punto 1 funcion predicado que determine si el aire es critico o normal 

(defun Critico-P (PM2.5 CO)
    (cond 
        ((> PM2.5 50) T)
        ((> CO 9) T)
        (T NIL)
    )
);devuelve T si el aire es critico y NIL si es normal

(defun Critico-P (PM2.5 CO)
    (and (and (numberp PM2.5) (numberp CO))  (or (> PM2.5 50) (> CO 9)))
)

(setq lista-pm25 '(39 25 59 45 51 27 63 34 32))
(setq lista-co '(2 4 4 10 10 5 7 17 2))


( Critico-P (cadr lista-pm25) (cadr lista-co))
; punto 2 para este pundo desarrollaremos dos funciones 

(defun indicador (PM2.5 CO)
    (if (Critico-P PM2.5 CO) 
        '1
        '0
    )
); devuelve 1 si el aire es critico y 0 si es normal

(defun Tablero-Luminoso (lista-PM2.5 lista-CO)
  (mapcar indicador lista-PM2.5 lista-CO)
)


(defun combinar-lecturas (pms cos)
    (mapcar (lambda (p c)
                (cond
                    ((lectura-critica-p p c) 1)
                    (T 0)))
            pms cos)
)
(setq lista-pm25 '(39 25 59 45 51 27 63 34 32))
(setq lista-co '(2  2))
;punto 3 funcion de monitore, tambien desarrollaremos dos funciones

(defun Contar-Criticos (lista-PM2.5 lista-CO)
    (cond
        ((endp lista-PM2.5) 0)
        ((Critico-P (first lista-PM2.5) (first lista-CO)) (+ 1 (Contar-Criticos (rest lista-PM2.5) (rest lista-CO))))
        (T (0 + (Contar-Criticos (rest lista-PM2.5) (rest lista-CO))))
    )
)

(defun Monitoreo (lista-PM2.5 lista-CO)
    (if((> (Contar-Criticos lista-PM2.5 lista-CO) 4))
        '(Activar Protocolo)
        '(Monitoreo Normal)
    )
)

;lucía
(defun contar-criticas (lista-pm-25 lista-co) 
    (if (null lista-pm-25)
        0  ; Caso base: si la lista está vacía, devuelve 0 para la suma
        (+ (critica-a-numero (car lista-pm-25) (car lista-co)) 
           (contar-criticas (cdr lista-pm-25) (cdr lista-co))) ; Rama falsa: si NO está vacía, suma y llama a la recursividad
    )
)


(defun protocolo (lista-pm-25 lista-co) 

    (if (>= (contar-criticas lista-pm-25 lista-co) 4) 
        '(Activar Protocolo) 
        '(Monitoreo Normal) 
    )
)
(defun critica-a-numero (pm25 co) 
    (if (predicado-aire-critico pm25 co)
        1 0)
)




;punto 4.2 empezamos por la deteccion de CO peligrosa 

(defun CO-Peligroso-P (lista-CO)
    (cond 
        ((endp lista-CO) nil)
        ((>= (first lista-CO) 9) t)
        (T (CO-Peligroso-P (rest lista-CO)))
    )
)

;punto 4.1 deteccion del pico de PM2.5 

(defun PM2.5-Pico (lista-PM2.5)
    (cond
        ((null lista-PM2.5) 0)
        ((null (rest listaPM2.5))   (first lista-PM2.5))
        (t(max (first lista-PM2.5) (PM2.5-Pico (rest lista-PM2.5))))
))

;fernanda:
(defun maximo-PM25 (lista-pm25)
	(cond
		((null(cdr lista-pm25)) (car lista-pm25))
		( (> (car lista-pm25) (maximo-PM25 (cdr lista-pm25))) (car lista-pm25) )
		(t (maximo-PM25 ( cdr lista-pm25)))
	)
)
(2 4 4 10 10 5 7 17 2)

(defun mayor-desde (lista tope)
    (cond
        (or (null lista) tope)
        ((not (numberp (car lista))) (mayor-desde (cdr lista) tope))
        ((> (car lista) tope) (mayor-desde (cdr lista) (car lista)))
        (T (mayor-desde (cdr lista) tope))
    )
)

(defun pico-pm25 (pms)
    (mayor-desde pms 0)
)
;Punto 5 funcion principal 

;primero una funcion auxiliar para verificar que ambas listas tienen solo numeros enteros

(defun todos-enteros-p (lista-PM2.5 lista-CO)
    (cond
        ((null lista-PM2.5) t)
        ((not (integerp (first lista-PM2.5))) nil)
        ((not (integerp (first lista-CO))) nil)
        (t (todos-enteros-p (cdr lista-PM2.5) (cdr lista-CO)))
    )
); devuelve t si todos los elementos de ambas listas son enteros, nil en caso contrario





(defun Calidad-Aire ()
    (print "ingresar lista de PM2.5:")
    (let ((lista-PM2.5 (read)))
    (print "ingresar lista de CO:")
    (let ((lista-CO (read)))
    (cond
        ((or (null lista-PM2.5)(null lista-CO))
            (pprint "Error, las listas no pueden estar vacias"))
        ((not (= (length lista-PM2.5)(length lista-CO)))
            (pprint "Error, las listas deben tener la misma longitud")
        )
        ((not (todos-enteros-p lista-PM2.5 lista-CO))
            (print "Error, todos los elementos deben ser números enteros")
        )
        (t
            (progn

                (pprint(Critico-P ((car PM2.5) (car CO))))

                (print "Resultados del monitoreo de calidad del aire:")

                (pprint "Tablero luminoso:")
                (pprint (Monitoreo (purificador lista-PM2.5) lista-CO))

                (and (pprint "Cantidad de lecturas críticas:")
                (pprint "fin del monitoreo"))
            )
        )
    )
    )
    )
)
(defun purificador (lista))


(> 10 (valor-pico  '( 5 5 8 9 111 0 0) 0) )
(valor-pico  '( 5 5 8 9 111 0 0) 0) 

(defun valor-pico (pm25-lista pico-actual)
    (cond
        ((null pm25-lista)   pico-actual)
        ((> (car pm25-lista)pico-actual)
            (valor-pico (cdr pm25-lista)(car pm25-lista)))
        (t(valor-pico (cdr pm25-lista)pico-actual))
    )
)