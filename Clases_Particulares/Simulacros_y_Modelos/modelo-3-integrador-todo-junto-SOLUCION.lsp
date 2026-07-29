; MODELO 3 - INTEGRADOR (TODO JUNTO, ESTILO 2026) - SOLUCION DE REFERENCIA
; Apiario: (ID_COLMENA (TEMP_MIN TEMP_MAX) TEMP_ACTUAL PESO_ACTUAL CANTIDAD_ABEJAS)

; Estructura de cada colmena: (ID_COLMENA (TEMP_MIN TEMP_MAX) TEMP_ACTUAL PESO_ACTUAL CANTIDAD_ABEJAS)
;   ID_COLMENA       -> (car colmena)
;   TEMP_MIN         -> (car (cadr colmena))  = (caadr  colmena)
;   TEMP_MAX         -> (cadr (cadr colmena)) = (cadadr colmena)
;   TEMP_ACTUAL      -> (caddr colmena)
;   PESO_ACTUAL      -> (cadddr colmena)
;   CANTIDAD_ABEJAS  -> (car (cddddr colmena))   ; no hay combo de 5 letras, se deja asi

; =============================================================================
; PUNTO 1 - produccion-miel
; =============================================================================
(defun produccion-miel (colmena)
    (* (/ (car (cddddr colmena)) 1000) 0.5)
)

; =============================================================================
; PUNTO 2 - temp-en-rango-p
; =============================================================================
(defun temp-en-rango-p (colmena)
    (and (numberp (caddr colmena))
         (>= (caddr colmena) (caadr colmena))
         (<= (caddr colmena) (cadadr colmena)))
)

; =============================================================================
; PUNTO 3 - estado-colmena
; =============================================================================
(defun estado-colmena (colmena)
    (cond
        ((temp-en-rango-p colmena) (list (car colmena) 'NORMAL))
        ((< (caddr colmena) (caadr colmena)) (list (car colmena) 'RIESGO_FRIO))
        (T (list (car colmena) 'RIESGO_CALOR))
    )
)

; =============================================================================
; PUNTO 4
; =============================================================================
; (a) MAPCAR: estado de todas las colmenas
(defun estados-apiario (apiario)
    (mapcar 'estado-colmena apiario)
)

; (b) Recursion: produccion total del apiario
(defun produccion-total (apiario)
    (cond
        ((null apiario) 0)
        ((not (consp (car apiario))) (produccion-total (cdr apiario)))
        (T (+ (produccion-miel (car apiario)) (produccion-total (cdr apiario))))
    )
)

; (c) Predicado existencial: hay al menos una colmena en riesgo
(defun hay-riesgo-p (apiario)
    (cond
        ((null apiario) NIL)
        ((not (consp (car apiario))) (hay-riesgo-p (cdr apiario)))
        ((not (temp-en-rango-p (car apiario))) T)
        (T (hay-riesgo-p (cdr apiario)))
    )
)

; Funcion principal: pide el dato, valida, y muestra el informe
(defun principal ()
    (let (apiario)
        (pprint "Ingrese la lista de colmenas del apiario:")
        (setq apiario (read))
        (if (listp apiario)
            (progn
                (pprint (estados-apiario apiario))
                (pprint (produccion-total apiario))
                (pprint (hay-riesgo-p apiario)))
            (pprint "Error: debe ingresar una lista de colmenas")
        )
    )
)

; Datos de prueba:
;   (C1 (34 36) 35 42 20000)   -> NORMAL,       produccion: 10.0
;   (C2 (34 36) 31 40 15000)   -> RIESGO_FRIO,  produccion: 7.5
;   (C3 (34 36) 38 45 25000)   -> RIESGO_CALOR, produccion: 12.5
;
; Lista de prueba para el punto 4:
; ((C1 (34 36) 35 42 20000) (C2 (34 36) 31 40 15000) (C3 (34 36) 38 45 25000))
;   estados-apiario -> ((C1 NORMAL) (C2 RIESGO_FRIO) (C3 RIESGO_CALOR))
;   produccion-total -> 30.0
;   hay-riesgo-p -> T
