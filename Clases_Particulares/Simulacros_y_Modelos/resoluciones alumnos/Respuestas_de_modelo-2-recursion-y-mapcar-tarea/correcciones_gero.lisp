; =============================================================================
; CORRECCIONES - GERO                                           NOTA:  3 / 10
; Modelo 2 - Recursividad y MAPCAR (biblioteca: (DIAS ESTADO PAGINAS))
; =============================================================================
; Puntos resueltos: 8 de 9 (falta el menu)
; Funciones que compilan: 7 de 8 puntos (h) no compila)
; Funciones que dan el resultado correcto: 0
;
;   a) compila pero al correr da error (le pide el cadr a un numero)
;   b) devuelve 0 siempre
;   c) devuelve 0 siempre
;   d) bucle infinito
;   e) error al correr (Dañado sin comilla)
;   f) error al correr (usa Ritmo como variable)
;   g) error al correr (Atomp no existe)
;   h) NO COMPILA: "illegal function call"
;   i) no lo hizo
;
; -----------------------------------------------------------------------------
; LOS 2 ERRORES DE FONDO (se repiten en casi todos los puntos)
;
; 1. LOS ACCESORES. Trabaja como si (car L) fuera un dato suelto, y en
;    realidad es la SUBLISTA entera. Sobre L = ((5 BIEN 300) (20 DANADO 150)...)
;         (car L)    -> (5 BIEN 300)   la sublista
;         (caar L)   -> 5              DIAS
;         (cadar L)  -> BIEN           ESTADO
;         (caddar L) -> 300            PAGINAS
;    Ojo: CADAR ya incluye el CAR. (cadar (car L)) es un nivel de mas.
;
; 2. LAS CONDICIONES NO PREGUNTAN NADA. Escribe el dato solo, sin comparar:
;    ((car (last L)) nil), ((consp x) T), ((Ritmo x) ...). Una rama de COND es
;    (PREGUNTA RESULTADO), y la pregunta tiene que ser una comparacion:
;    EQUAL, >, <=, NULL.
;
; Para elegir la herramienta:
;    MAPCAR    -> la salida tiene la misma cantidad de elementos que la
;                 entrada y cada uno sale de su propia sublista.  (d, e, f, h)
;    RECURSION -> la salida es UN valor, o hay que comparar elementos
;                 entre si.                                       (a, b, c, g)
; =============================================================================


; -----------------------------------------------------------------------------
; a)  ((not (cadar (car L))) Nil)
;   - (cadar (car L)) tiene un CAR de mas: termina pidiendo (cdr 5) -> error.
;   - NOT no compara con BIEN: (not X) solo da T si X es NIL. Falta el EQUAL.
;   El esqueleto (caso base T, una rama que corta con NIL, otra que sigue con
;   el cdr) esta bien: es el molde correcto.
; -----------------------------------------------------------------------------
(defun Pa (L)
    (cond
        ((null L) T)
        ((not (equal (cadar L) 'BIEN)) NIL)
        (T (Pa (cdr L)))
    )
)


; -----------------------------------------------------------------------------
; b)  ((not (numberp (car L))) (Pb (cdr L) D))  ((> (car L) D) ...)
;   - (car L) es la sublista, no los dias. Como nunca es un numero, la rama
;     del NUMBERP se cumple siempre y la funcion recorre todo sin contar:
;     DEVUELVE 0 SIEMPRE. Los dias son (caar L).
;   - Esa rama de validacion no va: sobra.
; -----------------------------------------------------------------------------
(defun Pb (L D)
    (cond
        ((null L) 0)
        ((> (caar L) D) (+ 1 (Pb (cdr L) D)))
        (T (Pb (cdr L) D))
    )
)


; -----------------------------------------------------------------------------
; c)  ((listp L) 0)   ((car (cadr (cadr L))) + 1)
;   - (listp L) da T con CUALQUIER lista, tambien con una llena -> entra
;     siempre por ahi y devuelve 0. El caso base es (null L).
;   - "+ 1" suelto no suma nada. La suma se escribe (+ 1 algo).
;   - Falta la llamada recursiva: contar es 1 + lo que cuente el resto.
; -----------------------------------------------------------------------------
(defun Pc (L)
    (cond
        ((null L) 0)
        (T (+ 1 (Pc (cdr L))))
    )
)


; -----------------------------------------------------------------------------
; d)  ((numberp (last L)) nil)  ((car (last L)) nil)  (T (Pd (cdr L)))
;   - Ninguna rama arma la lista de salida: todas devuelven NIL o siguen.
;   - LAST devuelve la ULTIMA sublista, no el 3er elemento de cada una.
;   - BUCLE INFINITO: cuando L llega a NIL ninguna rama corta, y (cdr NIL) es
;     NIL otra vez, asi que se llama a si misma para siempre.
;   Este es el caso mas puro de MAPCAR: se resuelve en una linea.
; -----------------------------------------------------------------------------
(defun Pd (L)
    (mapcar (lambda (p) (caddr p)) L)
)


; -----------------------------------------------------------------------------
; e)  El MAPCAR esta bien elegido (devolver NIL donde no corresponde es una
;     forma valida de resolverlo). Los errores son otros:
;   - Dañado sin comilla: LISP lo lee como variable -> "variable no definida".
;     Los atomos van con comilla: 'DANADO.
;   - "=" solo compara NUMEROS. Para simbolos va EQUAL.
;   - ((consp x) T) como primera rama: toda sublista es consp, asi que se
;     cumple siempre y devolveria (T T T T T).
;   - (cadr L) mira la LISTA ENTERA. Adentro de la lambda hay que mirar x,
;     que es el prestamo que esta procesando: (cadr x).
;   - Adentro de la lambda vuelve a llamar a (Pe (cdr L)): o MAPCAR o
;     recursion, las dos juntas no.
; -----------------------------------------------------------------------------
(defun Pe (L)
    (mapcar (lambda (x)
                (cond
                    ((equal (cadr x) 'DANADO) x)
                    (T nil)
                ))
            L)
)

; Si en vez de dejar los NIL quiere la lista solo con los DANADO, va recursion:
; (defun Pe (L)
;     (cond
;         ((null L) NIL)
;         ((equal (cadar L) 'DANADO) (cons (car L) (Pe (cdr L))))
;         (T (Pe (cdr L)))))


; -----------------------------------------------------------------------------
; f)  Ritmo: ((consp L) nil) ...
;   - La primera rama se cumple siempre (un prestamo es una lista) -> Ritmo
;     devuelve NIL siempre. Y no necesita COND ni recursion: es UNA cuenta.
;
;     Pf: ((and (<= Ritmo x 20) "lento") (and (> Ritmo 20) (<= Ritmo 60)))
;   - RITMO es una FUNCION: para usarla hay que llamarla, (Ritmo x).
;   - (<= Ritmo x 20) compara TRES cosas. Va (<= (Ritmo x) 20).
;   - En esa rama la condicion y el resultado estan al reves, asi que "normal"
;     no se devuelve nunca. Siempre es (CONDICION RESULTADO).
;   - No hace falta repetir (> ... 20): si la primera rama no se cumplio, el
;     COND ya sabe que el ritmo es mayor a 20.
; -----------------------------------------------------------------------------
(defun Ritmo (P)
    (/ (caddr P) (car P))
)

(defun Pf (L)
    (mapcar (lambda (x)
                (cond
                    ((<= (Ritmo x) 20) "lento")
                    ((<= (Ritmo x) 60) "normal")
                    (T "veloz")
                ))
            L)
)


; -----------------------------------------------------------------------------
; g)  Aca si MAPCAR no sirve: hay que devolver UNA sublista y comparar los
;     prestamos ENTRE SI. MAPCAR devuelve una lista y mira cada elemento
;     aislado. Va recursion.
;   - Atomp no existe: el predicado es ATOM.
;   - Bien sin comilla -> variable no definida. Ademas le puso a la funcion el
;     mismo nombre que al atomo que quiere comparar.
;   - "=" con simbolos -> EQUAL.
;   - (+ (Bien (cdr L))) no es una rama de COND: le falta la condicion.
;
;   Como se piensa: "el mejor de la lista" = comparar el primero contra "el
;   mejor de lo que queda". La auxiliar compara DOS prestamos y contempla que
;   el resto pueda venir NIL.
; -----------------------------------------------------------------------------
(defun El-Mejor (P1 P2)
    (cond
        ((null P1) P2)
        ((null P2) P1)
        ((> (Ritmo P1) (Ritmo P2)) P1)
        (T P2)
    )
)

(defun Pg (L)
    (cond
        ((null L) NIL)
        ((equal (cadar L) 'BIEN) (El-Mejor (car L) (Pg (cdr L))))
        (T (Pg (cdr L)))
    )
)


; -----------------------------------------------------------------------------
; h)  ES EL UNICO PUNTO QUE NO COMPILA. El cuerpo de la lambda quedo asi:
;         (lambda (x y) ((consp x y) nil) ((list x (Floor y) observacion)))
;     Esas dos listas sueltas no son ramas de nada: LISP intenta ejecutarlas
;     como llamadas a funcion y aborta con "illegal function call". Les falta
;     el COND que las envuelva. Sin COND, no son ramas.
;   - (Floor y) esta aplicado al SOCIO. Va sobre el ritmo: (floor (Ritmo x)).
;   - "observacion" sin parentesis no llama a la funcion.
;   - En observacion: BIEN, MOROSO y OK no son variables, son atomos que se
;     devuelven con comilla. El LET no hace falta.
;   BIEN ELEGIDO el MAPCAR con dos listas: ese era el concepto nuevo del punto.
; -----------------------------------------------------------------------------
(defun Observacion (P)
    (cond
        ((equal (cadr P) 'DANADO) 'RECLAMAR)
        ((> (car P) 30) 'MOROSO)
        (T 'OK)
    )
)

(defun Ph (LP LS)
    (mapcar (lambda (x y)
                (list y (floor (Ritmo x)) (Observacion x)))
            LP LS)
)


; -----------------------------------------------------------------------------
; i)  NO LO HIZO. Es el punto mas mecanico y siempre vale nota. El molde es
;     siempre el mismo: LET vacio -> mensaje + READ -> validar -> IF con PROGN.
; -----------------------------------------------------------------------------
(defun menu ()
    (let (L D LS)
        (print "Ingrese la lista de prestamos ((DIAS ESTADO PAGINAS) ...):")
        (setq L (read))
        (print "Ingrese la cantidad de dias a comparar:")
        (setq D (read))
        (print "Ingrese la lista de socios, uno por cada prestamo:")
        (setq LS (read))
        (if (and (consp L) (numberp D) (consp LS))
            (progn
                (print "a) Todos devueltos BIEN:")   (print (Pa L))
                (print "b) Superaron los dias:")     (print (Pb L D))
                (print "c) Cantidad de prestamos:")  (print (Pc L))
                (print "d) Paginas de cada libro:")  (print (Pd L))
                (print "e) Devueltos DANADO:")       (print (Pe L))
                (print "f) Ritmo de lectura:")       (print (Pf L))
                (print "g) Mejor lector (BIEN):")    (print (Pg L))
                (print "h) Reporte de socios:")      (print (Ph L LS))
            )
            (print "Error: debe ingresar datos validos")
        )
    )
)

; =============================================================================
; PRUEBA  L  = ((5 BIEN 300) (20 DANADO 150) (10 BIEN 900) (3 DANADO 40) (40 BIEN 1200))
;         LS = (ANA BETO CARLA DIEGO EVA)
;
;   (Pa L)    -> NIL              (Pb L 7)  -> 3         (Pc L) -> 5
;   (Pd L)    -> (300 150 900 40 1200)
;   (Pe L)    -> (NIL (20 DANADO 150) NIL (3 DANADO 40) NIL)
;   (Pf L)    -> ("normal" "lento" "veloz" "lento" "normal")
;   (Pg L)    -> (10 BIEN 900)
;   (Ph L LS) -> ((ANA 60 OK) (BETO 7 RECLAMAR) (CARLA 90 OK)
;                 (DIEGO 13 RECLAMAR) (EVA 30 MOROSO))
; =============================================================================
