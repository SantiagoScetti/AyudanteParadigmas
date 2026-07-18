; MODELO 1 - BASICO (TP1 a TP3) - CLASE - SOLUCION DE REFERENCIA
; Sin recursividad ni MAPCAR

; =============================================================================
; EJERCICIO 1
; =============================================================================
; a) Fila 1: Verdadero
;    Fila 2: Falso -> al original le falta el signo negativo, la traduccion
;            suma 7 en vez de restarlo (quedaria 4x^2 + 3x + 7)
;    Fila 3: Verdadero
;
; b) (- (sqrt (+ a b)) (* 2 (expt c 3))) tiene 3 elementos a nivel superior:
;    el operador -, la sublista (sqrt (+ a b)) y la sublista (* 2 (expt c 3))

; =============================================================================
; EJERCICIO 2
; =============================================================================
(defun revisar (a b)
    (cond
        ((and (numberp a) (listp b)) (cons a b))
        ((and (listp a) (atom b)) (append a (list b)))
        ((and (numberp a) (numberp b)) (list a b))
    )
)

; a. (revisar 5 '(2 8 1))        -> (5 2 8 1)
; b. (revisar '(1 2) (+ 3 4))    -> (1 2 7)
; c. (revisar (- 10 4) (* 2 3))  -> (6 6)

; =============================================================================
; EJERCICIO 3 - Vivero "El Brote Verde"
; =============================================================================
(defun alcanza-fertilizacion-p ()
    (let (m2)
        (pprint "Ingrese la cantidad de metros cuadrados a fertilizar:")
        (setq m2 (read))
        (if (numberp m2)
            (and (>= m2 0)
                 (<= (* m2 80) 2000)
                 (<= (* m2 40) 1000)
                 (<= (* m2 0.15) 8))
            (pprint "Error: debe ingresar un valor numerico")
        )
    )
)

(defun materiales-necesarios (m2)
    (list m2
          (* m2 80 0.001)    ; fertilizante en kg
          (* m2 40 0.001)    ; fungicida en litros
          (* m2 0.15))       ; agua en litros
)

(defun largo-almacigo (area)
    (/ area 1.2)
)
