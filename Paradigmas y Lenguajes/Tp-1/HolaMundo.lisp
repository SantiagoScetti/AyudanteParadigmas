(defun HolaMundo()
    (print "hola mundo")
)
(HolaMundo)


;; Ejercicio 1: Calcular la cantidad de dólares que podemos comprar con $ 3.300
(defparameter dinero-en-pesos 3300)
(defparameter cotizacion-dolar-banco-nacion 875.50)

(defun dolares-con-pesos (pesos cotizacion)
  (/ pesos cotizacion))

(dolares-con-pesos dinero-en-pesos cotizacion-dolar-banco-nacion)
;; Output: 3.7719424460431655


;; Ejercicio 2: Representar 250 has en m2
(defparameter hectareas 250)
(defparameter m2-por-ha 10000)

(defun m2-desde-hectareas (hectareas m2-por-ha)
  (* hectareas m2-por-ha))

(m2-desde-hectareas hectareas m2-por-ha)
;; Output: 2500000



;; Ejercicio 3: Calcular promedio y porcentaje de materias aprobadas
(defparameter notas '(7 5 10 8))
(defparameter total-materias 25)

(defun promedio (notas)
  (/ (apply #'+ notas) (length notas)))

(defun porcentaje-aprobadas (aprobadas total)
  (* (/ aprobadas total) 100))

(let ((promedio-notas (promedio notas))
      (materias-aprobadas (count 6 notas))) ; Asumiendo que 6 o más es aprobado
  (list promedio-notas (porcentaje-aprobadas materias-aprobadas total-materias)))
;; Output: (7.5 75.0)



;; Ejercicio 4: Calcular la cantidad de estantes que tiene una biblioteca
(defparameter libros-ubicados 30)
(defparameter libros-por-estante 6)

(defun estantes-en-biblioteca (libros estantes-por-libro)
  (/ libros estantes-por-libro))

(estantes-en-biblioteca libros-ubicados libros-por-estante)
;; Output: 5
