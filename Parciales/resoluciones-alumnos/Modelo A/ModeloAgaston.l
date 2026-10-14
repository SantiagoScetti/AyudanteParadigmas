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

(pico-pm25 '(39 25 59 45 51 27 63 34 32))

(max '(5 4 8 9 6 3 5 v))


(defun ingrese-listas()
	(let(lpm25)
	(print "ingrese lista de pm25")
	(setq lpm25(read))
	(let(lco)
	(print "ingrese lista lco")
	(setq lco(read))

		(if(and(consp lpm25)(consp lco)(=(length lpm25)(length lco)))
			(progn
					(pprint(critico(car lpm25)(car lco)))
					(pprint(indicadores lpm25 lco))
					(pprint(protocoloemer lpm25 lco))
					(pprint(co-peligrosa lco))
					(pprint(pico-pm25 lpm25))
					)
			(progn
					(pprint "error")
					(ingrese-listas)))



			)))

            (defun controlarNros (lista))