;; ====================================================================
;; PARADIGMAS Y LENGUAJES DE PROGRAMACION - UNIVERSIDAD NACIONAL DEL NORDESTE
;; LENGUAJE LISP - Trabajo Práctico N°3 (Año: 2.026)
;; ====================================================================

;; --------------------------------------------------------------------
;; Actividad N° 1: Funciones propias
;; --------------------------------------------------------------------

;; a. Compra de dólares a partir de un monto en pesos
(defun comprar-dolares (monto cotizacion)
  (cond ((or (< monto 0) (<= cotizacion 0)) "Error: Los valores ingresados deben ser positivos.")
        (t (/ monto cotizacion))))
;; Prueba: (comprar-dolares 145000 350.75)

;; b. Volumen de un cilindro
(defun volumen-cilindro (radio altura)
  (cond ((or (<= radio 0) (<= altura 0)) "Error: El radio y la altura deben ser mayores a cero.")
        (t (* pi (* radio radio) altura))))
;; Prueba: (volumen-cilindro 3 10)

;; c. Área de un trapecio
(defun area-trapecio (base-mayor base-menor altura)
  (cond ((or (<= base-mayor 0) (<= base-menor 0) (<= altura 0)) "Error: Los valores deben ser mayores a cero.")
        (t (* (/ (+ base-mayor base-menor) 2) altura))))
;; Prueba: (area-trapecio 8 5 4)


;; --------------------------------------------------------------------
;; Actividad N° 2: Función predicado palíndromo
;; --------------------------------------------------------------------

(defun palindromo (lista)
  (equal lista (reverse lista)))
;; Prueba: (palindromo '(I T A T I)) ; => T


;; --------------------------------------------------------------------
;; Actividad N° 3: Función describir
;; --------------------------------------------------------------------

(defun describir (x)
  (cond ((null x) 'VACIA)
        ((atom x) (list 'ATOMO x))
        ((listp x) (list 'LISTA (length x) (car x)))
        (t "Error: Entrada no válida.")
  )
)
;; Prueba: (describir '(a b c)) ; => (LISTA 3 A)
;; Prueba: (describir 5)        ; => (ATOMO 5)
;; Prueba: (describir '())      ; => VACIA


;; --------------------------------------------------------------------
;; Actividad N° 4: Función mi-segundo
;; --------------------------------------------------------------------

(defun mi-segundo (lista atomo)
  (cond ((not (listp lista)) "Error: El primer argumento debe ser una lista.")
        (t (cons atomo lista))))
;; Prueba: (mi-segundo '(a b c) 'x) ; => (X A B C)


;; --------------------------------------------------------------------
;; Actividad N° 5: Clasificación de triángulos
;; --------------------------------------------------------------------

(defun triangulo-valido-p (lado1 lado2 lado3)
  (and (< lado1 (+ lado2 lado3)) (> lado1 (abs (- lado2 lado3)))
       (< lado2 (+ lado1 lado3)) (> lado2 (abs (- lado1 lado3)))
       (< lado3 (+ lado1 lado2)) (> lado3 (abs (- lado1 lado2)))))

(defun clasifico-triangulos (lado1 lado2 lado3)
  (cond ((not (triangulo-valido-p lado1 lado2 lado3)) "Error: Los lados no forman un triángulo válido.")
        ((and (= lado1 lado2) (= lado2 lado3)) "Equilátero")
        ((or (= lado1 lado2) (= lado2 lado3) (= lado1 lado3)) "Isósceles")
        (t "Escaleno")))
;; Prueba: (clasifico-triangulos 5 5 5) ; => "Equilátero"
;; Prueba: (clasifico-triangulos 5 5 8) ; => "Isósceles"
;; Prueba: (clasifico-triangulos 3 4 5) ; => "Escaleno"


;; --------------------------------------------------------------------
;; Actividad N° 6: Función clima
;; --------------------------------------------------------------------

(defun clima (temperatura)
  (cond ((not (numberp temperatura)) "Error: Debe ingresar un valor numérico.")
        ((< temperatura 0) "Helado")
        ((< temperatura 10) "Frío")
        ((< temperatura 20) "Templado")
        ((< temperatura 30) "Cálido")
        (t "Abrasador")))
;; Prueba: (clima -5) ; => "Helado"
;; Prueba: (clima 25) ; => "Cálido"


;; --------------------------------------------------------------------
;; Actividad N° 7: Registros de temperaturas máximas
;; --------------------------------------------------------------------

(defparameter *max-enero*
  '(28 30 31 29 32 27 26 33 30 29 31 28 27 30 31 32 29 28 30 31 33 29 27 30 28 31 29 30 32 28 31))

(defparameter *max-febrero*
  '(29 31 30 28 27 32 33 29 30 31 28 27 29 30 31 32 29 28))


;; --------------------------------------------------------------------
;; Actividad N° 8: Predicado de temperatura registrada en enero o febrero
;; --------------------------------------------------------------------

(defun registrada-en-enero-o-febrero-p (temp-ayer max-enero max-febrero)
  (cond ((or (member temp-ayer max-enero) (member temp-ayer max-febrero)) t)
        (t nil)))
;; Prueba: (registrada-en-enero-o-febrero-p 30 *max-enero* *max-febrero*) ; => T


;; --------------------------------------------------------------------
;; Actividad N° 9: Predicados sobre max_temp
;; --------------------------------------------------------------------

;; a. Temperatura del primer día entre 40 y 45 grados
(defun primer-dia-entre-40-45-p (max-temp)
  (and (>= (car max-temp) 40) (<= (car max-temp) 45)))

;; b. Algún día del mes tuvo máxima de 40
(defun algun-dia-max-40-p (max-temp)
  (cond ((member 40 max-temp) t)
        (t nil)))
(= 40 (Car(member 40 '(50 50 40 50)) ))
      
;; c. Primer y último día con la misma temperatura
(defun primer-y-ultimo-dia-iguales-p (max-temp)
  (= (car max-temp) (car (last max-temp))))

;; Prueba: (primer-dia-entre-40-45-p '(42 30 28))
;; Prueba: (algun-dia-max-40-p '(35 40 28))
;; Prueba: (primer-y-ultimo-dia-iguales-p '(30 28 30))


;; --------------------------------------------------------------------
;; Actividad N° 10: Función predicado dentro-de-rango-p
;; --------------------------------------------------------------------

(defun dentro-de-rango-p (valor minimo maximo)
  (and (>= valor minimo) (<= valor maximo)))
;; Prueba: (dentro-de-rango-p 15 10 20) ; => T


;; --------------------------------------------------------------------
;; Actividad N° 11: Rotación de listas
;; --------------------------------------------------------------------

;; a. Rotación a la derecha
(defun rotar-derecha (lista)
  (cond ((null lista) nil)
        (t (append (cdr lista) (list (car lista))))))
;; Prueba: (rotar-derecha '(1 2 3 4)) ; => (2 3 4 1)

;; b. Rotación a la izquierda
(defun rotar-izquierda (lista)
  (cond ((null lista) nil)
        (t (append (last lista) (butlast lista)))))
;; Prueba: (rotar-izquierda '(1 2 3 4)) ; => (4 1 2 3)


;; --------------------------------------------------------------------
;; Actividad N° 12: Posición de un elemento en una lista
;; --------------------------------------------------------------------

(defun posicion (elemento lista)
  (cond ((null lista) nil)
        ((equal (car lista) elemento) 0)
        (t (let ((resto (posicion elemento (cdr lista))))
             (cond (resto (1+ resto))
                   (t nil))))))
;; Prueba: (posicion 'c '(a b c d)) ; => 2


;; --------------------------------------------------------------------
;; Actividad N° 13: Nivel del río
;; --------------------------------------------------------------------

;; a. Dispersión del nivel del río
(defun dispersion-rio (nivel-mas-alto nivel-mas-bajo)
  (cond ((< nivel-mas-alto nivel-mas-bajo) "Error: El nivel más alto no puede ser menor al más bajo.")
        (t (- nivel-mas-alto nivel-mas-bajo))))
;; Prueba: (dispersion-rio 150 130) ; => 20

;; b. Clasificación de los días según la dispersión
(defun clasificar-dias-rio (dispersion)
  (cond ((< dispersion 30) "Parejos")
        ((> dispersion 100) "Locos")
        (t "Normales")))
;; Prueba: (clasificar-dias-rio (dispersion-rio 150 130)) ; => "Parejos"


;; --------------------------------------------------------------------
;; Actividad N° 14: Peso de los pinos
;; --------------------------------------------------------------------

;; a. Peso de un pino según su altura
(defun peso-pino (altura)
  (cond ((<= altura 0) "Error: La altura debe ser mayor a cero.")
        ((<= altura 3) (* altura 100 3))
        (t (+ (* 3 100 3) (* (- altura 3) 100 2)))))
;; Prueba: (peso-pino 2) ; => 600
;; Prueba: (peso-pino 5) ; => 1300

;; b. Predicado: el peso le sirve a la fábrica
(defun es-peso-util-p (peso)
  (and (>= peso 400) (<= peso 1000)))
;; Prueba: (es-peso-util-p 600) ; => T

;; c. Predicado: el pino (por su altura) le sirve a la fábrica
(defun sirve-pino-p (altura)
  (es-peso-util-p (peso-pino altura)))
;; Prueba: (sirve-pino-p 5) ; => T


;; --------------------------------------------------------------------
;; Actividad N° 15: Reparto del costo de las pizzas
;; --------------------------------------------------------------------

(defun costo-por-persona (precio-pizza cantidad-amigos)
  (cond ((or (<= precio-pizza 0) (<= cantidad-amigos 0)) "Error: Los valores deben ser mayores a cero.")
        (t (let* ((porciones-necesarias (* cantidad-amigos 3))
                  (pizzas-necesarias (ceiling porciones-necesarias 8))
                  (costo-total (* pizzas-necesarias precio-pizza)))
             (/ costo-total cantidad-amigos)))))
;; Prueba: (costo-por-persona 12000 3) ; => 8000
