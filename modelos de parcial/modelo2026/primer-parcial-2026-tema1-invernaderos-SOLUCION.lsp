
(idsensor (tempMin tempMax) actualTemp actualAlim radio)

(defun volumen (lista)
	(* pi (expt (car (last lista)) 2) (cadddr lista))
)

(defun predicado (lista)
	(if (and (< (caadr lista)
		        (caddr lista))
	         (> (nth 2 lista)
	     	    (cadadr lista))) 'T 'NIL)
)

(defun estadoDescriptivo (lista)
	(cond 
		((predicado lista) (list (car lista) 'optimo))
		((> (caadr lista) (caddr lista)) (list (car lista) 'bajo))
		((< (cadadr lista) (caddr lista)) (list (car lista) 'alto))
		
	)
)

PUNTO 4:

(defun listaEstados(lista)
	(mapcar estadoDescriptivo lista) ; devuelve lista de sublistas
)
 ;o de esta otra forma
 (mapcar (lambda (x))
 	     (estadoDescriptivo x)
   lista)


(defun totalAlim (lista)
	(cond
		((null lista) 0)
		((consp(car lista)) (+ (volumen(car lista)) (totalAlim(cdr lista)))) 
		(T (totalAlim(cdr lista)))
	)
)

(defun rango (lista)
	(cond 
		((null lista) nil)
		((not (predicado(car lista))) T)
		(T (rango(cdr lista)))
	)
)