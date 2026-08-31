; MODELO 6 - DOS LISTAS EN PARALELO Y UN PARAMETRO SUELTO - SOLUCION DE REFERENCIA
; Estacion de servicio:  SURTIDOR = (ID_SURTIDOR TIPO (TURNO_1 TURNO_2 TURNO_3) PRECIO_LITRO)
;                        MEDICION = un numero suelto (lista PLANA, no de sublistas)
;                        OBJETIVO = un numero suelto que no viene de ninguna lista
;
; Accesores de un SURTIDOR:
;   ID_SURTIDOR   -> (car surtidor)
;   TIPO          -> (cadr surtidor)
;   la sublista   -> (caddr surtidor)
;   TURNO_1       -> (car   (caddr surtidor))
;   TURNO_2       -> (cadr  (caddr surtidor))
;   TURNO_3       -> (caddr (caddr surtidor))
;   PRECIO_LITRO  -> (cadddr surtidor)
;
; OJO CON LOS ATAJOS: los combos tipo caddr/cadar valen hasta 4 letras entre la c
; y la r. Para el TURNO_2 haria falta "cadaddr", que tiene 5 y NO EXISTE. Cuando
; la sublista tiene 3 elementos hay que separar los dos pasos:
;   PASO 1 - traer la sublista:  (caddr surtidor)
;   PASO 2 - sacarle el dato:    (cadr <esa sublista>)
;
; OJO CON LA LISTA PLANA: en MEDICIONES, (car mediciones) YA ES EL NUMERO.
; No lleva un car de mas: no es una sublista como en los modelos anteriores.
;
; CRITERIO PARA ELEGIR LA HERRAMIENTA (el enunciado no lo dice):
;   MAPCAR    -> la lista de salida tiene la MISMA cantidad de elementos que la
;                de entrada y cada uno se calcula mirando solo su posicion.
;   RECURSION -> la salida es UN valor unico, o la lista de salida CAMBIA DE
;                LONGITUD (filtrar), o hay que comparar/acumular entre elementos.
;
;   punto 4 -> RECURSION  (devuelve un numero)
;   punto 5 -> RECURSION  (devuelve un numero, y arrastra el parametro OBJETIVO)
;   punto 6 -> MAPCAR     (misma longitud, un dato por surtidor)
;   punto 7 -> MAPCAR de DOS listas (misma longitud, cruza las dos posiciones)
;   punto 8 -> RECURSION de DOS listas (filtra: la salida es mas corta)


; =============================================================================
; PUNTO 1 - litros vendidos en el dia por un surtidor
; Se separa como auxiliar porque se reutiliza en los puntos 2, 3, 7 y 8.
; =============================================================================
(defun litros-dia (surtidor)
    (+ (car   (caddr surtidor))
       (cadr  (caddr surtidor))
       (caddr (caddr surtidor)))
)


; =============================================================================
; PUNTO 2 - PREDICADO: alcanzo el objetivo diario
; El objetivo NO sale del surtidor: entra como segundo parametro.
; =============================================================================
(defun alcanzo-objetivo-p (surtidor objetivo)
    (>= (litros-dia surtidor) objetivo)
)


; =============================================================================
; PUNTO 3 - nivel de venta del surtidor
; El COND prueba en orden: si no entro por la primera rama, ya se sabe que los
; litros son mayores a 1500, asi que no hay que volver a preguntarlo.
; =============================================================================
(defun nivel-venta (surtidor)
    (cond
        ((<= (litros-dia surtidor) 1500) (list (car surtidor) 'BAJA))
        ((<= (litros-dia surtidor) 3000) (list (car surtidor) 'MEDIA))
        (T (list (car surtidor) 'ALTA))
    )
)


; =============================================================================
; AUXILIAR - recaudacion de un surtidor (la formula del enunciado)
; =============================================================================
(defun recaudacion (surtidor)
    (* (litros-dia surtidor) (cadddr surtidor))
)


; =============================================================================
; PUNTO 4 - RECURSION: devuelve UN numero, la suma de toda la estacion.
; Caso base 0 porque se esta sumando.
; =============================================================================
(defun recaudacion-total (surtidores)
    (cond
        ((null surtidores) 0)
        (T (+ (recaudacion (car surtidores)) (recaudacion-total (cdr surtidores))))
    )
)


; =============================================================================
; PUNTO 5 - RECURSION CON UN PARAMETRO SUELTO
; Devuelve un numero (cuantos), asi que es contador: caso base 0 y se combina
; con (+ 1 ...). El OBJETIVO no cambia nunca, pero hay que volver a pasarlo en
; CADA llamada recursiva: si se lo olvidan, la funcion no compila.
; =============================================================================
(defun cantidad-en-objetivo (surtidores objetivo)
    (cond
        ((null surtidores) 0)
        ((alcanzo-objetivo-p (car surtidores) objetivo)
            (+ 1 (cantidad-en-objetivo (cdr surtidores) objetivo)))
        (T (cantidad-en-objetivo (cdr surtidores) objetivo))
    )
)


; =============================================================================
; PUNTO 6 - MAPCAR: misma cantidad de elementos, cada uno sale de su surtidor.
; Se reutiliza la funcion del punto 3 tal cual.
; =============================================================================
(defun niveles-estacion (surtidores)
    (mapcar (lambda (surtidor) (nivel-venta surtidor)) surtidores)
)


; =============================================================================
; AUXILIARES DEL CONTROL DE TANQUE
; La diferencia cruza un dato del surtidor con el numero suelto de la otra
; lista, por eso la auxiliar recibe los dos.
; =============================================================================
(defun diferencia-control (surtidor medicion)
    (- medicion (litros-dia surtidor))
)

(defun estado-control (diferencia)
    (cond
        ((> diferencia 20) 'FALTANTE)
        ((< diferencia -20) 'SOBRANTE)
        (T 'OK)
    )
)

(defun control-surtidor (surtidor medicion)
    (list (car surtidor)
          (diferencia-control surtidor medicion)
          (estado-control (diferencia-control surtidor medicion)))
)


; =============================================================================
; PUNTO 7 - MAPCAR SOBRE DOS LISTAS
; La lambda recibe DOS parametros, uno de cada lista, y MAPCAR las recorre a la
; par. Como MEDICIONES es plana, el segundo parametro ya es el numero: se usa
; directamente, sin car.
; =============================================================================
(defun control-estacion (surtidores mediciones)
    (mapcar (lambda (surtidor medicion) (control-surtidor surtidor medicion))
            surtidores
            mediciones)
)


; =============================================================================
; PUNTO 8 - RECURSION SOBRE DOS LISTAS
; La lista de salida es MAS CORTA que las de entrada (solo van algunos ID), asi
; que se arma con CONS y el caso base es NIL. La clave es avanzar las DOS listas
; a la vez: (cdr surtidores) y (cdr mediciones) en cada llamada.
; Se corta si CUALQUIERA de las dos se vacia, para no hacer car sobre NIL.
; =============================================================================
(defun surtidores-con-faltante (surtidores mediciones)
    (cond
        ((null surtidores) NIL)
        ((null mediciones) NIL)
        ((> (diferencia-control (car surtidores) (car mediciones)) 20)
            (cons (car (car surtidores))
                  (surtidores-con-faltante (cdr surtidores) (cdr mediciones))))
        (T (surtidores-con-faltante (cdr surtidores) (cdr mediciones)))
    )
)


; =============================================================================
; PUNTO 9 - MENU
; Unico lugar donde se usan variables locales (LET). Valida que las dos sean
; listas, que tengan la misma cantidad de elementos (si no, el recorrido en
; paralelo no tiene sentido) y que el objetivo sea numerico.
; =============================================================================
(defun menu ()
    (let (surtidores mediciones objetivo)
        (print "Ingrese la lista de surtidores ((ID TIPO (T1 T2 T3) PRECIO) ...):")
        (setq surtidores (read))
        (print "Ingrese la lista de mediciones del tanque (un numero por surtidor):")
        (setq mediciones (read))
        (print "Ingrese el objetivo diario de litros por surtidor:")
        (setq objetivo (read))

        (if (and (consp surtidores) (consp mediciones) (numberp objetivo)
                 (= (length surtidores) (length mediciones)))
            (progn
                (print "Recaudacion total de la estacion:")
                (print (recaudacion-total surtidores))
                (print "Surtidores que alcanzaron el objetivo:")
                (print (cantidad-en-objetivo surtidores objetivo))
                (print "Nivel de venta de cada surtidor:")
                (print (niveles-estacion surtidores))
                (print "Control de tanque:")
                (print (control-estacion surtidores mediciones))
                (print "Surtidores con FALTANTE:")
                (print (surtidores-con-faltante surtidores mediciones))
            )
            (print "Error: deben ser dos listas de igual longitud y un objetivo numerico")
        )
    )
)


; =============================================================================
; DATOS DE PRUEBA
; (setq surtidores '((S01 NAFTA  (900 1200 600)   1150)
;                    (S02 GASOIL (1500 1300 900)  1080)
;                    (S03 NAFTA  (400 500 300)    1150)
;                    (S04 GASOIL (1100 1000 800)  1080)
;                    (S05 NAFTA  (1600 1400 1100) 1150)))
; (setq mediciones '(2710 3760 1150 2895 4135))
; (setq objetivo 2500)
;
; Litros del dia:  S01 -> 2700   S02 -> 3700   S03 -> 1200
;                  S04 -> 2900   S05 -> 4100
; Diferencias:     S01 -> 10     S02 -> 60     S03 -> -50
;                  S04 -> -5     S05 -> 35
;
;   (litros-dia (car surtidores))                  -> 2700
;   (alcanzo-objetivo-p (car surtidores) 2500)     -> T
;   (nivel-venta (car surtidores))                 -> (S01 MEDIA)
;   (recaudacion-total surtidores)                 -> 16328000
;   (cantidad-en-objetivo surtidores 2500)         -> 4
;   (niveles-estacion surtidores)                  -> ((S01 MEDIA) (S02 ALTA)
;                                                      (S03 BAJA) (S04 MEDIA)
;                                                      (S05 ALTA))
;   (control-estacion surtidores mediciones)       -> ((S01 10 OK)
;                                                      (S02 60 FALTANTE)
;                                                      (S03 -50 SOBRANTE)
;                                                      (S04 -5 OK)
;                                                      (S05 35 FALTANTE))
;   (surtidores-con-faltante surtidores mediciones) -> (S02 S05)
; =============================================================================
