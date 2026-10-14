;; ====================================================================
;; PARADIGMAS Y LENGUAJES DE PROGRAMACION - UNIVERSIDAD NACIONAL DEL NORDESTE
;; LENGUAJE LISP - Trabajo Práctico N°2 (Año: 2.026)
;; ====================================================================

;; --------------------------------------------------------------------
;; Actividad N° 1: Funciones numéricas simples
;; --------------------------------------------------------------------

;; a. n es par
(defun es-par-p (n)
  (= (mod n 2) 0))
;; Prueba: (es-par-p 4) ; => T

;; b. n es múltiplo de m
(defun es-multiplo-p (n m)
  (= (mod n m) 0))
;; Prueba: (es-multiplo-p 15 5) ; => T

;; c. a es mayor que b
(defun es-mayor-p (a b)
  (> a b))
;; Prueba: (es-mayor-p 8 3) ; => T

;; d. n está entre a y b
(defun esta-entre-p (n a b)
  (and (>= n a) (<= n b)))
;; Prueba: (esta-entre-p 5 1 10) ; => T


;; --------------------------------------------------------------------
;; Actividad N° 2: Manejo de listas - Lluvia de Enero
;; --------------------------------------------------------------------

(defparameter *lluvia-enero*
  '((1 5.2) (2 0) (3 12.4) (4 8.1) (5 0) (6 3.3) (7 15.0) (8 2.1) (9 0) (10 9.5)))

;; a. Primer día que se informa lluvia
(defun primer-dia-informado (lluvia-enero)
  (car (first lluvia-enero)))
;; Prueba: (primer-dia-informado *lluvia-enero*) ; => 1

;; b. Lluvia caída el primer día informado
(defun lluvia-primer-dia (lluvia-enero)
  (cadr (first lluvia-enero)))
;; Prueba: (lluvia-primer-dia *lluvia-enero*) ; => 5.2

;; c. Último día que se informa lluvia
(defun ultimo-dia-informado (lluvia-enero)
  (car (car (last lluvia-enero))))
;; Prueba: (ultimo-dia-informado *lluvia-enero*) ; => 10

;; d. Lluvia caída el último día informado
(defun lluvia-ultimo-dia (lluvia-enero)
  (cadr (car (last lluvia-enero))))
;; Prueba: (lluvia-ultimo-dia *lluvia-enero*) ; => 9.5

;; e. Día y lluvia del 4to día registrado (sublista completa)
(defun registro-cuarto-dia (lluvia-enero)
  (nth 3 lluvia-enero))
;; Prueba: (registro-cuarto-dia *lluvia-enero*) ; => (4 8.1)

;; f. Lluvia caída el 4to día registrado
(defun lluvia-cuarto-dia (lluvia-enero)
  (cadr (nth 3 lluvia-enero)))
;; Prueba: (lluvia-cuarto-dia *lluvia-enero*) ; => 8.1

;; g. Predicado: (10 9.5) está en lluvia_enero
(defun esta-en-lluvia-enero-p (sublista lluvia-enero)
  (cond ((member sublista lluvia-enero :test #'equal) t)
        (t nil)))
;; Prueba: (esta-en-lluvia-enero-p '(10 9.5) *lluvia-enero*) ; => T


;; --------------------------------------------------------------------
;; Actividad N° 3: Distancia euclidiana entre posiciones
;; --------------------------------------------------------------------

(defun distancia-euclidiana (posiciones)
  (let* ((p1 (first posiciones))
         (p2 (second posiciones))
         (x1 (first p1)) (y1 (second p1))
         (x2 (first p2)) (y2 (second p2)))
    (sqrt (+ (expt (- x2 x1) 2) (expt (- y2 y1) 2)))))
;; Prueba: (distancia-euclidiana '((0 0) (3 4))) ; => 5.0


;; --------------------------------------------------------------------
;; Actividad N° 4: Evaluación de préstamos
;; --------------------------------------------------------------------

(defun evaluar-prestamo (edad sueldo)
  (cond ((< edad 18) "No apto")
        ((and (<= edad 25) (> sueldo 50000)) "Crédito Joven")
        ((and (> edad 25) (> sueldo 80000)) "Crédito Estándar")
        (t "En estudio")))
;; Prueba: (evaluar-prestamo 20 60000) ; => "Crédito Joven"
;; Prueba: (evaluar-prestamo 30 90000) ; => "Crédito Estándar"
;; Prueba: (evaluar-prestamo 16 10000) ; => "No apto"
;; Prueba: (evaluar-prestamo 40 30000) ; => "En estudio"


;; --------------------------------------------------------------------
;; Actividad N° 5: Días y temperaturas promedio de Enero
;; --------------------------------------------------------------------

(defparameter *dias-enero* '(1 2 3 4 5 6 7 8 9 10))
(defparameter *temp-promedio* '(37 35 37 36 34 33 35 38 39 36))

;; a. Primer día del mes junto con su temperatura promedio
(defun primer-dia-con-temperatura (dias-enero temp-promedio)
  (list (first dias-enero) (first temp-promedio)))
;; Prueba: (primer-dia-con-temperatura *dias-enero* *temp-promedio*) ; => (1 37)

;; b. Último día del mes junto con su temperatura promedio
(defun ultimo-dia-con-temperatura (dias-enero temp-promedio)
  (list (car (last dias-enero)) (car (last temp-promedio))))
;; Prueba: (ultimo-dia-con-temperatura *dias-enero* *temp-promedio*) ; => (10 36)

;; c. Nueva lista con todos los elementos de ambas listas, en el primer nivel
(defun unir-listas-plano (dias-enero temp-promedio)
  (append dias-enero temp-promedio))
;; Prueba: (unir-listas-plano *dias-enero* *temp-promedio*)

;; d. Nueva lista cuyo primer elemento es días_enero y segundo elemento es temp_promedio
(defun agrupar-listas (dias-enero temp-promedio)
  (list dias-enero temp-promedio))
;; Prueba: (agrupar-listas *dias-enero* *temp-promedio*) ; => ((1 2 ... 10) (37 35 ... 36))

;; e. Nueva lista con todos los elementos de ambas listas en el primer nivel
;; (mismo requerimiento que el ítem c, se resuelve con la misma función unir-listas-plano)

;; f. Todas las temperaturas promedio, menos la primera y la última
(defun temperaturas-intermedias (temp-promedio)
  (butlast (cdr temp-promedio)))
;; Prueba: (temperaturas-intermedias *temp-promedio*) ; => (35 37 36 34 33 35 38)
