; MODELO 2 - RECURSION Y MAPCAR - CLASE - SOLUCION DE REFERENCIA
; Taller mecanico: lista de sublistas (COSTO TIEMPO REPUESTOS)
;
; NOTA PARA EL ALUMNO: el enunciado NO dice que herramienta usar.
; El criterio para decidirlo, en una frase:
;   - MAPCAR  -> cuando la salida es UNA LISTA DE LA MISMA LONGITUD que la entrada
;                y cada elemento se calcula MIRANDO SOLO SU PROPIA SUBLISTA.
;   - RECURSION -> cuando la salida es UN VALOR UNICO (numero, T/NIL, una sublista),
;                  o cuando la lista resultante CAMBIA DE LONGITUD (filtrar),
;                  o cuando hay que COMPARAR/ACUMULAR entre elementos.

; Estructura de cada reparacion: (COSTO TIEMPO REPUESTOS)
;   COSTO      -> (car rep)
;   TIEMPO     -> (cadr rep)
;   REPUESTOS  -> (caddr rep)
;   COSTO-HORA -> (/ (car rep) (cadr rep))
; Cuando se accedia sobre (car lista), el car/cdr se combina un nivel mas adentro:
;   (tiempo (car lista))     = (cadar  lista)
;   (costo  (car lista))     = (caar   lista)
;   (repuestos (car lista))  = (caddar lista)

; =============================================================================
; a) RECURSION -> devuelve un valor unico (T/NIL). Predicado UNIVERSAL:
;    corta con NIL apenas encuentra un contraejemplo.
; =============================================================================
(defun todas-tiempo-ok-p (lista limite)
    (cond
        ((null lista) T)
        ((> (cadar lista) limite) NIL)
        (T (todas-tiempo-ok-p (cdr lista) limite))
    )
)

; =============================================================================
; b) RECURSION -> devuelve un numero, no una lista. Contar con condicion.
; =============================================================================
(defun contar-caras (lista valor)
    (cond
        ((null lista) 0)
        ((> (caar lista) valor) (+ 1 (contar-caras (cdr lista) valor)))
        (T (contar-caras (cdr lista) valor))
    )
)

; =============================================================================
; c) RECURSION -> devuelve un numero. Contar todos, sin condicion.
; =============================================================================
(defun cantidad-reparaciones (lista)
    (cond
        ((null lista) 0)
        (T (+ 1 (cantidad-reparaciones (cdr lista))))
    )
)

; =============================================================================
; d) MAPCAR -> misma longitud, cada elemento sale de su propia sublista.
; =============================================================================
(defun repuestos-usados (lista)
    (mapcar (lambda (rep) (caddr rep)) lista)
)

; =============================================================================
; e) RECURSION -> la lista resultante es MAS CORTA que la original (filtrar).
;    MAPCAR no sirve: no puede "saltear" elementos.
; =============================================================================
(defun caras (lista)
    (cond
        ((null lista) NIL)
        ((> (caar lista) 50000) (cons (car lista) (caras (cdr lista))))
        (T (caras (cdr lista)))
    )
)

; =============================================================================
; f) MAPCAR con COND adentro -> misma longitud, decision individual.
;    El LET evita calcular el costo por hora tres veces (rubrica: variables locales).
; =============================================================================
(defun categorizar (lista)
    (mapcar (lambda (rep)
                (let ((ch (/ (car rep) (cadr rep))))
                    (cond
                        ((<= ch 10000) "eficiente")
                        ((<= ch 25000) "aceptable")
                        (T "costosa"))))
            lista)
)

; =============================================================================
; g) DIFICIL - RECURSION obligatoria.
;    Hay que ACUMULAR dos totales a la vez en un unico recorrido: MAPCAR no
;    acumula nada, devuelve una lista paralela.
;
;    Clave: el caso base devuelve (0 0), y en el caso general se guarda el
;    resultado de la llamada recursiva en un LET para no llamarla dos veces
;    (una para el costo y otra para las horas). Ese LET es exactamente lo que
;    permite recorrer la lista UNA sola vez.
; =============================================================================
(defun resumen-con-repuestos (lista)
    (cond
        ((null lista) (list 0 0))
        ((< (caddar lista) 1) (resumen-con-repuestos (cdr lista)))
        (T (let ((resto (resumen-con-repuestos (cdr lista))))
                (list (+ (caar lista) (car resto))
                      (+ (cadar lista) (cadr resto)))))
    )
)

; =============================================================================
; h) DIFICIL - MAPCAR.
;    Misma longitud que la entrada y cada sublista depende solo de su propia
;    reparacion (mas el recargo, que es un parametro fijo): es MAPCAR.
;
;    Clave: la lambda "ve" el parametro RECARGO de la funcion que la contiene,
;    y el LET guarda COSTO-FINAL porque se necesita dos veces (para devolverlo
;    y para calcular la etiqueta).
; =============================================================================
(defun ajustar-reparaciones (lista recargo)
    (mapcar (lambda (rep)
                (let ((costo-final (cond
                                       ((> (caddr rep) 2)
                                        (+ (car rep) (* (car rep) (/ recargo 100))))
                                       (T (car rep)))))
                    (list costo-final
                          (caddr rep)
                          (cond
                              ((> (/ costo-final (cadr rep)) 25000) 'REVISAR)
                              (T 'OK)))))
            lista)
)

; =============================================================================
; i) MENU - funcion principal que integra todo
;    Pide con mensajes alusivos los datos que hacen falta, valida con CONSP /
;    NUMBERP y usa PROGN para ejecutar todos los reportes en la rama verdadera.
; =============================================================================
(defun menu ()
    (let (reparaciones horas valor recargo)
        (pprint "Ingrese la lista de reparaciones ((COSTO TIEMPO REPUESTOS) ...):")
        (setq reparaciones (read))
        (pprint "Ingrese la cantidad maxima de horas:")
        (setq horas (read))
        (pprint "Ingrese el valor de costo a comparar:")
        (setq valor (read))
        (pprint "Ingrese el porcentaje de recargo:")
        (setq recargo (read))
        (if (and (consp reparaciones) (numberp horas) (numberp valor) (numberp recargo))
            (progn
                (pprint (todas-tiempo-ok-p reparaciones horas))
                (pprint (contar-caras reparaciones valor))
                (pprint (cantidad-reparaciones reparaciones))
                (pprint (repuestos-usados reparaciones))
                (pprint (caras reparaciones))
                (pprint (categorizar reparaciones))
                (pprint (resumen-con-repuestos reparaciones))
                (pprint (ajustar-reparaciones reparaciones recargo))
            )
            (pprint "Error: debe ingresar datos validos")
        )
    )
)

; =============================================================================
; DATOS DE PRUEBA
; (setq reparaciones '((45000 3 0) (70000 6 4) (15000 3 2) (60000 2 5) (30000 5 0)))
;
;   (todas-tiempo-ok-p reparaciones 5)   -> NIL   (la 2da insumio 6 horas)
;   (todas-tiempo-ok-p reparaciones 6)   -> T
;   (contar-caras reparaciones 40000)    -> 3     (45000, 70000 y 60000)
;   (cantidad-reparaciones reparaciones) -> 5
;   (repuestos-usados reparaciones)      -> (0 4 2 5 0)
;   (caras reparaciones)                 -> ((70000 6 4) (60000 2 5))
;   (categorizar reparaciones)           -> ("aceptable" "aceptable" "eficiente"
;                                            "costosa" "eficiente")
;         costo/hora: 15000, 11666.67, 5000, 30000, 6000
;   (resumen-con-repuestos reparaciones) -> (145000 11)
;         suma solo las 3 con repuestos >= 1: 70000+15000+60000 y 6+3+2
;   (ajustar-reparaciones reparaciones 10) -> ((45000 0 OK)
;                                              (77000 4 OK)
;                                              (15000 2 OK)
;                                              (66000 5 REVISAR)
;                                              (30000 0 OK))
;         solo la 2da y la 4ta superan los 2 repuestos -> reciben el +10%
;         66000/2 = 33000 > 25000 -> REVISAR
; =============================================================================
