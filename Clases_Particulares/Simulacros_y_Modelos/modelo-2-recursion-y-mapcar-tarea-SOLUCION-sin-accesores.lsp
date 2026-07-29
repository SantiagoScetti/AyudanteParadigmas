; MODELO 2 - RECURSION Y MAPCAR - TAREA - SOLUCION SIN ACCESORES
; Biblioteca: lista de sublistas (DIAS ESTADO PAGINAS)
;
; Version sin funciones accesoras (dias / estado / paginas / ritmo).
; Cada funcion usa directamente car/cdr combinados sobre el prestamo.
;
; Estructura de cada prestamo: (DIAS ESTADO PAGINAS)
;   DIAS     -> (car prestamo)
;   ESTADO   -> (cadr prestamo)
;   PAGINAS  -> (caddr prestamo)
;   RITMO    -> (/ (caddr prestamo) (car prestamo))
;
; Cuando el accesor se aplicaba sobre (car lista) en vez de sobre un
; prestamo ya extraido, el car/cdr se combina un nivel mas adentro:
;   (estado (car lista))  = (cadar  lista)   ; (car (cdr (car lista)))
;   (dias   (car lista))  = (caar   lista)   ; (car (car lista))
;   (paginas (car lista)) = (caddar lista)   ; (car (cdr (cdr (car lista))))
;
; NOTA PARA EL ALUMNO: el enunciado NO dice que herramienta usar.
; El criterio para decidirlo, en una frase:
;   - MAPCAR  -> cuando la salida es UNA LISTA DE LA MISMA LONGITUD que la entrada
;                y cada elemento se calcula MIRANDO SOLO SU PROPIA SUBLISTA.
;   - RECURSION -> cuando la salida es UN VALOR UNICO (numero, T/NIL, una sublista),
;                  o cuando la lista resultante CAMBIA DE LONGITUD (filtrar),
;                  o cuando hay que COMPARAR/ACUMULAR entre elementos.

; =============================================================================
; a) RECURSION -> devuelve un valor unico (T/NIL). Predicado UNIVERSAL:
;    corta con NIL apenas encuentra un contraejemplo.
;    (estado (car lista)) -> (cadar lista)
; =============================================================================
(defun todos-bien-p (lista)
    (cond
        ((null lista) T)
        ((not (equal (cadar lista) 'BIEN)) NIL)
        (T (todos-bien-p (cdr lista)))
    )
)

; =============================================================================
; b) RECURSION -> devuelve un numero, no una lista. Contar con condicion.
;    (dias (car lista)) -> (caar lista)
; =============================================================================
(defun contar-demorados (lista limite)
    (cond
        ((null lista) 0)
        ((> (caar lista) limite) (+ 1 (contar-demorados (cdr lista) limite)))
        (T (contar-demorados (cdr lista) limite))
    )
)

; =============================================================================
; c) RECURSION -> devuelve un numero. Contar todos, sin condicion.
;    No usa ningun accesor.
; =============================================================================
(defun cantidad-prestamos (lista)
    (cond
        ((null lista) 0)
        (T (+ 1 (cantidad-prestamos (cdr lista))))
    )
)

; =============================================================================
; d) MAPCAR -> misma longitud, cada elemento sale de su propia sublista.
;    Ya no se puede pasar 'paginas como funcion (no existe mas), entonces
;    se arma la lambda con (caddr prestamo).
; =============================================================================
(defun paginas-libros (lista)
    (mapcar (lambda (prestamo) (caddr prestamo)) lista)
)

; =============================================================================
; e) RECURSION -> la lista resultante es MAS CORTA que la original (filtrar).
;    MAPCAR no sirve: no puede "saltear" elementos.
;    (estado (car lista)) -> (cadar lista)
; =============================================================================
(defun danados (lista)
    (cond
        ((null lista) NIL)
        ((equal (cadar lista) 'DANADO) (cons (car lista) (danados (cdr lista))))
        (T (danados (cdr lista)))
    )
)

; =============================================================================
; f) MAPCAR con COND adentro -> misma longitud, decision individual.
;    RITMO es una funcion auxiliar (no un LET): se llama directamente en
;    cada rama del COND. Como el valor solo se usa para comparar (nunca se
;    devuelve), no hace falta guardarlo en una variable local; un LET aca
;    seria abusar de variables auxiliares dentro del MAPCAR.
; =============================================================================
(defun ritmo (prestamo)
     (/ (caddr prestamo) (car prestamo))
)

(defun categorizar-ritmo (lista)
    (mapcar (lambda (prestamo)
                (cond
                    ((<= (ritmo prestamo) 20) "lento")
                    ((<= (ritmo prestamo) 60) "normal")
                    (T "veloz")))
            lista)
)



; =============================================================================
; g) DIFICIL - RECURSION obligatoria.
;    Devuelve UNA sola sublista y hay que COMPARAR elementos entre si:
;    MAPCAR queda descartado de entrada.
;
;    Clave: guardar el resultado de la llamada recursiva en una variable local
;    (LET) para no llamar dos veces a la funcion. Y contemplar el caso en que
;    el resto devuelve NIL (no habia ningun BIEN mas adelante).
;
;    (estado (car lista))       -> (cadar lista)
;    (ritmo (car lista))        -> (/ (caddar lista) (caar lista))
;    (ritmo mejor-del-resto)    -> (/ (caddr mejor-del-resto) (car mejor-del-resto))
; =============================================================================
(defun mejor-lector (lista)
    (cond
        ((null lista) NIL)
        ((not (equal (cadar lista) 'BIEN)) (mejor-lector (cdr lista)))
        (T (let ((mejor-del-resto (mejor-lector (cdr lista))))
                (cond
                    ((null mejor-del-resto) (car lista))
                    ((> (/ (caddar lista) (caar lista))
                        (/ (caddr mejor-del-resto) (car mejor-del-resto)))
                     (car lista))
                    (T mejor-del-resto))))
    )
)

; =============================================================================
; h) DIFICIL - MAPCAR sobre DOS listas en paralelo.
;    La lambda recibe DOS parametros (uno de cada lista) y MAPCAR las recorre
;    a la par. La salida tiene la misma longitud y cada sublista se arma con
;    LIST a partir de los datos de esa posicion -> es el caso tipico de MAPCAR.
;
;    (floor a b) devuelve la division entera truncada hacia abajo.
;    (paginas prestamo) -> (caddr prestamo)
;    (dias prestamo)    -> (car prestamo)
;    (estado prestamo)  -> (cadr prestamo)
; =============================================================================
(defun informe-socios (lista socios)
    (mapcar (lambda (prestamo socio)
                (list socio
                    (floor (caddr prestamo) (car prestamo))
                    (cond
                        ((equal (cadr prestamo) 'DANADO) 'RECLAMAR)
                        ((> (car prestamo) 30) 'MOROSO)
                        (T 'OK)
                    )
                ))
            lista
            socios)
)

; =============================================================================
; i) MENU - funcion principal que integra todo
;    Pide con mensajes alusivos los datos que hacen falta, valida con CONSP /
;    NUMBERP y usa PROGN para ejecutar todos los reportes en la rama verdadera.
; =============================================================================
(defun menu ()
    (let (prestamos dias socios)
        (pprint "Ingrese la lista de prestamos ((DIAS ESTADO PAGINAS) ...):")
        (setq prestamos (read))
        (pprint "Ingrese la cantidad de dias a comparar:")
        (setq dias (read))
        (pprint "Ingrese la lista de socios, uno por cada prestamo:")
        (setq socios (read))
        (if (and (consp prestamos) (numberp dias) (consp socios))
            (progn
                (pprint (todos-bien-p prestamos))
                (pprint (contar-demorados prestamos dias))
                (pprint (cantidad-prestamos prestamos))
                (pprint (paginas-libros prestamos))
                (pprint (danados prestamos))
                (pprint (categorizar-ritmo prestamos))
                (pprint (mejor-lector prestamos))
                (pprint (informe-socios prestamos socios))
            )
            (pprint "Error: debe ingresar datos validos")
        )
    )
)

; =============================================================================
; DATOS DE PRUEBA
; (setq prestamos '((5 BIEN 300) (20 DANADO 150) (10 BIEN 900) (3 DANADO 40) (40 BIEN 1200)))
; (setq socios '(ANA BETO CARLA DIEGO EVA))
;
;   (todos-bien-p prestamos)             -> NIL          (hay dos DANADO)
;   (contar-demorados prestamos 7)       -> 3            (20, 10 y 40 dias)
;   (cantidad-prestamos prestamos)       -> 5
;   (paginas-libros prestamos)           -> (300 150 900 40 1200)
;   (danados prestamos)                  -> ((20 DANADO 150) (3 DANADO 40))
;   (categorizar-ritmo prestamos)        -> ("normal" "lento" "veloz" "lento" "normal")
;         ritmos: 300/5=60, 150/20=7.5, 900/10=90, 40/3=13.3, 1200/40=30
;   (mejor-lector prestamos)             -> (10 BIEN 900)
;         entre los BIEN: 60, 90 y 30 -> gana el de ritmo 90
;   (informe-socios prestamos socios)    -> ((ANA 60 OK)
;                                            (BETO 7 RECLAMAR)
;                                            (CARLA 90 OK)
;                                            (DIEGO 13 RECLAMAR)
;                                            (EVA 30 MOROSO))
; =============================================================================
