; MODELO 4 - INTEGRADOR CON DOS LISTAS EN PARALELO - SOLUCION DE REFERENCIA
; Logistica:  VIAJE   = (ID_CAMION (KM_INICIAL KM_FINAL) LITROS_CARGADOS CARGA_KG)
;             CHOFER  = (NOMBRE ANTIGUEDAD)
;
; Accesores de un VIAJE:
;   ID_CAMION    -> (car viaje)
;   KM_INICIAL   -> (car (cadr viaje))   = (caadr  viaje)
;   KM_FINAL     -> (cadr (cadr viaje))  = (cadadr viaje)
;   LITROS       -> (caddr viaje)
;   CARGA_KG     -> (cadddr viaje)
;
; Accesores de un CHOFER:
;   NOMBRE       -> (car chofer)
;   ANTIGUEDAD   -> (cadr chofer)
;
; CRITERIO PARA ELEGIR LA HERRAMIENTA (el enunciado no lo dice):
;   MAPCAR    -> la lista de salida tiene la MISMA cantidad de elementos que la
;                de entrada y cada uno se calcula mirando solo su posicion.
;   RECURSION -> la salida es UN valor unico, o la lista de salida CAMBIA DE
;                LONGITUD (filtrar), o hay que comparar/acumular entre elementos.
;
;   punto 4 -> RECURSION  (devuelve un numero)
;   punto 5 -> MAPCAR     (misma longitud, un dato por viaje)
;   punto 6 -> MAPCAR de DOS listas (misma longitud, cruza las dos posiciones)
;   punto 7 -> RECURSION de DOS listas (filtra: la salida es mas corta)


; =============================================================================
; PUNTO 1 - consumo de un viaje
; Se separa km-recorridos como auxiliar: se usa en el punto 1 y en el punto 4.
; =============================================================================
(defun km-recorridos (viaje)
    (- (cadadr viaje) (caadr viaje))
)

(defun consumo (viaje)
    (* (/ (caddr viaje) (km-recorridos viaje)) 100)
)


; =============================================================================
; PUNTO 2 - predicado: viaje eficiente
; =============================================================================
(defun viaje-eficiente-p (viaje)
    (<= (consumo viaje) 20)
)


; =============================================================================
; PUNTO 3 - clasificacion del consumo
; El COND prueba en orden: si no entro por la primera rama, ya se sabe que el
; consumo es mayor a 15, asi que no hay que volver a preguntarlo.
; =============================================================================
(defun clasificar-viaje (viaje)
    (cond
        ((<= (consumo viaje) 15) (list (car viaje) 'ECONOMICO))
        ((<= (consumo viaje) 25) (list (car viaje) 'NORMAL))
        (T (list (car viaje) 'EXCESIVO))
    )
)


; =============================================================================
; PUNTO 4 - RECURSION: devuelve UN numero, la suma de los km de toda la flota.
; =============================================================================
(defun km-totales (viajes)
    (cond
        ((null viajes) 0)
        (T (+ (km-recorridos (car viajes)) (km-totales (cdr viajes))))
    )
)


; =============================================================================
; PUNTO 5 - MAPCAR: misma cantidad de elementos, cada uno sale de su viaje.
; Se reutiliza la funcion del punto 3 tal cual.
; =============================================================================
(defun clasificacion-flota (viajes)
    (mapcar (lambda (viaje) (clasificar-viaje viaje)) viajes)
)


; =============================================================================
; PUNTO 6 - MAPCAR SOBRE DOS LISTAS
; La lambda recibe DOS parametros, uno de cada lista, y MAPCAR las recorre a la
; par. La observacion cruza un dato del viaje (el consumo) con un dato del
; chofer (la antiguedad): por eso hacen falta las dos listas.
; =============================================================================
(defun informe-choferes (viajes choferes)
    (mapcar (lambda (viaje chofer)
                (list (car chofer)
                      (car viaje)
                      (cond
                          ((<= (consumo viaje) 25) 'OK)
                          ((< (cadr chofer) 2) 'CAPACITAR)
                          (T 'REVISAR_UNIDAD)
                      )))
            viajes
            choferes)
)


; =============================================================================
; PUNTO 7 - RECURSION SOBRE DOS LISTAS
; La lista de salida es MAS CORTA que las de entrada (solo van algunos
; choferes), asi que se arma con CONS. La clave es avanzar las DOS listas a la
; vez: (cdr viajes) y (cdr choferes) en cada llamada.
; =============================================================================
(defun choferes-excesivos (viajes choferes)
    (cond
        ((null viajes) NIL)
        ((> (consumo (car viajes)) 25)
            (cons (car (car choferes))
                  (choferes-excesivos (cdr viajes) (cdr choferes))))
        (T (choferes-excesivos (cdr viajes) (cdr choferes)))
    )
)


; =============================================================================
; PUNTO 8 - MENU
; Valida que las dos sean listas y que tengan la misma cantidad de elementos:
; si no coinciden, el recorrido en paralelo no tiene sentido.
; =============================================================================
(defun menu ()
    (let (viajes choferes)
        (print "Ingrese la lista de viajes ((ID (KM_INI KM_FIN) LITROS CARGA) ...):")
        (setq viajes (read))
        (print "Ingrese la lista de choferes ((NOMBRE ANTIGUEDAD) ...):")
        (setq choferes (read))

        (if (and (consp viajes) (consp choferes)
                 (= (length viajes) (length choferes)))
            (progn
                (print "Kilometros totales de la flota:")
                (print (km-totales viajes))
                (print "Clasificacion de consumo de cada viaje:")
                (print (clasificacion-flota viajes))
                (print "Informe de choferes:")
                (print (informe-choferes viajes choferes))
                (print "Choferes con consumo EXCESIVO:")
                (print (choferes-excesivos viajes choferes))
            )
            (print "Error: deben ser dos listas con la misma cantidad de elementos")
        )
    )
)


; =============================================================================
; DATOS DE PRUEBA
; (setq viajes '((C101 (12000 12450) 90 3200)
;                (C102 (8000 8300) 90 1800)
;                (C103 (25000 25600) 66 4000)
;                (C104 (5000 5150) 51 900)
;                (C105 (17000 17800) 120 5000)))
; (setq choferes '((JUAN 6) (MARIA 1) (PEDRO 10) (LUCIA 3) (DIEGO 8)))
;
; Consumos:  C101 -> 20   C102 -> 30   C103 -> 11   C104 -> 34   C105 -> 15
;
;   (consumo (car viajes))              -> 20
;   (viaje-eficiente-p (car viajes))    -> T
;   (clasificar-viaje (car viajes))     -> (C101 NORMAL)
;   (km-totales viajes)                 -> 2300
;   (clasificacion-flota viajes)        -> ((C101 NORMAL) (C102 EXCESIVO)
;                                           (C103 ECONOMICO) (C104 EXCESIVO)
;                                           (C105 ECONOMICO))
;   (informe-choferes viajes choferes)  -> ((JUAN C101 OK)
;                                           (MARIA C102 CAPACITAR)
;                                           (PEDRO C103 OK)
;                                           (LUCIA C104 REVISAR_UNIDAD)
;                                           (DIEGO C105 OK))
;   (choferes-excesivos viajes choferes) -> (MARIA LUCIA)
; =============================================================================
