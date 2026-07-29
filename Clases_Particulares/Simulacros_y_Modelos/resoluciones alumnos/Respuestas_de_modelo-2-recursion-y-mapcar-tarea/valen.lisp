
1.
(defun buen_estado_p (lista_prestamos)
    (cond
        ((and(atom (caadr lista_prestamos))'BIEN)
        (buen_estado (cdr lista_prestamos)))
    (t(buen_estado (cdr lista_prestamos))))
)
;(comentario de profe santi: no es una funcion predicado no cumple con la consigna 0 pts)

2.
(defun cant_prestamos (lista_prestamos cd); el nombre de la funcion no hace alusion a lo que responde, sería mejor por ejemplo: contar-demorados
  (cond 
        ((endp lista_prestamos) 0)
        ((and (consp lista_prestamos) (numberp cd)))   ; se controla algo pero no hace nada mal aplicado la estructura de cond
        ((> (caar lista_prestamos)cd) (+ 1 (cant_prestamos (cdr lista_prestamos)cd)))
        (t (cant_prestamos (cdr lista_prestamos)cd))
    )
)

3.
(defun total_prestamos (lista_prestamos)
  (cond 
    ((endp lista_prestamos)0)               
    ((not (consp lista_prestamos) 'Error')) ; debería seguir llamando sin sumar nomas no poner error porque ya no va a arrojar un numero, si la lista no tiene ningun prestamo valido que la recursion siga hasta devolver 0)
    (t (+ 1 (total_prestamos(cdr lista_prestamos))))
  )
)

4.
(defun cant_paginas (lista_prestamos)
  (cond 
    ((endp lista_prestamos)0)               
    ((numberp (caddr(car lista_prestamos))) nil) 
    ((cons (caddr (car lista_prestamos))(cant_paginas(cdr lista)))); no se puede usar cons para evaluar V o F
    (t (cant_paginas(cdr lista_prestamos)))
  )
);la idea era que en este punto se devuelva una lista no un numero, leer bien la consigna

5.
(defun prestamos_danados (lista_prestamos)
    (if (consp lista_prestamos)
        (mapcar (lambda (x)
                  (cond 
                    ((and (consp x)(= (cadr x)'DANADO)) x)
                    (t nil)
                   )
                )lista_prestamos)
       "ERROR"
    )
); bien

6.
(defun calcular_ritmo (lista_prestamos)
   (/(caddr lista_prestamos)(car lista_prestamos))
);bien

(defun rl_prestamos (lista_prestamos)
        (mapcar (lambda (x)
                  (cond 
                    ((not (consp x)) nil)
                    ((<= (calcular_ritmo x) 20) "lento")
                    ((and(> (calcular_ritmo x ) 20)(<= (calcular_ritmo)60)"normal"))
                    (t "veloz")
                   )
                )lista_prestamos
    )       "ERROR"
); bien

 7.
(defun buena_lectura (lista_prestamos)
  (cond 
    ((endp lista_prestamos) nil)               
    ((not(consp lista_prestamos) "Error")) 
    ((equal (cadr (car lista_prestamos))'BIEN)(buscar_mayor(car lista)(buena_lectura(cdr lista))))
    (t(buena_lectura(cdr lista)))
  )
)

(defun buscar_mayor (calcular_ritmo); no uses el nombre de tu funcion aux como nombre del parametro
  (cond 
    ((endp (cdr calcular_ritmo))(car calcular_ritmo))               
    ((>(car calcular_ritmo) (cadr calcular_ritmo)(buscar_mayor(cdr calcular_ritmo))))
    (t(buscar_mayor(cdr calcular_ritmo)))
  )
)
; LA IDEA ESTABA: comparaste el actual contra el mejor del resto, eso esta bien. Lo que faltaba era que la auxiliar reciba
;          DOS PRESTAMOS (no una lista) y contemple que el resto puede venir
;          NIL (cuando no habia ningun BIEN mas adelante). (correccion el el prox archivo)


8.
(defun L2(lista_prestamos)
    (list 'SOCIO
        (truncate (calcular_ritmo)) 
        (cond 
            ((and (atom(caadr lista_prestamos))(equal (caddr lista_prestamos) 'DANADO))'RECLAMAR)
            ((and (equal (caadr lista_prestamos)'BIEN)(>(car lista_prestamos)30))'MOROSO) 
            (t 'OK)
            )
        )
    )

(defun lista_socios(lista_prestamos L2) ; no uses el nombre de tu funcion aux como nombre del parametro
    (if((and (consp lista_prestamos) (lista_prestamos)))
      (mapcar(lambda (x y) 
                 (if (equal (length x y))
                     (list (y))) 

             )lista_prestamos L2
        ) "Error"
    )
); nop mira la respuesta en el otro archivo

9.
(defun menu ()
  (let (lista_prestamos lista_socios cd)
    
    (pprint "Ingrese la lista de los prestamos de libros: ")
    (setq lista_prestamos (read))

    (pprint "Ingrese la lista de socios con prestamos de libros: ")
    (setq lista_socios (read))
    
    (pprint "Ingrese el limite de dias para devolver un libro: ")
    (setq cd (read))

    (if (and (consp lista_prestamos)(consp lista_socios)(numberp cd))
       (progn
         (pprint "--- REGISTRO DE LOS PRESTAMOS DE LIBROS ---")
         
         (print "1. Libros en buen estado:")
         (pprint (buen_estado_p lista_prestamos))
         
         (print "2. Cantidad de prestamos que supero el limite de dias prestados:")
         (pprint (cant_prestamos lista_prestamos cd)) 
         
         (print "3. Total prestados registrados:")
         (pprint (total_prestamos lista_prestamos))

         (print "4. Cantidad de paginas de cada libro:")
         (pprint (cant_paginas lista_prestamos))

         (print "6. Cantidad de prestamos dañados:")
         (pprint (prestamos_danados lista_prestamos))

         (print "7. Ritmo de lectura de cada prestamo:")
         (pprint (rl_prestamos calcular_ritmo lista_prestamos)); no podes pasar nombres de otras funciones como argumento al llamado y esperar a que hagan algo, fijate que no estan declaradas en el let del menu ni rl_prestamos ni calcular_ritmo

         (print "8. Lista de informacion de cada socio:")
         (pprint (lista_socios L2 lista_prestamos))

        )
    "Error: nohay ningun prestamo registrado"); falto el print
  )
)
