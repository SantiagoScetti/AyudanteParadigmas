; =============================================================================
; MODELO 2 - RECURSIVIDAD Y MAPCAR
; Biblioteca: lista de sublistas (DIAS ESTADO PAGINAS)
;
; RESOLUCION DE ROCIO  -  TRANSCRIPCION LITERAL DE LAS FOTOS
;
; Se transcribe TAL CUAL lo escrito en el papel: no se corrigio ningun nombre,
; ningun parentesis ni ninguna llamada. Las correcciones estan en el archivo
; correcciones_rocio.lisp
;
; Marca usada:
;   ; [?]  -> tramo que en la foto no se lee con seguridad (conviene mirar el papel)
; =============================================================================


; -----------------------------------------------------------------------------
; a)
; Nota al margen de la foto (los accesores sobre cada sublista):
;     ((diasP  estado  cantPag) (...))
;        car    cadr    caddr
;               cadr (car L)    caddr (car L)
; -----------------------------------------------------------------------------
(defun todo-buen-estado (lista)
    (cond
        ((null lista) T)
        ((equal (cadr (car lista)) 'BIEN)
            (todo-buen-estado (cdr lista)))
        (t nil)
    )
)


; -----------------------------------------------------------------------------
; b)
; -----------------------------------------------------------------------------
(defun cantidad-supero (lista dia)
    (cond
        ((null lista) 0)
        ((> (caar lista) dia) (+ 1 (cantidad-supero (cdr lista) dia)))   ; [?] en la foto el "+ 1" figura pegado: "+1"
        (t (cantidad-supero (cdr lista) dia))
    )
)


; -----------------------------------------------------------------------------
; c)
; -----------------------------------------------------------------------------
(defun cantidad-prestamos (lista)
    (cond
        ((null lista) 0)
        (t (+ 1 (cantidad-prestamos (cdr lista))))                       ; [?] idem: en la foto "+1"
    )
)


; -----------------------------------------------------------------------------
; d)
; -----------------------------------------------------------------------------
(defun lista-de-paginas (lista)
    (mapcar #'caddr lista)
)


; -----------------------------------------------------------------------------
; e)
; -----------------------------------------------------------------------------
(defun devuelto-danado (lista)                                           
    (cond
        ((null lista) nil)
        ((equal (cadr (car lista)) 'DANADO)                              
            (cons (car lista) (devuelto-danado
                (cdr lista))))
        (t (devuelto-danado (cdr lista)))
    )
)


; -----------------------------------------------------------------------------
; f)
; -----------------------------------------------------------------------------
(defun ritmo-lectura (lista)
    (mapcar #'(lambda (prestamo)
                (cond
                    ((<= (/ (caddr prestamo)
                            (car prestamo)) 20) 'LENTO)
                    ((<= (/ (caddr prestamo)
                            (car prestamo)) 60) 'NORMAL  ;falta un parentesis de cierre no se ve en la foto
                    (t 'VELOZ)
                ))
            lista ))


; -----------------------------------------------------------------------------
; g)
; -----------------------------------------------------------------------------
(defun ritmo (prestamo)
    (/ (caddr prestamo) (car prestamo))
)

(defun el-mas-rapido (prestamo1 prestamo2)
    (cond
        ((null prestamo1) prestamo2)
        ((null prestamo2) prestamo1)
        ((> (ritmo prestamo1) (ritmo prestamo2))
            prestamo1)
        (t prestamo2)
    )
)

(defun mayor-ritmo-bien (lista)
    (cond
        ((null lista) nil)
        ((equal (cadr (car lista)) 'BIEN)
            (el-mas-rapido (car lista)
                (mayor-ritmo-bien (cdr lista))))
        (t (mayor-ritmo-bien (cdr lista)))
    )
)


; -----------------------------------------------------------------------------
; h)   "Uso la funcion ritmo del punto anterior"  (escrito al margen)
; -----------------------------------------------------------------------------
(defun reporte-individual (prestamo socio)
    (list socio
        (truncate (ritmo prestamo))
        (cond
            ((equal (cadr prestamo) 'DANADO) 'Reclamar)
            ((> (car prestamo) 30) 'MOROSO)
            (t 'OK)
        )
    )
)

(defun reporte-socios (lista-prestamos L-socios)
    (mapcar #'reporte-individual lista-prestamos
        L-socios)
)


; -----------------------------------------------------------------------------
; i)
; -----------------------------------------------------------------------------
(defun menu ()
    (let ((lista-prestamos) (socios) (dia))                              ; [?] en la foto parecen 3 parentesis abiertos
        (format t "Ingrese la lista de prestamos ((dias estado paginas)):")

        (setq lista-prestamos (read))
        (format t "Ingrese lista de socios:")
        (setq socios (read))
        (format t "Ingrese la cantidad de dias maximos de prestamo:")
        (setq dia (read))

        (if (and (listp lista-prestamos) (listp socios)
                 (numberp dia))
            (progn
                (format t "todos devueltos bien? ~A"
                    (todo-buen-estado lista-prestamo))
                (format t "Cantidad de prestamos que superaron el maximo de dias: ~A"
                    (cantidad-supero dia))
                (format t "Cantidad de prestamos registrados: ~A"
                    (cantidad-prestamos lista-prestamos))
                (format t "Paginas de los libros prestados: ~A"
                    (lista-de-paginas lista-prestamos))
                (format t "Prestamos devueltos danados: ~A"
                    (devuelto-danado lista-prestamos))
                (format t "Ritmo de lectura: ~A"
                    (ritmo-lectura lista-prestamos))
                (format t "Sublista con mayor ritmo (BIEN) ~A"
                    (mayor-ritmo-bien lista-prestamos))
                (format t "Reporte de socios: ~A"
                    (reporte-socios lista-prestamos socios))
            )
            (format t "Error: ingrese datos validos")
        )
    )
)
