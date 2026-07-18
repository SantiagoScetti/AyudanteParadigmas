; MODELO 1 - BASICO (TP1 a TP3) - TAREA - SOLUCION DE REFERENCIA
; Sin recursividad ni MAPCAR

; =============================================================================
; EJERCICIO 1
; =============================================================================
; a) Fila 1: Verdadero
;    Fila 2: Falso -> al original le falta el signo negativo, la traduccion
;            suma 9 en vez de restarlo (quedaria sqrt(y) + 2z + 9)
;    Fila 3: Verdadero
;
; b) (- (* 3 (+ p q)) (expt r 2)) tiene 3 elementos a nivel superior:
;    el operador -, la sublista (* 3 (+ p q)) y la sublista (expt r 2)

; =============================================================================
; EJERCICIO 2
; =============================================================================
(defun clasificar (x y)
    (cond
        ((and (listp x) (numberp y)) (list y x))
        ((and (numberp x) (atom y)) (cons x (list y)))
        ((and (listp x) (listp y)) (append y x))
    )
)

; a. (clasificar '(4 9) (- 20 15))  -> (5 (4 9))
; b. (clasificar (+ 2 3) 'hola)     -> (5 HOLA)
; c. (clasificar '(1 2) '(3 4))     -> (3 4 1 2)

; =============================================================================
; EJERCICIO 3 - Ferreteria "Todo Tornillo"
; =============================================================================
(defun alcanza-instalacion-p ()
    (let (metros)
        (pprint "Ingrese la cantidad de metros lineales a instalar:")
        (setq metros (read))
        (if (numberp metros)
            (and (>= metros 0)
                 (<= (* metros 120) 3000)
                 (<= (* metros 30) 1500)
                 (<= (* metros 0.05) 4))
            (pprint "Error: debe ingresar un valor numerico")
        )
    )
)

(defun materiales-estanteria (metros)
    (list metros
          (* metros 120 0.001)   ; tornillos en kg
          (* metros 30 0.001)    ; adhesivo en litros
          (* metros 0.05))       ; barniz en litros
)

(defun cantidad-estantes (metros)
    (ceiling (/ metros 0.9))
)
