; =============================================================================
; PRÁCTICA EXTRAORDINARIO - MODELO C - SOLUCIÓN DE REFERENCIA
; PARADIGMAS Y LENGUAJES DE PROGRAMACIÓN - LENGUAJE LISP
; Tema: UNA SOLA LISTA + UN PARÁMETRO
; (predicado universal, partición, filtros, conteo, mapcar por tramos)
; =============================================================================
;
; Estructura del dato: una lista plana de números (duraciones en segundos)
; y un número suelto (umbral). Puede venir heterogénea -> validar numberp.
;
;   playlist -> (200 45 90 30 180 240 90)
;   umbral   -> 60
;
; Resultados esperados con esos datos:
;   todas-superan-p      -> NIL        (45 no supera 60)
;   separar-por-duracion -> ((200 90 180 240 90) (0.75 0.5))
;   cantidad-cortas      -> 2          (45 y 30 son <= 60)
;   marcar-largas        -> (SI NO SI NO SI SI SI)
;   clasificar-duracion  -> ((200 LARGA) (45 CORTA) (90 MEDIA) (30 CORTA)
;                            (180 MEDIA) (240 LARGA) (90 MEDIA))
;   sin-repetidas        -> (200 45 30 180 240 90)
;   en-orden-p           -> NIL
;
; DOS PATRONES NUEVOS RESPECTO DE LOS MODELOS A y B:
;   * Predicado UNIVERSAL ("¿TODOS cumplen?"): recorre mientras se cumple y
;     corta con NIL apenas encuentra uno que no. Caso base -> T. Es el opuesto
;     del "¿existe al menos uno?" (que corta con T y su base es NIL).
;   * PARTICIÓN: se arma con DOS filtros (uno por grupo) y se combinan con list.
; =============================================================================


; =============================================================================
; PUNTO 1 - todas-superan-p   (PREDICADO UNIVERSAL con parámetro)
; =============================================================================
; Recorre mientras cada canción supera el umbral. Apenas una NO lo supera,
; devuelve NIL. Si llega al final (lista vacía) -> todas cumplieron -> T.

(defun todas-superan-p (lista umbral)
    (cond
        ((null lista) T)
        ((not (numberp (car lista))) NIL)          ; dato inválido: no se garantiza
        ((> (car lista) umbral) (todas-superan-p (cdr lista) umbral))
        (T NIL)                                     ; encontró una que no supera
    )
)
; Pruebas:
; (todas-superan-p '(70 80 90) 60)   -> T
; (todas-superan-p '(70 50 90) 60)   -> NIL
; (todas-superan-p '() 60)           -> T   (vacía: cumple por vacuidad)


; =============================================================================
; PUNTO 2 - separar-por-duracion   (PARTICIÓN en dos sublistas)
; =============================================================================
; Se arma con dos filtros independientes y se combinan con (list ... ...).
; Cada filtro es una recursión que hace cons del que cumple y descarta el resto.

; Filtro 1: las largas ( > 60 ), tal cual están
(defun solo-largas (lista)
    (cond
        ((null lista) nil)
        ((not (numberp (car lista))) (solo-largas (cdr lista)))
        ((> (car lista) 60) (cons (car lista) (solo-largas (cdr lista))))
        (T (solo-largas (cdr lista)))
    )
)

; Filtro 2: las cortas ( <= 60 ), pero convertidas a minutos ( / 60 )
(defun solo-cortas-en-minutos (lista)
    (cond
        ((null lista) nil)
        ((not (numberp (car lista))) (solo-cortas-en-minutos (cdr lista)))
        ((<= (car lista) 60) (cons (/ (car lista) 60.0) (solo-cortas-en-minutos (cdr lista))))
        (T (solo-cortas-en-minutos (cdr lista)))
    )
)

(defun separar-por-duracion (lista)
    (list (solo-largas lista) (solo-cortas-en-minutos lista))
)
; Prueba:
; (separar-por-duracion '(200 45 90 30 180 240 90))
;   -> ((200 90 180 240 90) (0.75 0.5))


; =============================================================================
; PUNTO 3 - cantidad-cortas   (CONTAR <= parámetro)
; =============================================================================

(defun cantidad-cortas (lista umbral)
    (cond
        ((null lista) 0)
        ((not (numberp (car lista))) (cantidad-cortas (cdr lista) umbral))
        ((<= (car lista) umbral) (+ 1 (cantidad-cortas (cdr lista) umbral)))
        (T (cantidad-cortas (cdr lista) umbral))
    )
)
; Prueba: (cantidad-cortas '(200 45 90 30 180 240 90) 60)  -> 2


; =============================================================================
; PUNTO 4 - marcar-largas   (MAPCAR -> SI / NO por cada elemento)
; =============================================================================
; El lambda toma cada duración y decide SI/NO. 'umbral' se "ve" dentro del
; lambda porque es parámetro de la función (cierre léxico). Devuelve símbolos.

(defun marcar-largas (lista umbral)
    (mapcar (lambda (dur)
                (cond
                    ((not (numberp dur)) 'NO)
                    ((> dur umbral) 'SI)
                    (T 'NO)))
            lista)
)
; Prueba: (marcar-largas '(200 45 90 30 180 240 90) 60)
;   -> (SI NO SI NO SI SI SI)


; =============================================================================
; PUNTO 5 - clasificar-duracion   (MAPCAR -> sublistas por TRAMOS)
; =============================================================================
; Por cada duración arma (duracion ETIQUETA). El COND ordena los tramos:
; primero <=60, después <=180 (atrapa 61..180), y el resto es LARGA.

(defun clasificar-duracion (lista)
    (mapcar (lambda (dur)
                (cond
                    ((not (numberp dur)) (list dur 'INVALIDA))
                    ((<= dur 60) (list dur 'CORTA))
                    ((<= dur 180) (list dur 'MEDIA))
                    (T (list dur 'LARGA))))
            lista)
)
; Prueba: (clasificar-duracion '(200 45 90 30 180 240 90))
;   -> ((200 LARGA) (45 CORTA) (90 MEDIA) (30 CORTA) (180 MEDIA) (240 LARGA) (90 MEDIA))


; =============================================================================
; PUNTO 6 - principal   (FUNCIÓN PRINCIPAL: leer + validar + integrar)
; =============================================================================
; let solo acá. Valida que 'lista' sea lista Y 'umbral' sea número.
; Un solo IF; en la rama válida PROGN encadena las impresiones.

(defun principal ()
    (let (lista umbral)
        (pprint "Ingrese la lista de duraciones (en segundos):")
        (setq lista (read))
        (pprint "Ingrese el umbral (en segundos):")
        (setq umbral (read))
        (if (and (listp lista) (numberp umbral))
            (progn
                (pprint (todas-superan-p lista umbral))
                (pprint (separar-por-duracion lista))
                (pprint (cantidad-cortas lista umbral))
                (pprint (marcar-largas lista umbral))
                (pprint (clasificar-duracion lista)))
            (pprint "Error: ingrese una lista y un numero")
        )
    )
)


; =============================================================================
; PUNTO 7 - DESAFÍO
; =============================================================================

; --- 7a) sin-repetidas: quita duraciones repetidas ---
; Si el primero ya aparece en el RESTO, se descarta (queda la última aparición).
(defun sin-repetidas (lista)
    (cond
        ((null lista) nil)
        ((member (car lista) (cdr lista)) (sin-repetidas (cdr lista)))
        (T (cons (car lista) (sin-repetidas (cdr lista))))
    )
)
; Prueba: (sin-repetidas '(200 45 90 30 180 240 90))  -> (200 45 30 180 240 90)


; --- 7b) en-orden-p: ¿está ordenada de menor a mayor? ---
; Compara cada elemento con el SIGUIENTE (car vs cadr). Si alguno es mayor que
; el siguiente -> NIL. Base: lista vacía o de un solo elemento -> T.
(defun en-orden-p (lista)
    (cond
        ((null lista) T)
        ((null (cdr lista)) T)
        ((> (car lista) (cadr lista)) NIL)
        (T (en-orden-p (cdr lista)))
    )
)
; Pruebas:
; (en-orden-p '(10 20 20 35))  -> T
; (en-orden-p '(10 40 20))     -> NIL


; --- 7c) dividir-positivos: lista heterogénea + átomo -> sublistas (elem elem/atomo) ---
; Solo procesa los que son NÚMEROS y MAYORES a cero; el resto los descarta.
; (Se asume que 'atomo' es un número distinto de cero.)
(defun dividir-positivos (lista atomo)
    (cond
        ((null lista) nil)
        ((not (numberp (car lista))) (dividir-positivos (cdr lista) atomo))
        ((> (car lista) 0) (cons (list (car lista) (/ (car lista) atomo))
                                 (dividir-positivos (cdr lista) atomo)))
        (T (dividir-positivos (cdr lista) atomo))
    )
)
; Prueba: (dividir-positivos '(16 (2 3) -2 40 S (D F)) 2)  -> ((16 8) (40 20))
