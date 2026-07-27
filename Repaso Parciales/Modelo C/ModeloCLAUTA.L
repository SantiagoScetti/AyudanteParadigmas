;modelo a
(defun critico(apm25 aco)
	(or(> apm25 50)
		(> aco 9)))

(defun indicadores(lpm25 lco)
	(mapcar(lambda(x y)
		(if(critico x y)'1
			'0)
		)lpm25 lco))

(defun contar-criticos(lpm25 lco)
	(cond((or(endp lpm25) (endp lco))0)
		((critico (car lpm25)(car lco))(+ 1(contar-criticos(cdr lpm25)(cdr lco))))
		(t(contar-criticos(cdr lpm25)(cdr lco)))
		))
(defun protocoloemer (lpm25 lco)
	(if(>=(contar-criticos lpm25 lco)4)
		'(activar protocolo)
		'(monitoreo normal)))

(defun co-peligrosa (lco)
	(cond((endp lco)nil)
		((>= (car lco)9)t)
		(t(co-peligrosa(cdr lco)))
		))

(defun pico-pm25 (lpm25)
  (cond ((endp lpm25) 0)
        ((endp (cdr lpm25)) (car lpm25))
        (t (max (car lpm25) (pico-pm25 (cdr lpm25))))))

(defun ingrese-listas()
	(let(lpm25)
		(print "ingrese lista de pm25")
		(setq lpm25(read))
		(let(lco)
			(print "ingrese lista lco")
			(setq lco(read))
			(if(and(consp lpm25)(consp lco)(=(length lpm25)(length lco)))
				(progn
					(print(critico(car lpm25)(car lco)))
					(print(indicadores lpm25 lco))
					(print(protocoloemer lpm25 lco))
					(print(co-peligrosa lco))
					(print(pico-pm25 lpm25))
					)
				(progn
					(print "error")
					(ingrese-listas)))



			)))


;EXTRAORDINARIO B
;(ID_ESTACION  DEMANDA  (TENSION_MIN  TENSION_ACTUAL  TENSION_MAX)  TARIFA) 
;Punto 1

(defun costo (lista)
	(* (second lista) (first (last lista)))
)

;Punto 2
(defun estado-optimo (lista)
	(and (> (second (second lista)) (second (first lista)))
		 (< (second (second lista)) (second (third lista)))
	)
)
;Punto 3

(defun evaluar-estacion (lista)
	(cond 
		((< (second (second lista)) (second (first lista)))
			(list (car lista)'Baja))
		((> (second (second lista)) (second (third lista)))
			(list (car lista)'Alta))
		((and (> (second (second lista)) (second (first lista)))
			  (< (second (second lista)) (second (third lista))))
			(list (car lista)'Estable))
	)
)
;Punto 4A

(defun evaluar-estaciones (lista)
	(mapcar #'(lambda (x)
		
		(evaluar-estacion x))
	lista)
)

;Punto 4b
(defun demanda-total (lista)

	(cond 

		((null lista)0)

	(t  (+ (costo (car lista)) (demanda-total (cdr lista)))
	
	)))