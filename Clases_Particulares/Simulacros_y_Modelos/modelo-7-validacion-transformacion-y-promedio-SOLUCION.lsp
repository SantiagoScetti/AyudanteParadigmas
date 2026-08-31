; MODELO 7 - VALIDACION ESTRUCTURAL, TRANSFORMACION Y PROMEDIO - SOLUCION DE REFERENCIA
; Hemocentro:  DONACION = (DONANTE VOLUMEN ESTADO)
;              ESTADO   = A (apta) / O (en observacion) / R (rechazada)
;
; Accesores de una DONACION:
;   DONANTE  -> (car   donacion)
;   VOLUMEN  -> (cadr  donacion)
;   ESTADO   -> (caddr donacion)
;
; Sobre la lista completa, ojo con el nivel:
;   (car lista)         -> la primera DONACION entera (una sublista)
;   (caddr (car lista)) -> el ESTADO de la primera donacion
;   (caddar lista)      -> lo mismo, escrito con el atajo
;
; CRITERIO PARA ELEGIR LA HERRAMIENTA (el enunciado no lo dice):
;   MAPCAR    -> la lista de salida tiene la MISMA cantidad de elementos que la
;                de entrada y cada uno se calcula mirando solo su posicion.
;   RECURSION -> la salida es UN valor unico, o la lista de salida CAMBIA DE
;                LONGITUD (filtrar), o hay que recorrer decidiendo si cortar.
;
;   punto 1 -> RECURSION (devuelve T/NIL y corta apenas encuentra uno que falla)
;   punto 2 -> MAPCAR    (misma longitud, una sublista por donacion)
;   punto 3 -> RECURSION (filtra: la salida es mas corta)
;   punto 4 -> MAPCAR    (misma longitud que la lista que recibe)
;   punto 5 -> RECURSION (devuelve un numero)


; =============================================================================
; PUNTO 1 - PREDICADO UNIVERSAL: "todos cumplen"
; Molde: caso base T (una lista vacia cumple, no quedo ninguno mal), y apenas
; encuentra UNO que no cumple corta con NIL. Es el espejo de "existe alguno",
; donde se corta con T y el caso base es NIL.
;
; El orden de las ramas NO es decorativo: primero se pregunta si es una lista
; (CONSP) y recien despues se le pide el LENGTH. Al reves, LENGTH sobre un
; atomo hace explotar la funcion.
; =============================================================================
(defun todas-sublistas-de-3-p (lista)
    (cond
        ((null lista) T)
        ((not (consp (car lista))) NIL)
        ((not (= (length (car lista)) 3)) NIL)
        (T (todas-sublistas-de-3-p (cdr lista)))
    )
)


; =============================================================================
; PUNTO 2 - MAPCAR REEMPLAZANDO UN CAMPO ADENTRO DE LA SUBLISTA
; Este es el punto que mas se confunde: el enunciado NO pide devolver la
; descripcion sola, pide devolver la sublista ENTERA con un campo cambiado.
; Por eso la lambda arma la sublista de nuevo con LIST: los dos primeros datos
; salen tal cual y el tercero se reemplaza.
;
; La traduccion del estado va en una auxiliar aparte: adentro de la lambda
; quedaria un COND dentro de un LIST y se vuelve ilegible.
; =============================================================================
(defun descripcion-estado (estado)
    (cond
        ((equal estado 'A) "apta")
        ((equal estado 'O) "en observacion")
        (T "rechazada")
    )
)

(defun donaciones-descriptas (lista)
    (mapcar (lambda (donacion)
                (list (car donacion)
                      (cadr donacion)
                      (descripcion-estado (caddr donacion))))
            lista)
)


; =============================================================================
; PUNTO 3 - RECURSION QUE FILTRA
; La salida es MAS CORTA que la entrada, asi que MAPCAR no sirve: se arma con
; CONS y el caso base es NIL. Lo que se guarda es la sublista ENTERA
; ( (car lista) ), no un dato suelto.
; =============================================================================
(defun solo-aptas (lista)
    (cond
        ((null lista) NIL)
        ((equal (caddr (car lista)) 'A)
            (cons (car lista) (solo-aptas (cdr lista))))
        (T (solo-aptas (cdr lista)))
    )
)


; =============================================================================
; PUNTO 4 - MAPCAR SOBRE LA LISTA QUE DEVOLVIO OTRO PUNTO
; La funcion no vuelve a filtrar: recibe una lista de donaciones y saca el
; nombre de cada una. Quien la llama le pasa el resultado del punto 3:
;
;       (donantes-de (solo-aptas donaciones))
;
; Esa es la idea de reutilizar funciones: cada una hace UNA cosa y se combinan.
; Se puede escribir mas corto sin lambda:  (mapcar 'car lista)
; =============================================================================
(defun donantes-de (lista)
    (mapcar (lambda (donacion) (car donacion)) lista)
)


; =============================================================================
; PUNTO 5 - PROMEDIO CON CONDICION Y CON DATOS SUCIOS
; Promedio = suma / cantidad, y las dos cuentas miran SOLO las aptas validas.
; Hacen falta dos recorridos (una sumadora y una contadora): no se puede sacar
; el promedio en una sola pasada sin acumuladores.
;
; APTA-VALIDA-P concentra toda la validacion en un solo lugar. El AND corta
; apenas una condicion falla, asi que si el elemento no es lista nunca se le
; pide el LENGTH ni el CADR: por eso el orden de las condiciones importa.
;
; El caso base del promedio evita la DIVISION POR CERO: si no hay ninguna apta,
; la cuenta da 0 y (/ algo 0) haria explotar el programa.
;
; FLOAT es para que muestre 473.33334 y no la fraccion 1420/3, que es lo que
; devuelve LISP al dividir dos enteros.
; =============================================================================
(defun apta-valida-p (elemento)
    (and (consp elemento)
         (= (length elemento) 3)
         (numberp (cadr elemento))
         (equal (caddr elemento) 'A))
)

(defun suma-aptas (lista)
    (cond
        ((null lista) 0)
        ((apta-valida-p (car lista))
            (+ (cadr (car lista)) (suma-aptas (cdr lista))))
        (T (suma-aptas (cdr lista)))
    )
)

(defun cuenta-aptas (lista)
    (cond
        ((null lista) 0)
        ((apta-valida-p (car lista)) (+ 1 (cuenta-aptas (cdr lista))))
        (T (cuenta-aptas (cdr lista)))
    )
)

(defun promedio-aptas (lista)
    (cond
        ((= (cuenta-aptas lista) 0) 0)
        (T (float (/ (suma-aptas lista) (cuenta-aptas lista))))
    )
)


; =============================================================================
; PUNTO 6 - MENU
; Unico lugar donde se usan variables locales (LET).
; Aca se ve PARA QUE SIRVE el predicado del punto 1: no es un capricho del
; enunciado, es la validacion del menu. Con un solo IF alcanza, no hace falta
; anidar nada.
; =============================================================================
(defun menu ()
    (let (donaciones)
        (print "Ingrese la lista de donaciones ((DONANTE VOLUMEN ESTADO) ...):")
        (setq donaciones (read))

        (if (and (consp donaciones) (todas-sublistas-de-3-p donaciones))
            (progn
                (print "Donaciones con el estado descripto:")
                (print (donaciones-descriptas donaciones))
                (print "Solo las donaciones aptas:")
                (print (solo-aptas donaciones))
                (print "Donantes de las donaciones aptas:")
                (print (donantes-de (solo-aptas donaciones)))
                (print "Volumen promedio de las aptas:")
                (print (promedio-aptas donaciones))
            )
            (print "Error: todos los elementos deben ser sublistas de 3 elementos")
        )
    )
)


; =============================================================================
; DESAFIO a) - distribucion con formato (APTAS N OBSERVADAS N RECHAZADAS N)
; Una sola contadora que recibe el estado buscado, en vez de escribir tres
; funciones casi iguales. Despues LIST arma la salida intercalando las
; etiquetas con los numeros.
; =============================================================================
(defun contar-estado (lista estado)
    (cond
        ((null lista) 0)
        ((equal (caddr (car lista)) estado)
            (+ 1 (contar-estado (cdr lista) estado)))
        (T (contar-estado (cdr lista) estado))
    )
)

(defun distribucion (lista)
    (list 'APTAS      (contar-estado lista 'A)
          'OBSERVADAS (contar-estado lista 'O)
          'RECHAZADAS (contar-estado lista 'R))
)


; =============================================================================
; DESAFIO b) - cuantas donaciones superan el promedio general
; La trampa: el promedio es una propiedad de TODA la lista, pero la comparacion
; es elemento por elemento. Si se calcula el promedio adentro de la recursion,
; se recalcula en cada vuelta sobre una lista cada vez mas corta y el resultado
; sale mal.
; La solucion es calcularlo UNA vez afuera y pasarlo como parametro, igual que
; el objetivo del Modelo 6: el parametro no cambia, pero hay que volver a
; pasarlo en cada llamada recursiva.
; =============================================================================
(defun volumen-total (lista)
    (cond
        ((null lista) 0)
        (T (+ (cadr (car lista)) (volumen-total (cdr lista))))
    )
)

(defun cantidad-donaciones (lista)
    (cond
        ((null lista) 0)
        (T (+ 1 (cantidad-donaciones (cdr lista))))
    )
)

(defun promedio-general (lista)
    (cond
        ((= (cantidad-donaciones lista) 0) 0)
        (T (float (/ (volumen-total lista) (cantidad-donaciones lista))))
    )
)

(defun superan-desde (lista promedio)
    (cond
        ((null lista) 0)
        ((> (cadr (car lista)) promedio)
            (+ 1 (superan-desde (cdr lista) promedio)))
        (T (superan-desde (cdr lista) promedio))
    )
)

(defun superan-promedio (lista)
    (superan-desde lista (promedio-general lista))
)


; =============================================================================
; DATOS DE PRUEBA
; (setq donaciones '((ANA 450 A) (BETO 380 O) (CARLA 500 A)
;                    (DIEGO 420 R) (EVA 470 A) (FELIPE 400 O)))
; (setq sucia '((ANA 450 A) HOLA (CARLA 500 A) (X Y) (EVA 470 A) (BETO 380 O)))
;
;   (todas-sublistas-de-3-p donaciones) -> T
;   (todas-sublistas-de-3-p sucia)      -> NIL
;   (donaciones-descriptas donaciones)  -> ((ANA 450 "apta")
;                                           (BETO 380 "en observacion")
;                                           (CARLA 500 "apta")
;                                           (DIEGO 420 "rechazada")
;                                           (EVA 470 "apta")
;                                           (FELIPE 400 "en observacion"))
;   (solo-aptas donaciones)             -> ((ANA 450 A) (CARLA 500 A) (EVA 470 A))
;   (donantes-de (solo-aptas donaciones)) -> (ANA CARLA EVA)
;   (promedio-aptas donaciones)         -> 473.33334   (1420 / 3)
;   (promedio-aptas sucia)              -> 473.33334   (saltea HOLA y (X Y))
;   (promedio-aptas '())                -> 0           (sin division por cero)
;
;   DESAFIO:
;   (distribucion donaciones)           -> (APTAS 3 OBSERVADAS 2 RECHAZADAS 1)
;   (promedio-general donaciones)       -> 436.66666   (2620 / 6)
;   (superan-promedio donaciones)       -> 3           (ANA, CARLA y EVA)
; =============================================================================
