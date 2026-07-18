; MODELO 3 - INTEGRADOR (TODO JUNTO, ESTILO 2026) - SOLUCION DE REFERENCIA
; Apiario: (ID_COLMENA (TEMP_MIN TEMP_MAX) TEMP_ACTUAL PESO_ACTUAL CANTIDAD_ABEJAS)

; --- Accesores (dejan el resto de las funciones mas legibles) ---
(defun id (colmena) (car colmena))
(defun temp-min (colmena) (car (cadr colmena)))
(defun temp-max (colmena) (cadr (cadr colmena)))
(defun temp-actual (colmena) (caddr colmena))
(defun peso-actual (colmena) (cadddr colmena))
(defun cantidad-abejas (colmena) (car (cddddr colmena)))

; =============================================================================
; PUNTO 1 - produccion-miel
; =============================================================================
(defun produccion-miel (colmena)
    (* (/ (cantidad-abejas colmena) 1000) 0.5)
)

; =============================================================================
; PUNTO 2 - temp-en-rango-p
; =============================================================================
(defun temp-en-rango-p (colmena)
    (and (numberp (temp-actual colmena))
         (>= (temp-actual colmena) (temp-min colmena))
         (<= (temp-actual colmena) (temp-max colmena)))
)

; =============================================================================
; PUNTO 3 - estado-colmena
; =============================================================================
(defun estado-colmena (colmena)
    (cond
        ((temp-en-rango-p colmena) (list (id colmena) 'NORMAL))
        ((< (temp-actual colmena) (temp-min colmena)) (list (id colmena) 'RIESGO_FRIO))
        (T (list (id colmena) 'RIESGO_CALOR))
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
