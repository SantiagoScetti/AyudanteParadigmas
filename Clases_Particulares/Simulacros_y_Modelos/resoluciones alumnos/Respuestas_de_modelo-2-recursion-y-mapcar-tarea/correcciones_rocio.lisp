; =============================================================================
; CORRECCIONES - ROCIO                                          NOTA:  9 / 10
; Modelo 2 - Recursividad y MAPCAR (biblioteca: (DIAS ESTADO PAGINAS))
; =============================================================================
; Puntos resueltos: 9 de 9
; Funciones que compilan: 8 de 9   (solo f) queda abierta por un parentesis)
; Funciones que dan el resultado correcto: 8 de 8  (probadas una por una)
;
;   a) OK   b) OK   c) OK   d) OK   e) OK   g) OK   h) OK
;   f) le falta un ) al final de la rama NORMAL. La logica esta perfecta.
;   i) el menu tiene 2 errores que lo cortan apenas arranca.
;
; Eligio bien la herramienta en los 9 puntos: recursion en a, b, c, e, g y
; MAPCAR en d, f, h. El punto g), que era el dificil, lo resolvio mejor que la
; solucion modelo (la auxiliar EL-MAS-RAPIDO evita el LET).
;
; No le falta entender nada: le falta correr el codigo antes de entregarlo.
; Los 3 errores reales salian con una sola corrida.
; =============================================================================


; -----------------------------------------------------------------------------
; f)  FALTA UN PARENTESIS
;
;   ESTA:  ((<= (/ (caddr prestamo) (car prestamo)) 60) 'NORMAL
;   VA:    ((<= (/ (caddr prestamo) (car prestamo)) 60) 'NORMAL)
;
; Sin ese ) la rama NORMAL nunca cierra y se traga al (t 'VELOZ). El
; interprete llega al final del archivo esperando parentesis y avisa
; "EOF in list" (CLISP) o "end of file" (SBCL), senalando la linea del DEFUN,
; no la del parentesis que falta. Ese es el reflejo a tener: si el error dice
; "fin de archivo", falta un ) en la funcion que nombra el mensaje.
; -----------------------------------------------------------------------------
(defun ritmo-lectura (lista)
    (mapcar (lambda (prestamo)
                (cond
                    ((<= (ritmo prestamo) 20) 'LENTO)
                    ((<= (ritmo prestamo) 60) 'NORMAL)
                    (t 'VELOZ)
                ))
            lista)
)


; -----------------------------------------------------------------------------
; i)  LOS 2 ERRORES DEL MENU
;
;   1. (todo-buen-estado lista-prestamo)   -> la variable del LET es
;      lista-prestamoS, con S. Asi como esta, la variable no existe y el menu
;      se cae en la primera linea del PROGN.
;
;   2. (cantidad-supero dia)   -> esa funcion se definio con DOS parametros,
;      (lista dia). Hay que llamarla con los dos: (cantidad-supero lista dia).
; -----------------------------------------------------------------------------


; =============================================================================
; DETALLES (no descuentan)
;
; 1. Mejor PRINT que FORMAT. Los FORMAT con ~A quedan bien, pero para el
;    parcial alcanza con print y es mas dificil equivocarse. Ademas los suyos
;    no tienen ~% al final, asi que sale todo pegado en una sola linea.
;
; 2. #' en el MAPCAR. Lo uso bien, pero conviene saber cuando hace falta:
;       - con LAMBDA no hace falta:  (mapcar (lambda (p) ...) lista)
;       - con el NOMBRE de una funcion si:  (mapcar #'caddr lista)
;    Escribiendo siempre la lambda, nunca necesita el #'.
;
; 3. h) usa TRUNCATE y el enunciado pedia FLOOR. Con numeros positivos dan
;    lo mismo, pero si el enunciado nombra una funcion, se usa esa.
;
; 4. i) valida con LISTP, que tambien da T con una lista vacia. Para "lista
;    con datos" va CONSP.
;
; 5. f) recalcula la division en cada rama pudiendo llamar a su propia
;    funcion RITMO, que ya la tenia hecha (asi quedo arriba, corregido).
; =============================================================================

; i) MENU CORREGIDO
(defun menu ()
    (let ((lista-prestamos) (socios) (dia))
        (print "Ingrese la lista de prestamos ((dias estado paginas)):")
        (setq lista-prestamos (read))
        (print "Ingrese la lista de socios:")
        (setq socios (read))
        (print "Ingrese la cantidad de dias maximos de prestamo:")
        (setq dia (read))

        (if (and (consp lista-prestamos) (consp socios) (numberp dia))
            (progn
                (print "Todos devueltos bien?")
                (print (todo-buen-estado lista-prestamos))
                (print "Prestamos que superaron el maximo de dias:")
                (print (cantidad-supero lista-prestamos dia))
                (print "Cantidad de prestamos registrados:")
                (print (cantidad-prestamos lista-prestamos))
                (print "Paginas de los libros prestados:")
                (print (lista-de-paginas lista-prestamos))
                (print "Prestamos devueltos danados:")
                (print (devuelto-danado lista-prestamos))
                (print "Ritmo de lectura:")
                (print (ritmo-lectura lista-prestamos))
                (print "Sublista con mayor ritmo (BIEN):")
                (print (mayor-ritmo-bien lista-prestamos))
                (print "Reporte de socios:")
                (print (reporte-socios lista-prestamos socios))
            )
            (print "Error: ingrese datos validos")
        )
    )
)

; =============================================================================
; PRUEBA  (con (setq datos '((5 BIEN 300) (20 DANADO 150) (10 BIEN 900)
;                            (3 DANADO 40) (40 BIEN 1200)))
;              (setq socios '(ANA BETO CARLA DIEGO EVA)) )
;
;   (todo-buen-estado datos)      -> NIL
;   (cantidad-supero datos 7)     -> 3
;   (cantidad-prestamos datos)    -> 5
;   (lista-de-paginas datos)      -> (300 150 900 40 1200)
;   (devuelto-danado datos)       -> ((20 DANADO 150) (3 DANADO 40))
;   (ritmo-lectura datos)         -> (NORMAL LENTO VELOZ LENTO NORMAL)
;   (mayor-ritmo-bien datos)      -> (10 BIEN 900)
;   (reporte-socios datos socios) -> ((ANA 60 OK) (BETO 7 RECLAMAR)
;                                     (CARLA 90 OK) (DIEGO 13 RECLAMAR)
;                                     (EVA 30 MOROSO))
; =============================================================================
