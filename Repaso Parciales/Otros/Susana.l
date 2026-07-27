;   "Predicado puro: Retorna T si hay riesgo extremo, NIL en caso contrario."

;; PUNTO 1
(defun riesgo-p (temperatura oleaje)
  (or (< temperatura 10.0)
      (> oleaje 4.5)))


Punto 2

Para el rescate de alguna boya o pequña barcaza,se usa barcos 
especiales,solo 
se puede zarpar si en las listas recibidas, como parametro se registran menos de
4 situaciones de riesgo
RESTRICCION 
Utilizar todas las funciones que sean 
necesarias para analizar las listas
utilizar proceso recursivo y retornando la lista
(ES SEGURO)o (NO ES SEGURO) 

;el ejercicio nunca dice que se reciben 4 parámetros en ninguna función, lo que sigue esta MAL ojo!!!:
(defun punto2 (L1 L2 L3 L4)
  ;(let (L1 L2))
  ;(print "ingrese la lista")
  ;(setq l1 (read))
  ;(print "ingrese la lista")
  ;(consp (L1 L2 L3 L4)
  ;  (analizar (L1 L2 L3 L4)))

(defun analizar (L1 L2 L3 L4 )
(cond
  ((endp lista)nil)
  (consp(car(car L1)(cdr L1))
    (car(car L2(cdr L2)))
    (car(car L3(cdr L3)))
    (car(car L4(cdr L4))
      (Analizar(cdr L1 L2 L3 L4))
      (T(Analizar L1 L2 L3 L4)))))))



;PUNTO 2 CORREGIDO
(defun contar-riesgos (lista-temp lista-olas)
  (cond 
    ((or (null lista-temp) (null lista-olas)) 0)
    ((riesgo-p (car lista-temp) (car lista-olas)) (+ 1 (contar-riesgos (cdr lista-temp) (cdr lista-olas))))
    (t (contar-riesgos (cdr lista-temp) (cdr lista-olas)))
  )
)

;; Función principal que compara y TOMA LA DECISIÓN
(defun evaluar-rescate (lista-temp lista-olas)
  (if (< (contar-riesgos lista-temp lista-olas) 4)
      '(ES SEGURO)
      '(NO ES SEGURO)
  )
)





;este menu estaría mal
(defun menu  
  (let (L1 L2)) ; el let no se cierra ácá
   (print "ingrese la lista")
   (setq l1 (read))
  (print "ingrese la lista")
   (consp (L1 L2 L3 L4)
    (analizar (L1 L2 L3 L4)))
 ; ) sino acá
)