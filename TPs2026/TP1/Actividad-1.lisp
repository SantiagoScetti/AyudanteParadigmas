;; ====================================================================
;; PARADIGMAS Y LENGUAJES DE PROGRAMACION - UNIVERSIDAD NACIONAL DEL NORDESTE
;; LENGUAJE LISP - Trabajo Práctico N°1 (Año: 2.026)
;; ====================================================================

;; --------------------------------------------------------------------
;; Actividad N° 1: Expresiones en notación prefija


;; 1. Área y perímetro de un rectángulo
;; Área: 
(* A B)
;; Perímetro: 
(+ (* 2 A) (* 2 B))

;; 2. Área de un trapecio
(* (/ (+ b1 b2) 2) h)

;; 3. Área y perímetro de una circunferencia
;; Área: 
(* 3.1416 (* r r))
;; Perímetro: 
(* 2 (* 3.1416 r))

;; 4. Compra de dólares
(/ 520300 1450.50)

;; 5. Conversión de Hectáreas a m2
;; Expresión matemática: X * 10000
;; LISP: 
(* X 10000)

