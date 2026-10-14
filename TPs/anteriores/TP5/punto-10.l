Ejercicio Nº 10:  
 
Definir  la  función  ambos-enteros    que  solicite  al  operador  el  ingreso  de  dos  Listas  no  vacías: 
LISTA1  y  LISTA2.  La  función  deberá  devolver  una  nueva  Lista  con  el  resultado  de  evaluar 
elemento a elemento ambas Listas, indicando en forma de sublista ambos elementos, si coinciden 
en que sean números enteros.

(defun ambos-enteros ()
  (let ((lista1 nil) (lista2 nil))
    (format t "Ingrese LISTA1: ")
      (setq lista1 (read))
    (format t "Ingrese LISTA2: ")
      (setq lista2 (read))
     (if (and (listp lista1) (listp lista2) (not (null lista1)) (not (null lista2)))
          (mapcar (lambda (x y)
                    (if (and (integerp x) (integerp y))
                        (list x y)))
                  lista1 lista2)
          (print "Error: ambas entradas deben ser listas no vacías"))))

;; Ejemplo de uso
(ambos-enteros)
