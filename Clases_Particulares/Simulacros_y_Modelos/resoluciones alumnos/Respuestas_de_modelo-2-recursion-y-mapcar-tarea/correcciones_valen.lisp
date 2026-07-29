; =============================================================================
; CORRECCIONES - VALEN                                          NOTA:  4 / 10
; Modelo 2 - Recursividad y MAPCAR (biblioteca: (DIAS ESTADO PAGINAS))
; =============================================================================
; Puntos resueltos: 9 de 9 (no dejo nada en blanco)
; Funciones que compilan: 7 de 9   (3 y 8 no compilan)
; Funciones que dan el resultado correcto: 1  (calcular_ritmo)
;
;   1) llama a buen_estado, que no existe -> error al correr
;   2) devuelve T en vez de contar
;   3) NO COMPILA: 'Error' rompe la lectura. Sacando esa linea, estaba BIEN
;   4) devuelve NIL siempre
;   5) enfoque correcto, falla por usar "=" con simbolos
;   6) calcular_ritmo PERFECTA. rl_prestamos devuelve "ERROR" siempre
;   7) buscar_mayor se define con 1 parametro y se la llama con 2
;   8) NO COMPILA: "illegal function call"
;   9) el menu esta bien armado; falla en como llama a las funciones
;
; -----------------------------------------------------------------------------
; LO QUE HIZO BIEN
;   - Respondio los 9 puntos y el menu esta bien estructurado (LET, mensajes,
;     READ, validacion con CONSP/NUMBERP, PROGN). Ese punto lo tiene.
;   - calcular_ritmo es exactamente lo que habia que escribir.
;   - Uso (endp lista) como caso base y (caar lista) para los dias: bien.
;   - En 5 y 8 eligio MAPCAR, que es la herramienta correcta.
;
; -----------------------------------------------------------------------------
; LOS 3 ERRORES QUE SE LE REPITEN
;
; A. RAMAS DE COND SIN RESULTADO:  ((and (consp lista) (numberp cd)))
;    Una rama es (CONDICION RESULTADO). Si escribis solo la condicion, el COND
;    devuelve el valor de la condicion. Por eso el punto 2 devuelve T: esa
;    rama se cumple en la primera vuelta y la funcion termina ahi.
;
; B. VALIDAR ADENTRO DE LA FUNCION RECURSIVA. Puso (consp lista) / "Error" /
;    (numberp cd) adentro de casi todas. Eso va UNA vez en el menu. Adentro de
;    la recursion tapa la rama que hacia el trabajo (puntos 2 y 4).
;
; C. LLAMAR A UNA FUNCION SIN SUS ARGUMENTOS:  (calcular_ritmo),
;    (truncate (calcular_ritmo)), (buscar_mayor x y) con un solo parametro.
;    Y en el menu pasa el NOMBRE de una funcion como si fuera un dato:
;    (rl_prestamos calcular_ritmo lista_prestamos).
; =============================================================================


; -----------------------------------------------------------------------------
; 1)  ((and (atom (caadr lista_prestamos)) 'BIEN) (buen_estado (cdr ...)))
;   - La funcion se llama buen_estado_p pero adentro llama a buen_estado, sin
;     el _p. Esa no existe -> "undefined function". Tienen que coincidir.
;   - Falta el caso base (null lista): sin el, la recursion no termina.
;   - (and (atom ...) 'BIEN) no compara nada: AND devuelve el ultimo valor y
;     'BIEN nunca es NIL, asi que la condicion siempre da verdadero.
;   - caadr son los DIAS del SEGUNDO prestamo. El estado del primero es (cadar).
;   - Las dos ramas hacen lo mismo, asi que el COND no decide nada.
; -----------------------------------------------------------------------------
(defun buen_estado_p (lista_prestamos)
    (cond
        ((null lista_prestamos) T)
        ((not (equal (cadar lista_prestamos) 'BIEN)) NIL)
        (t (buen_estado_p (cdr lista_prestamos)))
    )
)


; -----------------------------------------------------------------------------
; 2)  ((and (consp lista_prestamos) (numberp cd)))
;   - Rama sin resultado (error A): con una lista con datos devuelve T y nunca
;     cuenta. Probado: con la lista del enunciado y cd=7 devuelve T, no 3.
;   - Se saca esa rama y listo: el resto estaba bien.
; -----------------------------------------------------------------------------
(defun cant_prestamos (lista_prestamos cd)
    (cond
        ((endp lista_prestamos) 0)
        ((> (caar lista_prestamos) cd) (+ 1 (cant_prestamos (cdr lista_prestamos) cd)))
        (t (cant_prestamos (cdr lista_prestamos) cd))
    )
)


; -----------------------------------------------------------------------------
; 3)  ((not (consp lista_prestamos) 'Error'))     <- ESTE PUNTO ESTABA BIEN
;   - 'Error' tiene una comilla AL FINAL. La comilla en LISP no cierra: ABRE.
;     Se come el parentesis que sigue, el interprete pierde la cuenta y avisa
;     "unmatched close parenthesis". La funcion no llega a definirse.
;     Texto -> comillas dobles "Error".  Atomo -> una comilla adelante 'ERROR.
;   - NOT recibe UN solo argumento: (not X 'Error') son dos.
;   - Y de nuevo la validacion adentro de la recursion (error B).
;   Sacando esa linea, lo demas estaba perfecto.
; -----------------------------------------------------------------------------
(defun total_prestamos (lista_prestamos)
    (cond
        ((endp lista_prestamos) 0)
        (t (+ 1 (total_prestamos (cdr lista_prestamos))))
    )
)


; -----------------------------------------------------------------------------
; 4)  ((numberp (caddr (car lista_prestamos))) nil)  ((cons (caddr ...) ...))
;   - La rama del NUMBERP se cumple SIEMPRE (las paginas son un numero) y
;     devuelve NIL. La del CONS, que era la que trabajaba, nunca se ejecuta.
;   - Ademas esa rama del CONS esta escrita como ((cons ...)): sin resultado.
;   - Adentro usa (cdr lista) pero el parametro es lista_prestamos.
;   - El caso base devuelve 0 y aca la salida es una LISTA: va NIL.
;   Con MAPCAR se resuelve en una linea y no hace falta nada de esto.
; -----------------------------------------------------------------------------
(defun cant_paginas (lista_prestamos)
    (mapcar (lambda (p) (caddr p)) lista_prestamos)
)


; -----------------------------------------------------------------------------
; 5)  El MAPCAR esta bien elegido (devolver NIL en los que no corresponden es
;     una forma valida de resolverlo). El unico error de fondo:
;   - "=" solo compara NUMEROS. Con simbolos tira error. Va EQUAL.
;   - El (if (consp ...) ... "ERROR") de afuera es validacion: va al menu.
;   - (consp x) adentro de la lambda sobra: si la lista viene bien formada,
;     todos los elementos son sublistas.
; -----------------------------------------------------------------------------
(defun prestamos_danados (lista_prestamos)
    (mapcar (lambda (x)
                (cond
                    ((equal (cadr x) 'DANADO) x)
                    (t nil)
                ))
            lista_prestamos)
)


; -----------------------------------------------------------------------------
; 6)  calcular_ritmo: CORRECTA, no se toca.
;
;     rl_prestamos:   ... lista_prestamos )    "ERROR"  )
;   - Le sobro un parentesis y "ERROR" quedo como ULTIMA expresion del DEFUN.
;     Una funcion devuelve su ultima expresion, asi que rl_prestamos devuelve
;     "ERROR" siempre y el MAPCAR se calcula al pedo.
;   - ((and (> (calcular_ritmo x) 20) (<= (calcular_ritmo) 60) "normal"))
;     tiene dos problemas: "normal" quedo ADENTRO del AND (es parte de la
;     pregunta y no la respuesta) y la rama no tiene resultado (error A).
;   - (calcular_ritmo) sin argumento -> error de cantidad de argumentos.
;   - No hace falta repetir (> ... 20): el COND prueba en orden, si no entro
;     por la primera ya sabe que es mayor a 20.
; -----------------------------------------------------------------------------
(defun calcular_ritmo (lista_prestamos)
   (/ (caddr lista_prestamos) (car lista_prestamos))
)

(defun rl_prestamos (lista_prestamos)
    (mapcar (lambda (x)
                (cond
                    ((<= (calcular_ritmo x) 20) "lento")
                    ((<= (calcular_ritmo x) 60) "normal")
                    (t "veloz")
                ))
            lista_prestamos)
)


; -----------------------------------------------------------------------------
; 7)  La idea estaba: "comparo el actual contra el mejor del resto" es el
;     razonamiento correcto. Lo que fallo:
;   - buscar_mayor se DEFINE con un parametro y se la LLAMA con dos.
;   - A ese parametro lo llamo calcular_ritmo, que es el nombre de otra
;     funcion. Nunca ponerle a una variable el nombre de una funcion.
;   - buscar_mayor recorre una lista de ritmos que no se arma en ningun lado.
;     La auxiliar tiene que recibir DOS PRESTAMOS y contemplar que el resto
;     puede venir NIL.
;   - Otra vez (not (consp ...) "Error") con dos argumentos, y usa (car lista)
;     cuando el parametro se llama lista_prestamos.
; -----------------------------------------------------------------------------
(defun buscar_mayor (p1 p2)
    (cond
        ((null p1) p2)
        ((null p2) p1)
        ((> (calcular_ritmo p1) (calcular_ritmo p2)) p1)
        (t p2)
    )
)

(defun buena_lectura (lista_prestamos)
    (cond
        ((endp lista_prestamos) NIL)
        ((equal (cadar lista_prestamos) 'BIEN)
            (buscar_mayor (car lista_prestamos) (buena_lectura (cdr lista_prestamos))))
        (t (buena_lectura (cdr lista_prestamos)))
    )
)


; -----------------------------------------------------------------------------
; 8)  EL OTRO PUNTO QUE NO COMPILA:
;         (if ((and (consp lista_prestamos) (lista_prestamos))) ...)
;     Los parentesis de mas significan LLAMAR: LISP intenta ejecutar el
;     resultado del AND como si fuera una funcion -> "illegal function call".
;     Lo mismo con (lista_prestamos) y con (list (y)): una variable se escribe
;     SIN parentesis.
;   - (length x y): LENGTH recibe UNA sola lista.
;   - La lambda no arma la sublista pedida, solo devuelve (y).
;   - En L2: 'SOCIO esta fijo y tiene que venir de la segunda lista, asi que L2
;     necesita DOS parametros. (calcular_ritmo) otra vez sin argumento. Y si el
;     parametro ya es UN prestamo, el estado es (cadr prestamo), a secas.
;   - El enunciado pide FLOOR, no TRUNCATE.
; -----------------------------------------------------------------------------
(defun L2 (prestamo socio)
    (list socio
        (floor (calcular_ritmo prestamo))
        (cond
            ((equal (cadr prestamo) 'DANADO) 'RECLAMAR)
            ((> (car prestamo) 30) 'MOROSO)
            (t 'OK)
        )
    )
)

(defun lista_socios (lista_prestamos socios)
    (mapcar (lambda (prestamo socio) (L2 prestamo socio))
            lista_prestamos socios)
)


; -----------------------------------------------------------------------------
; 9)  La estructura del menu esta BIEN. Solo se corrigen las llamadas:
;   - (rl_prestamos calcular_ritmo lista_prestamos): le pasa el nombre de una
;     funcion como dato, y rl_prestamos recibe un solo parametro.
;   - (lista_socios L2 lista_prestamos): lo mismo, y ademas al reves.
;   - Falta llamar al punto 7. El enunciado pide que llame a TODAS.
;   - La variable local se llama igual que la funcion lista_socios: confunde.
; -----------------------------------------------------------------------------
(defun menu ()
    (let (lista_prestamos socios cd)

        (print "Ingrese la lista de los prestamos de libros:")
        (setq lista_prestamos (read))

        (print "Ingrese la lista de socios:")
        (setq socios (read))

        (print "Ingrese el limite de dias para devolver un libro:")
        (setq cd (read))

        (if (and (consp lista_prestamos) (consp socios) (numberp cd))
            (progn
                (print "1. Todos los libros en buen estado:")
                (print (buen_estado_p lista_prestamos))
                (print "2. Prestamos que superaron el limite de dias:")
                (print (cant_prestamos lista_prestamos cd))
                (print "3. Total de prestamos registrados:")
                (print (total_prestamos lista_prestamos))
                (print "4. Paginas de cada libro:")
                (print (cant_paginas lista_prestamos))
                (print "5. Prestamos devueltos danados:")
                (print (prestamos_danados lista_prestamos))
                (print "6. Ritmo de lectura:")
                (print (rl_prestamos lista_prestamos))
                (print "7. Prestamo con mejor ritmo devuelto BIEN:")
                (print (buena_lectura lista_prestamos))
                (print "8. Informacion de cada socio:")
                (print (lista_socios lista_prestamos socios))
            )
            (print "Error: debe ingresar datos validos")
        )
    )
)

; =============================================================================
; PRUEBA  lp = ((5 BIEN 300) (20 DANADO 150) (10 BIEN 900) (3 DANADO 40) (40 BIEN 1200))
;         s  = (ANA BETO CARLA DIEGO EVA)
;
;   (buen_estado_p lp)     -> NIL          (cant_prestamos lp 7) -> 3
;   (total_prestamos lp)   -> 5            (cant_paginas lp) -> (300 150 900 40 1200)
;   (prestamos_danados lp) -> (NIL (20 DANADO 150) NIL (3 DANADO 40) NIL)
;   (rl_prestamos lp)      -> ("normal" "lento" "veloz" "lento" "normal")
;   (buena_lectura lp)     -> (10 BIEN 900)
;   (lista_socios lp s)    -> ((ANA 60 OK) (BETO 7 RECLAMAR) (CARLA 90 OK)
;                              (DIEGO 13 RECLAMAR) (EVA 30 MOROSO))
; =============================================================================
