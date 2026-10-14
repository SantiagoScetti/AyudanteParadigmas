(defun ingreso-datos ()
 	(let (lista)
 		(pprint "ingrese una lista")
 		(setq lista(read))
 		(if (listp lista)
 			(progn 
 				(pprint (evaluar-numerico lista)))
 			(pprint "error ingrese una lista")
 		)
 	)
 )

 (defun evaluar-numerico (lista)
 	(mapcar
 		(lambda (x)
 			(cond 
 				((numberp x) "numerico")
 				(t "no numerico")))
 	lista)
 )