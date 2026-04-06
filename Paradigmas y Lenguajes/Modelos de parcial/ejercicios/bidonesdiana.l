(defun punto1(montoTotal bidon10l bidon20l bidon50l)
	(let ((cant1 0) (cant2 0) (cant3 0)(tipo_cant '()))
		(setq cant1 (truncate(/ montoTotal bidon10l)))
		(setq cant2 (truncate(/ montoTotal bidon20l)))
		(setq cant3 (truncate(/ montoTotal bidon50l)))
		(setq tipo_cant (list (list "tipo 1" cant1) (list "tipo 2" cant2) (list "tipo 3" cant3)))
		tipo_cant
		))

(defun sufreDescuento (montoTotal)
	(cond
		((and(>= montoTotal 75000)(<= montoTotal 200000))(- montoTotal 30000))
		((> montoTotal 200000)(- montoTotal 50000))
		((t montoTotal))
	))

(defun Verificar(montoTotal bidon10l bidon50l)
	(< (+ (* bidon10l 2) (* bidon50l 4)) montoTotal)	
)

(defun funcionPrincipal()
	(let((montoTotal 0) (bidon10l 15000) (bidon20l 28000) (bidon50l 70000))
		(print "Ingresar monto total: ")
		(setq montoTotal(read))
		(if(and (/= montoTotal 0)(numberp montoTotal))
			(progn
				(pprint (punto1 montoTotal bidon10l bidon20l bidon50l))
				(pprint (sufreDescuento montoTotal))
				(pprint (Verificar montoTotal bidon10l bidon50l))
			)
			(pprint "Monto ingresado no numerico, intentar nuevamente")
		)))








;punto 1
(defun operacion()
	(let((a 0)(b 0)(c 0)(verificar 0))
		(print "Ingrese valor de a: ")
		(setq a(read))
		(print "Ingrese valor de b: ")
		(setq b(read))
		(print "Ingrese valor de c: ")
		(setq c(read))

		(if(and(numberp a)(numberp b)(numberp c)(/= a 0))
			(= (/ (+ (* a b)(* a c)) a) (+ b c))
			(nil)
		)))