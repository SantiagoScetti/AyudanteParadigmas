Modelo B

(ID_ESTACION DEMANDA (TENSION_MIN TENSION_ACTUAL TENSION_MAX) TARIFA)
Donde:
● ID_ESTACION es el identificador de la estación.
● DEMANDA es la potencia que se está consumiendo en este momento (en kW).
● (TENSION_MIN TENSION_ACTUAL TENSION_MAX) es una sublista con el valor de
tensión actual y los límites mínimo y máximo de operación segura.
● TARIFA es el precio de la energía (en $ por kWh).
Datos de prueba de ejemplo:
(red '(
(E1 50 (200 220 240) 35)
(E2 80 (210 205 230) 40)
(E3 30 (200 250 240) 38)
))

1.- Antes de facturar, el sistema necesita estimar el costo. Desarrollar una función que, a partir de los
datos de una estación, calcule el costo actual según la fórmula: (1.5 p)
( costo = DEMANDA × TARIFA )

(defun costo_actual (lista_estacion)
    (if
        (and(numberp (cadr lista_estacion))(numberp (car (last lista_estacion))))
        (* (cadr lista_estacion)(car (last lista_estacion)))
    )
)

2.- El sistema debe verificar si una estación opera con tensión segura. Desarrollar una función
predicado que reciba la lista de una estación y evalúe si la TENSION_ACTUAL se encuentra dentro
del rango permitido (TENSION_MIN, TENSION_MAX). 

(E3 30 (200 250 240) 38)

(defun tension_segura (lista_estacion)
  ;; Un único IF plano: validamos tipos y después evaluamos el rango
  (if (and (listp lista_estacion)
           (numberp (car (caddr lista_estacion)))    ; Mínimo (caaddr)
           (numberp (cadr (caddr lista_estacion)))   ; Actual (cadadr)
           (numberp (caddr (caddr lista_estacion)))  ; Máximo (caddadr)
           
           ;; Condición 1: ¿La Tensión Actual es MAYOR que el Mínimo?
           (> (cadr (caddr lista_estacion)) (car (caddr lista_estacion)))
           
           ;; Condición 2: ¿La Tensión Actual es MENOR que el Máximo?
           (< (cadr (caddr lista_estacion)) (caddr (caddr lista_estacion))))
      t
      nil))


3.- El centro de control necesita el estado descriptivo de cada estación. Definir una función que reciba
la lista de una estación y, (2 p)
● retorne (ID_ESTACION BAJA), cuando la tensión actual sea menor al mínimo permitido.
● retorne (ID_ESTACION ESTABLE), si la tensión actual se encuentra dentro del rango
seguro.
● retorne (ID_ESTACION ALTA), cuando la tensión actual supere el máximo permitido.

(defun estado_estacion (lista_estacion)
  (cond 
    ;; RAMA 1: Validación inicial de los peores escenarios (si no es lista, no hacemos nada)
    ((not (and (listp lista_estacion)
               (numberp (car (caddr lista_estacion)))
               (numberp (cadr (caddr lista_estacion)))
               (numberp (caddr (caddr lista_estacion))))) nil)
    
    ;; RAMA 2: Si es menor al mínimo permito -> BAJA
    ((< (cadr (caddr lista_estacion)) (car (caddr lista_estacion)))
     (list (car lista_estacion) 'BAJA))
    
    ;; RAMA 3: Reutilizamos tu función. Si está en rango seguro -> ESTABLE
    ((tension_segura lista_estacion)
     (list (car lista_estacion) 'ESTABLE))
    
    ;; RAMA 4 (T): Si no fue menor ni fue segura, por descarte es mayor al máximo -> ALTA
    (t (list (car lista_estacion) 'ALTA))))

4.- Hasta acá se trabajó con una sola estación. Pero la red es grande, por lo que el dato de entrada
ahora es una lista de sublistas con el siguiente formato:
(
(ID_ESTACION DEMANDA (TENSION_MIN TENSION_ACTUAL TENSION_MAX) TARIFA)
(ID_ESTACION DEMANDA (TENSION_MIN TENSION_ACTUAL TENSION_MAX) TARIFA)
...
)
Desarrollar: (3 p en total)
● → Una función que, utilizando MAPCAR, genere la lista con el identificador y el estado de
cada estación de la red. (1.5 p)
● → Una función que, mediante un proceso recursivo, calcule la demanda total sumando la
DEMANDA de todas las estaciones de la red. (1.5 p)

(defun estado_red (red_estacion)
    (if (consp red_estacion)
        (mapcar (lambda (x)
                (if (consp x)
                    (estado_estacion x)
                    nil
                )
        )red_estacion)

    )
)

(estado_red  '(
(E1 50 (200 220 240) 35)
(E2 80 (210 205 230) 40)
(E3 30 (200 250 240) 38)
(E3 30dw (dfw 250 wd) 3wf8)
))



(defun demanda_total (red_estacion)
(cond
    ((endp red_estacion) 0)
    ((numberp (cadr(car red_estacion)))(+ (cadr(car red_estacion))(demanda_total (cdr red_estacion))))
    (t (demanda_total (cdr red_estacion)))
))


5.- Desarrollar la función principal que solicite al operador el ingreso de la lista completa de la red,
realice las validaciones necesarias para el peor escenario posible, y muestre en pantalla:
● la lista de estados (punto 4),
● la demanda total (punto 4),
● y si existe en la red al menos una estación cuya tensión no sea segura. (2 p)

(defun ingreso_datos_red ()
  (let ((red_estacion nil)) ; Inicializamos la variable local
    
    (print "Ingrese la lista completa de la red de estaciones: ")
    (setq red_estacion (read))
    
    ;; COND plano para filtros de seguridad del peor escenario
    (cond 
      ;; Filtro 1: ¿No ingresó una lista?
      ((not (listp red_estacion))
       (print "ERROR: Los datos deben ser ingresados en una lista.") nil)
      
      ;; Filtro 2: ¿La lista vino vacía?
      ((endp red_estacion)
       (print "ERROR: La red no contiene ninguna estacion.") nil)
      
      ;; Caso por defecto: Los datos son válidos, procedemos al reporte
      (t 
       (progn
         (print "--- REPORTE DIARIO DE LA RED ---")
         
         (print "1. Lista de Estados por Estacion (MAPCAR):")
         (pprint (estado_red red_estacion))
         
         (print "2. Demanda Total de la Red (Recursivo):")
         ;; (Asumo que tu funcion demanda_total ya hace el + recursivo)
         (pprint (demanda_total red_estacion)) 
         
         (print "3. ¿Existe al menos una tension insegura en la red?:")
         (pprint (existe_tension_insegura-p red_estacion))

        (if (not (tensionnosegura red_estacion)
            'si existe una que no es es segura
            'no, no existe una no segura
        )


         t)))))


(defun existe_tension_insegura-p (red_estacion)
  (cond ((endp red) nil) ; Caso base: revisé toda la red y todas eran seguras
        
        ;; Si la estación de hoy NO tiene tensión segura, ¡Bingo! Devolvemos T
        ((not (tension_segura (car red_estacion))) t)
        
        ;; Si hoy está todo bien, pasamos a revisar el resto de la red
        (t (existe_tension_insegura-p (cdr red_estacion)))))


; otro ejemplo de busqueda completa:
(defun tensionnosegura (listaestacion)
	(cond((endp listaestacion)nil)
		((not(tensionsegura(car listaestacion)))t)
		(t(tensionnosegura(cdr listaestacion)))
	)
)