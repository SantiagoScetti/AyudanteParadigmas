; MODELO 5 - DOS LISTAS DE NUMEROS EN PARALELO - SOLUCION DE REFERENCIA
; Panaderia:  CENTRO = (KILOS KILOS KILOS ...)
;             NORTE  = (KILOS KILOS KILOS ...)
;
; ACA NO HAY ACCESORES QUE APRENDERSE. Las dos listas son PLANAS:
;   (car centro)   -> YA ES el numero de kilos del primer dia
;   (cdr centro)   -> el resto de los dias
; No lleva caar ni cadar ni nada de eso: eso era para listas de sublistas.
;
; RECORRER DOS LISTAS A LA PAR:
;   - con MAPCAR: la lambda declara DOS parametros y se le pasan las DOS listas.
;   - con RECURSION: se avanza con (cdr l1) Y (cdr l2) en la MISMA llamada, y se
;     corta si CUALQUIERA de las dos se vacia (asi nunca se hace car de NIL).
;
; CRITERIO PARA ELEGIR LA HERRAMIENTA (el enunciado no lo dice):
;   MAPCAR    -> la lista de salida tiene la MISMA cantidad de elementos que la
;                de entrada y cada uno se calcula mirando solo su posicion.
;   RECURSION -> la salida es UN valor unico, o la lista de salida CAMBIA DE
;                LONGITUD (filtrar).
;
;   punto 2 -> MAPCAR de dos listas (misma longitud, un total por dia)
;   punto 3 -> MAPCAR de dos listas (misma longitud, una etiqueta por dia)
;   punto 4 -> RECURSION            (devuelve un numero)
;   punto 5 -> RECURSION de dos listas (devuelve un numero)
;   punto 6 -> RECURSION de dos listas (filtra: la salida es mas corta)


; =============================================================================
; PUNTO 1 - PREDICADO sobre dos numeros sueltos
; No recibe listas: recibe los kilos de un dia de cada sucursal.
; Un predicado devuelve T o NIL y nada mas: la comparacion ya devuelve eso, no
; hace falta ningun COND.
; =============================================================================
(defun dia-alto-p (kilos-centro kilos-norte)
    (> (+ kilos-centro kilos-norte) 200)
)


; =============================================================================
; PUNTO 2 - MAPCAR SOBRE DOS LISTAS
; La lambda recibe DOS parametros (uno de cada lista) y MAPCAR las recorre a la
; par. La salida tiene un elemento por dia, igual que las entradas.
; =============================================================================
(defun totales-por-dia (centro norte)
    (mapcar (lambda (c n) (+ c n)) centro norte)
)

; Se puede escribir mas corto pasando la funcion + directamente, sin lambda:
; (defun totales-por-dia (centro norte) (mapcar '+ centro norte))


; =============================================================================
; PUNTO 3 - MAPCAR SOBRE DOS LISTAS CON COND ADENTRO
; Cuando hay mas de un resultado posible, el COND va ADENTRO de la lambda.
; =============================================================================
(defun ganador-por-dia (centro norte)
    (mapcar (lambda (c n)
                (cond
                    ((> c n) 'CENTRO)
                    ((< c n) 'NORTE)
                    (T 'EMPATE)
                ))
            centro
            norte)
)


; =============================================================================
; PUNTO 4 - RECURSION SOBRE UNA LISTA: sumar
; Devuelve UN numero, asi que el caso base es 0 y se combina con +.
; =============================================================================
(defun total-sucursal (lista)
    (cond
        ((null lista) 0)
        (T (+ (car lista) (total-sucursal (cdr lista))))
    )
)


; =============================================================================
; PUNTO 5 - RECURSION SOBRE DOS LISTAS: contar
; Devuelve UN numero (cuantos dias), asi que es contador: caso base 0 y se
; combina con (+ 1 ...). Las dos listas avanzan juntas en cada llamada.
; =============================================================================
(defun dias-gano-centro (centro norte)
    (cond
        ((null centro) 0)
        ((null norte) 0)
        ((> (car centro) (car norte))
            (+ 1 (dias-gano-centro (cdr centro) (cdr norte))))
        (T (dias-gano-centro (cdr centro) (cdr norte)))
    )
)


; =============================================================================
; PUNTO 6 - RECURSION SOBRE DOS LISTAS: filtrar
; La salida es MAS CORTA que las entradas (solo van algunos dias), asi que se
; arma con CONS y el caso base es NIL.
; OJO: se compara mirando las DOS listas, pero lo que se guarda con CONS es
; solamente el numero de la lista NORTE.
; =============================================================================
(defun kilos-norte-superando (centro norte)
    (cond
        ((null centro) NIL)
        ((null norte) NIL)
        ((> (car norte) (car centro))
            (cons (car norte) (kilos-norte-superando (cdr centro) (cdr norte))))
        (T (kilos-norte-superando (cdr centro) (cdr norte)))
    )
)


; =============================================================================
; PUNTO 7 - MENU
; Unico lugar donde se usan variables locales (LET). Valida que las dos sean
; listas con datos y que tengan la misma cantidad de elementos: si no coinciden,
; el recorrido en paralelo no tiene sentido.
; =============================================================================
(defun menu ()
    (let (centro norte)
        (print "Ingrese los kilos vendidos por dia en la sucursal CENTRO:")
        (setq centro (read))
        (print "Ingrese los kilos vendidos por dia en la sucursal NORTE:")
        (setq norte (read))

        (if (and (consp centro) (consp norte)
                 (= (length centro) (length norte)))
            (progn
                (print "Total de kilos vendidos cada dia:")
                (print (totales-por-dia centro norte))
                (print "Sucursal que mas vendio cada dia:")
                (print (ganador-por-dia centro norte))
                (print "Total de la semana - CENTRO:")
                (print (total-sucursal centro))
                (print "Total de la semana - NORTE:")
                (print (total-sucursal norte))
                (print "Dias en que CENTRO le gano a NORTE:")
                (print (dias-gano-centro centro norte))
                (print "Kilos de NORTE en los dias que supero a CENTRO:")
                (print (kilos-norte-superando centro norte))
            )
            (print "Error: deben ser dos listas con la misma cantidad de elementos")
        )
    )
)


; =============================================================================
; DESAFIO a) - numero de dia con mayor venta conjunta
; Se resuelve reutilizando el punto 2: primero se arma la lista de totales por
; dia, despues se busca el maximo, y por ultimo en que posicion esta.
; MAXIMO-LISTA supone que la lista tiene al menos un elemento (el menu ya
; valido con CONSP que no venga vacia).
; =============================================================================
(defun maximo-lista (lista)
    (cond
        ((null (cdr lista)) (car lista))
        ((> (car lista) (maximo-lista (cdr lista))) (car lista))
        (T (maximo-lista (cdr lista)))
    )
)

(defun posicion-de (lista valor)
    (cond
        ((null lista) 0)
        ((= (car lista) valor) 1)
        (T (+ 1 (posicion-de (cdr lista) valor)))
    )
)

(defun mejor-dia (centro norte)
    (posicion-de (totales-por-dia centro norte)
                 (maximo-lista (totales-por-dia centro norte)))
)


; =============================================================================
; DESAFIO b) - promedio de una sucursal
; Promedio = suma / cantidad. Se reutiliza el punto 4 para la suma y se cuenta
; con otra recursion. FLOAT es para que muestre 124.28571 y no la fraccion
; 870/7, que es lo que devuelve LISP al dividir dos enteros.
; =============================================================================
(defun cantidad-dias (lista)
    (cond
        ((null lista) 0)
        (T (+ 1 (cantidad-dias (cdr lista))))
    )
)

(defun promedio-sucursal (lista)
    (cond
        ((null lista) 0)
        (T (float (/ (total-sucursal lista) (cantidad-dias lista))))
    )
)


; =============================================================================
; DATOS DE PRUEBA
; (setq centro '(120 95 140 80 160 200 75))
; (setq norte  '(90 110 140 60 175 150 95))
;
;   (dia-alto-p 120 90)                  -> T        (210 kilos)
;   (dia-alto-p 80 60)                   -> NIL      (140 kilos)
;   (totales-por-dia centro norte)       -> (210 205 280 140 335 350 170)
;   (ganador-por-dia centro norte)       -> (CENTRO NORTE EMPATE CENTRO NORTE
;                                            CENTRO NORTE)
;   (total-sucursal centro)              -> 870
;   (total-sucursal norte)               -> 820
;   (dias-gano-centro centro norte)      -> 3
;   (kilos-norte-superando centro norte) -> (110 175 95)
;
;   DESAFIO:
;   (mejor-dia centro norte)             -> 6        (350 kilos ese dia)
;   (promedio-sucursal centro)           -> 124.28571
;   (promedio-sucursal norte)            -> 117.14286
; =============================================================================
