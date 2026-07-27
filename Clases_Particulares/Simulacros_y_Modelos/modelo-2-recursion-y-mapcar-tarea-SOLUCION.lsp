; MODELO 2 - RECURSION Y MAPCAR - TAREA - SOLUCION DE REFERENCIA
; Biblioteca: lista de sublistas (DIAS ESTADO PAGINAS)
;
; NOTA PARA EL ALUMNO: el enunciado NO dice que herramienta usar.
; El criterio para decidirlo, en una frase:
;   - MAPCAR  -> cuando la salida es UNA LISTA DE LA MISMA LONGITUD que la entrada
;                y cada elemento se calcula MIRANDO SOLO SU PROPIA SUBLISTA.
;   - RECURSION -> cuando la salida es UN VALOR UNICO (numero, T/NIL, una sublista),
;                  o cuando la lista resultante CAMBIA DE LONGITUD (filtrar),
;                  o cuando hay que COMPARAR/ACUMULAR entre elementos.

; --- Accesores (hacen el resto del codigo legible y evitan car/cadr/caddr sueltos) ---
(defun dias (prestamo) (car prestamo))
(defun estado (prestamo) (cadr prestamo))
(defun paginas (prestamo) (caddr prestamo))

; El ritmo de lectura se usa en varios puntos: conviene definirlo una sola vez
(defun ritmo (prestamo) (/ (paginas prestamo) (dias prestamo)))

; =============================================================================
; a) RECURSION -> devuelve un valor unico (T/NIL). Predicado UNIVERSAL:
;    corta con NIL apenas encuentra un contraejemplo.
; =============================================================================
(defun todos-bien-p (lista)
    (cond
        ((null lista) T)
        ((not (equal (estado (car lista)) 'BIEN)) NIL)
        (T (todos-bien-p (cdr lista)))
    )
)

; =============================================================================
; b) RECURSION -> devuelve un numero, no una lista. Contar con condicion.
; =============================================================================
(defun contar-demorados (lista limite)
    (cond
        ((null lista) 0)
        ((> (dias (car lista)) limite) (+ 1 (contar-demorados (cdr lista) limite)))
        (T (contar-demorados (cdr lista) limite))
    )
)

; =============================================================================
; c) RECURSION -> devuelve un numero. Contar todos, sin condicion.
; =============================================================================
(defun cantidad-prestamos (lista)
    (cond
        ((null lista) 0)
        (T (+ 1 (cantidad-prestamos (cdr lista))))
    )
)

; =============================================================================
; d) MAPCAR -> misma longitud, cada elemento sale de su propia sublista.
; =============================================================================
(defun paginas-libros (lista)
    (mapcar 'paginas lista)
)

; =============================================================================
; e) RECURSION -> la lista resultante es MAS CORTA que la original (filtrar).
;    MAPCAR no sirve: no puede "saltear" elementos.
; =============================================================================
(defun danados (lista)
    (cond
        ((null lista) NIL)
        ((equal (estado (car lista)) 'DANADO) (cons (car lista) (danados (cdr lista))))
        (T (danados (cdr lista)))
    )
)

; =============================================================================
; f) MAPCAR con COND adentro -> misma longitud, decision individual.
;    El LET evita calcular el ritmo tres veces (rubrica: variables locales).
; =============================================================================
(defun categorizar-ritmo (lista)
    (mapcar (lambda (prestamo)
                (let ((r (ritmo prestamo)))
                    (cond
                        ((<= r 20) "lento")
                        ((<= r 60) "normal")
                        (T "veloz"))))
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
; =============================================================================
(defun mejor-lector (lista)
    (cond
        ((null lista) NIL)
        ((not (equal (estado (car lista)) 'BIEN)) (mejor-lector (cdr lista)))
        (T (let ((mejor-del-resto (mejor-lector (cdr lista))))
                (cond
                    ((null mejor-del-resto) (car lista))
                    ((> (ritmo (car lista)) (ritmo mejor-del-resto)) (car lista))
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
; =============================================================================
(defun informe-socios (lista socios)
    (mapcar (lambda (prestamo socio)
                (list socio
                    (floor (paginas prestamo) (dias prestamo))
                    (cond
                        ((equal (estado prestamo) 'DANADO) 'RECLAMAR)
                        ((> (dias prestamo) 30) 'MOROSO)
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
