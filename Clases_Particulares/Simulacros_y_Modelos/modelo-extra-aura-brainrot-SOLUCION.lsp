; MODELO EXTRA - AURATRACKER 9000 (EDICION BRAINROT) - SOLUCION DE REFERENCIA
; Ranking:  PERSONAJE = (NOMBRE AURA)
;
; Accesores de un PERSONAJE:
;   NOMBRE -> (car  personaje)
;   AURA   -> (cadr personaje)
;
; Sobre la lista completa:
;   (car lista)        -> el primer PERSONAJE entero (una sublista)
;   (car (car lista))  -> el NOMBRE del primero   = (caar  lista)
;   (cadr (car lista)) -> el AURA del primero     = (cadar lista)
;
; Es el modelo mas liviano de la carpeta: sublistas de 2 elementos y numeros
; enteros. Sirve para repasar los cinco moldes de una sola sentada.
;
; CRITERIO PARA ELEGIR LA HERRAMIENTA (el enunciado no lo dice):
;   MAPCAR    -> la lista de salida tiene la MISMA cantidad de elementos que la
;                de entrada y cada uno se calcula mirando solo su posicion.
;   RECURSION -> la salida es UN valor unico, o la lista de salida CAMBIA DE
;                LONGITUD (filtrar).
;
;   punto 3 -> MAPCAR    (misma longitud, un estado por personaje)
;   punto 4 -> RECURSION (devuelve un numero)
;   punto 5 -> RECURSION (filtra: la salida es mas corta)
;   punto 6 -> MAPCAR    (misma longitud, cada uno con el aura descontada)


; =============================================================================
; PUNTO 1 - PREDICADO: esta cocinado
; Un predicado devuelve T o NIL y nada mas: la comparacion ya devuelve eso,
; no hace falta ningun COND ni ningun IF.
; =============================================================================
(defun cocinado-p (personaje)
    (< (cadr personaje) 0)
)


; =============================================================================
; PUNTO 2 - CLASIFICADOR CON COND
; El COND prueba en orden: si no entro por la primera rama, ya se sabe que el
; aura no es negativa, asi que la segunda no necesita volver a preguntarlo.
; Se devuelve una LISTA de dos elementos, por eso se arma con LIST.
; =============================================================================
(defun estado-personaje (personaje)
    (cond
        ((< (cadr personaje) 0) (list (car personaje) 'COOKED))
        ((<= (cadr personaje) 1000) (list (car personaje) 'MID))
        (T (list (car personaje) 'SIGMA))
    )
)


; =============================================================================
; PUNTO 3 - MAPCAR: un estado por cada personaje
; Se reutiliza la funcion del punto 2 tal cual. Se puede escribir mas corto
; pasando el nombre de la funcion: (mapcar 'estado-personaje ranking)
; =============================================================================
(defun estados-del-ranking (ranking)
    (mapcar (lambda (personaje) (estado-personaje personaje)) ranking)
)


; =============================================================================
; PUNTO 4 - RECURSION: sumar
; Devuelve UN numero, asi que el caso base es 0 y se combina con +.
; Ojo: se suma (cadr (car ranking)), que es el AURA del primero. Poner
; (car ranking) sumaria la sublista entera y explota.
; =============================================================================
(defun aura-total (ranking)
    (cond
        ((null ranking) 0)
        (T (+ (cadr (car ranking)) (aura-total (cdr ranking))))
    )
)


; =============================================================================
; PUNTO 5 - RECURSION QUE FILTRA
; La salida es MAS CORTA que la entrada, asi que MAPCAR no sirve: se arma con
; CONS y el caso base es NIL.
; Ojo con QUE se guarda: el enunciado pide los NOMBRES, no las sublistas
; enteras, por eso va (car (car ranking)) y no (car ranking).
; Se reutiliza el predicado del punto 1 como condicion de la rama.
; =============================================================================
(defun hall-of-shame (ranking)
    (cond
        ((null ranking) NIL)
        ((cocinado-p (car ranking))
            (cons (car (car ranking)) (hall-of-shame (cdr ranking))))
        (T (hall-of-shame (cdr ranking)))
    )
)


; =============================================================================
; PUNTO 6 - MAPCAR QUE TRANSFORMA
; La salida tiene la misma cantidad de elementos y cada uno sale de su propia
; sublista: es MAPCAR. La lambda arma una sublista nueva con LIST, dejando el
; nombre tal cual y reemplazando el aura por el aura menos 100.
; =============================================================================
(defun fanum-tax (ranking)
    (mapcar (lambda (personaje)
                (list (car personaje) (- (cadr personaje) 100)))
            ranking)
)


; =============================================================================
; PUNTO 7 - MENU
; Unico lugar donde se usan variables locales (LET). Un solo IF, sin anidar.
; =============================================================================
(defun menu ()
    (let (ranking)
        (print "Ingrese el ranking de aura ((NOMBRE AURA) ...):")
        (setq ranking (read))

        (if (consp ranking)
            (progn
                (print "Estado de cada personaje:")
                (print (estados-del-ranking ranking))
                (print "Aura total acumulada:")
                (print (aura-total ranking))
                (print "Hall of shame (los cocinados):")
                (print (hall-of-shame ranking))
                (print "Ranking despues del fanum tax:")
                (print (fanum-tax ranking))
            )
            (print "Error: debe ingresar una lista con datos")
        )
    )
)


; =============================================================================
; DESAFIO a) - SIX SEVEN
; Mismo molde que el punto 5 (filtro que devuelve nombres), cambiando nada mas
; la condicion. Para comparar numeros va = ; EQUAL tambien anda, pero = es lo
; que corresponde con numeros.
; =============================================================================
(defun six-seven (ranking)
    (cond
        ((null ranking) NIL)
        ((= (cadr (car ranking)) 67)
            (cons (car (car ranking)) (six-seven (cdr ranking))))
        (T (six-seven (cdr ranking)))
    )
)


; =============================================================================
; DESAFIO b) - EL MAS GOATED
; Maximo sobre una lista de sublistas. El caso base es "queda uno solo: ese es
; el mejor", y en cada vuelta se compara el primero contra el mejor del resto.
; La auxiliar devuelve la SUBLISTA ganadora y recien al final se le saca el
; nombre: asi no se pierde el dato del aura durante la comparacion.
; Supone que el ranking tiene al menos un personaje (el menu ya valido CONSP).
; =============================================================================
(defun mejor-personaje (ranking)
    (cond
        ((null (cdr ranking)) (car ranking))
        ((> (cadr (car ranking)) (cadr (mejor-personaje (cdr ranking))))
            (car ranking))
        (T (mejor-personaje (cdr ranking)))
    )
)

(defun el-mas-goated (ranking)
    (car (mejor-personaje ranking))
)


; =============================================================================
; DATOS DE PRUEBA
; (setq ranking '((TRALALERO 5000) (BOMBARDIRO -300) (TUNG-TUNG 67)
;                 (BALLERINA 1200) (CHIMPANZINI -50) (PATAPIM 900)))
;
;   (cocinado-p '(BOMBARDIRO -300))  -> T
;   (cocinado-p '(TRALALERO 5000))   -> NIL
;   (estado-personaje '(TUNG-TUNG 67)) -> (TUNG-TUNG MID)
;   (estados-del-ranking ranking)    -> ((TRALALERO SIGMA) (BOMBARDIRO COOKED)
;                                        (TUNG-TUNG MID) (BALLERINA SIGMA)
;                                        (CHIMPANZINI COOKED) (PATAPIM MID))
;   (aura-total ranking)             -> 6817
;   (hall-of-shame ranking)          -> (BOMBARDIRO CHIMPANZINI)
;   (fanum-tax ranking)              -> ((TRALALERO 4900) (BOMBARDIRO -400)
;                                        (TUNG-TUNG -33) (BALLERINA 1100)
;                                        (CHIMPANZINI -150) (PATAPIM 800))
;
;   DESAFIO:
;   (six-seven ranking)              -> (TUNG-TUNG)
;   (el-mas-goated ranking)          -> TRALALERO
; =============================================================================
