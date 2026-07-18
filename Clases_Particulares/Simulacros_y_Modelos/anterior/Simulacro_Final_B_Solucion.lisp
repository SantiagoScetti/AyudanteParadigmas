; =============================================================================
; SIMULACRO FINAL B - SOLUCIÓN
; TEMA: Gestión de Misiones Espaciales
; =============================================================================

; Estructura de la lista:
; (ID_SATELITE CAPACIDAD_DATOS (TEMPERATURA_ACTUAL TEMPERATURA_MIN TEMPERATURA_MAX) CONSUMO_ENERGIA)
;
; Acceso a los datos:
; (car sat)              -> ID_SATELITE
; (cadr sat)             -> CAPACIDAD_DATOS
; (caddr sat)            -> (TEMPERATURA_ACTUAL TEMPERATURA_MIN TEMPERATURA_MAX)
; (cadddr sat)           -> CONSUMO_ENERGIA
;
; (caaddr sat)           -> TEMPERATURA_ACTUAL
; (cadr (caddr sat))     -> TEMPERATURA_MIN
; (caddr (caddr sat))    -> TEMPERATURA_MAX


; 1.- Eficiencia de transmisión (CAPACIDAD / CONSUMO)
(defun eficiencia (satelite)
    (/ (cadr satelite) (cadddr satelite))
)

; 2.- Predicado sobrecalentamiento (ACTUAL > MAX)
(defun peligro-sobrecalentamiento-p (satelite)
    (> (caaddr satelite) (caddr (caddr satelite)))
)

; 3.- Estado descriptivo (ID CRITICO/OPERATIVO)
(defun estado-satelite (satelite)
    (cond
        ((or (< (caaddr satelite) (cadr (caddr satelite)))
             (> (caaddr satelite) (caddr (caddr satelite))))
         (list (car satelite) 'CRITICO))
        (T (list (car satelite) 'OPERATIVO))
    )
)

; 4.- Bloque del sistema principal
; (A) Lista con Identificador y Eficiencia usando MAPCAR
(defun id-y-eficiencia (satelite)
    (list (car satelite) (eficiencia satelite))
)

(defun reporte-eficiencia (flota)
    (mapcar 'id-y-eficiencia flota)
)

; (B) Consumo de energía total usando Recursividad
(defun consumo-total (flota)
    (cond
        ((null flota) 0)
        ((consp (car flota)) (+ (cadddr (car flota)) (consumo-total (cdr flota))))
        (T (consumo-total (cdr flota)))
    )
)

; (C) Existe algún satélite en peligro
(defun existe-peligro-p (flota)
    (cond
        ((null flota) NIL)
        ((peligro-sobrecalentamiento-p (car flota)) T)
        (T (existe-peligro-p (cdr flota)))
    )
)

; Función que simula el programa principal ingresando datos por consola
(defun sistema-satelites ()
    (let (flota)
        (print "Ingrese la lista de satelites de la mision:")
        (setq flota (read))
        (if (listp flota)
            (progn
                (print "EFICIENCIA DE TRANSMISION:")
                (print (reporte-eficiencia flota))
                (print "CONSUMO TOTAL DE ENERGIA:")
                (print (consumo-total flota))
                (print "HAY PELIGRO DE SOBRECALENTAMIENTO?:")
                (print (existe-peligro-p flota))
            )
            (print "Error en el ingreso de datos.")
        )
    )
)
