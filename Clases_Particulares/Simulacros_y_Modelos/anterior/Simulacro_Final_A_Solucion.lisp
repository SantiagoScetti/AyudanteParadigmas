; =============================================================================
; SIMULACRO FINAL A - SOLUCIÓN
; TEMA: Gestión de Estaciones de Carga para Vehículos Eléctricos
; =============================================================================

; Estructura de la lista:
; (ID_ESTACION  (CAPACIDAD_MIN CAPACIDAD_MAX)  AUTOS_CARGANDO  PRECIO_KWH  KWH_DISPONIBLE)
;
; Acceso a los datos:
; (car est)              -> ID_ESTACION
; (cadr est)             -> (CAPACIDAD_MIN CAPACIDAD_MAX)
; (caddr est)            -> AUTOS_CARGANDO
; (cadddr est)           -> PRECIO_KWH
; (car (cddddr est))     -> KWH_DISPONIBLE
;
; (caadr est)            -> CAPACIDAD_MIN
; (cadadr est)           -> CAPACIDAD_MAX


; 1.- Recaudación potencial (PRECIO_KWH * KWH_DISPONIBLE)
(defun recaudacion-potencial (estacion)
    (* (cadddr estacion) (car (cddddr estacion)))
)

; 2.- Predicado límite permitido
(defun en-limite-p (estacion)
    (and (>= (caddr estacion) (caadr estacion))
         (<= (caddr estacion) (cadadr estacion)))
)

; 3.- Estado descriptivo (ID_ESTACION ESTADO)
(defun estado-estacion (estacion)
    (cond
        ((en-limite-p estacion) (list (car estacion) 'NORMAL))
        ((> (caddr estacion) (cadadr estacion)) (list (car estacion) 'SOBRECARGA))
        (T (list (car estacion) 'INACTIVA))
    )
)

; 4.- Bloque del sistema principal
; (A) Lista de estados de todas las estaciones con MAPCAR
(defun lista-estados-estaciones (red)
    (mapcar 'estado-estacion red)
)

; (B) Recaudación potencial total de la red con Recursividad
(defun recaudacion-total (red)
    (cond
        ((null red) 0)
        ((consp (car red)) (+ (recaudacion-potencial (car red)) (recaudacion-total (cdr red))))
        (T (recaudacion-total (cdr red))) ; Ignorar si hay basura (no sublista)
    )
)

; (C) Verificar si existe al menos una estación en SOBRECARGA
(defun existe-sobrecarga-p (red)
    (cond
        ((null red) NIL)
        ((> (caddr (car red)) (cadadr (car red))) T)
        (T (existe-sobrecarga-p (cdr red)))
    )
)

; Función que simula el programa principal ingresando datos por consola
(defun sistema-estaciones ()
    (let (red)
        (print "Ingrese la lista de estaciones:")
        (setq red (read))
        (if (listp red)
            (progn
                (print "ESTADOS:")
                (print (lista-estados-estaciones red))
                (print "RECAUDACION TOTAL:")
                (print (recaudacion-total red))
                (print "HAY SOBRECARGA?:")
                (print (existe-sobrecarga-p red))
            )
            (print "Error en el ingreso de datos.")
        )
    )
)
