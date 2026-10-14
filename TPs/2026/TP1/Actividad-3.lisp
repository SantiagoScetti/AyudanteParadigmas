;; --------------------------------------------------------------------
;; Actividad N° 3: Funciones básicas de extracción en listas
;; --------------------------------------------------------------------

;; Ejercicio 1. Dada la lista: (A B (C D) E)
(defparameter lista-1 '(A B (C D) E))
;; a. Extraer átomo A
(car lista-1)

;; b. Extraer sublista (C D)
(caddr lista-1)

;; c. Extraer el último átomo (E)
;; (car (last lista-1))  ;; o también: (cadddr lista-1)

;; d. Obtener la lista (A B (C D))
(last lista-1)


;; Ejercicio 2. Dada la lista: ((A B) (C . D) ((E)))
(defparameter *lista-2* '((A B) (C . D) ((E))))
;; a. Extraer la lista (A B)
;; (car *lista-2*)

;; b. Extraer el átomo D del par punteado
;; (cdr (cadr *lista-2*))

;; c. Extraer el átomo E
;; (caar (caddr *lista-2*))

;; d. Extraer la sublista ((E))
;; (caddr *lista-2*)

;; e. De la lista (A (B (C . D))), extraer el par punteado (C . D)
(defparameter *lista-2e* '(A (B (C . D))))
;; (cadr (cadr *lista-2e*))


;; Ejercicio 3. Dada la lista: (1 (2 3) 4)
(defparameter *lista-3* '(1 (2 3) 4))
;; a. Extraer (1 (2 3))
;; (butlast *lista-3*)

;; b. Extraer el átomo 2
;; (caadr *lista-3*)