; =============================================================================
; PRÁCTICA EXTRAORDINARIO - MODELO B - SOLUCIÓN DE REFERENCIA
; PARADIGMAS Y LENGUAJES DE PROGRAMACIÓN - LENGUAJE LISP
; Tema: REGISTRO CON SUBLISTA ANIDADA y LISTA DE REGISTROS
; =============================================================================
;
; Estructura del dato de cada estación:
; (ID_ESTACION  DEMANDA  (TENSION_MIN  TENSION_ACTUAL  TENSION_MAX)  TARIFA)
;
; ¡OJO! El valor actual está EN EL MEDIO de la sublista (MIN ACTUAL MAX).
; Hay que deducir cada acceso, no copiarlo de otro parcial.
;
; Acceso a los campos de UNA estación (la llamamos 'est'):
;   (car est)              -> ID_ESTACION
;   (cadr est)             -> DEMANDA
;   (caddr est)            -> (TENSION_MIN TENSION_ACTUAL TENSION_MAX)   sublista
;   (cadddr est)           -> TARIFA
;   (car   (caddr est))    -> TENSION_MIN     (1er elemento de la sublista)
;   (cadr  (caddr est))    -> TENSION_ACTUAL  (2do elemento -> el del medio)
;   (caddr (caddr est))    -> TENSION_MAX     (3er elemento de la sublista)
;
; Datos de prueba:
;   (E1 50 (200 220 240) 35)  -> ESTABLE (220 entre 200 y 240)
;   (E2 80 (210 205 230) 40)  -> BAJA    (205 < 210)
;   (E3 30 (200 250 240) 38)  -> ALTA    (250 > 240)
;
; Lista de prueba para el punto 4:
; ((E1 50 (200 220 240) 35) (E2 80 (210 205 230) 40) (E3 30 (200 250 240) 38))
;
; Resultados esperados:
;   costo-actual de E1   -> 1750        (50 * 35)
;   lista-estados        -> ((E1 ESTABLE) (E2 BAJA) (E3 ALTA))
;   demanda-total        -> 160         (50 + 80 + 30)
;   hay-inestable-p      -> T
;   estacion-mayor-demanda -> E2        (80 kW)
;   resumen-estados      -> (BAJAS 1 ESTABLES 1 ALTAS 1)
; =============================================================================


; =============================================================================
; PUNTO 1 - costo-actual   (fórmula + acceso a campos)
; =============================================================================
; Necesita DEMANDA (cadr) y TARIFA (cadddr), que están en posiciones distintas.

(defun costo-actual (est)
    (* (cadr est) (cadddr est))
)
; Prueba: (costo-actual '(E1 50 (200 220 240) 35))  -> 1750


; =============================================================================
; PUNTO 2 - tension-estable-p   (PREDICADO, acceso a sublista anidada)
; =============================================================================
; ACTUAL (el del medio) tiene que ser >= MIN y <= MAX. Devuelve T/NIL.

(defun tension-estable-p (est)
    (and (>= (cadr (caddr est)) (car (caddr est)))
         (<= (cadr (caddr est)) (caddr (caddr est))))
)
; Pruebas:
; (tension-estable-p '(E1 50 (200 220 240) 35))  -> T
; (tension-estable-p '(E2 80 (210 205 230) 40))  -> NIL   (BAJA)
; (tension-estable-p '(E3 30 (200 250 240) 38))  -> NIL   (ALTA)


; =============================================================================
; PUNTO 3 - estado-estacion   (COND reutilizando el predicado)
; =============================================================================
; CLAVE: el caso ESTABLE ya está resuelto en el Punto 2. Reutilizar evita
; duplicar lógica y es la solución esperada. La primera rama que da T gana.

(defun estado-estacion (est)
    (cond
        ((tension-estable-p est)                       (list (car est) 'ESTABLE))
        ((< (cadr (caddr est)) (car (caddr est)))       (list (car est) 'BAJA))
        (T                                              (list (car est) 'ALTA))
    )
)
; Pruebas:
; (estado-estacion '(E1 50 (200 220 240) 35))  -> (E1 ESTABLE)
; (estado-estacion '(E2 80 (210 205 230) 40))  -> (E2 BAJA)
; (estado-estacion '(E3 30 (200 250 240) 38))  -> (E3 ALTA)


; =============================================================================
; PUNTO 4 - lista-estados (MAPCAR)  y  demanda-total (RECURSIÓN)
; =============================================================================

; --- 4a) lista-estados: aplica estado-estacion a cada estación con MAPCAR ---
; 'estado-estacion y #'estado-estacion funcionan igual; usamos el quote simple
; como en la solución de drones de la cátedra.
(defun lista-estados (red)
    (mapcar 'estado-estacion red)
)
; Prueba:
; (lista-estados '((E1 50 (200 220 240) 35) (E2 80 (210 205 230) 40) (E3 30 (200 250 240) 38)))
;   -> ((E1 ESTABLE) (E2 BAJA) (E3 ALTA))

; --- 4b) demanda-total: suma recursiva de la DEMANDA de cada estación ---
; Valida con consp para saltar elementos que no sean sublistas (heterogéneas).
(defun demanda-total (red)
    (cond
        ((null red) 0)
        ((consp (car red)) (+ (cadr (car red)) (demanda-total (cdr red))))
        (T (demanda-total (cdr red)))
    )
)
; Prueba: (demanda-total '((E1 50 (200 220 240) 35) (E2 80 (210 205 230) 40) (E3 30 (200 250 240) 38)))
;   -> 160


; =============================================================================
; PUNTO 5 - hay-inestable-p  +  informe-red (FUNCIÓN PRINCIPAL)
; =============================================================================

; --- hay-inestable-p: T si al menos una estación NO es segura (corte temprano) ---
(defun hay-inestable-p (red)
    (cond
        ((null red) NIL)
        ((not (consp (car red))) (hay-inestable-p (cdr red)))
        ((not (tension-estable-p (car red))) T)
        (T (hay-inestable-p (cdr red)))
    )
)

; --- informe-red: leer + validar peor escenario + integrar ---
; let solo acá, para guardar lo leído. Un IF (lista / no lista) con PROGN.
(defun informe-red ()
    (let (red)
        (pprint "Ingrese la lista completa de la red:")
        (setq red (read))
        (if (listp red)
            (progn
                (pprint (lista-estados red))
                (pprint (demanda-total red))
                (pprint (hay-inestable-p red)))
            (pprint "Error: debe ingresar una lista")
        )
    )
)


; =============================================================================
; PUNTO 6 - DESAFÍO
; =============================================================================

; --- 6a) estacion-mayor-demanda: ID de la estación con mayor DEMANDA ---
; "máximo de registros con acumulador": una auxiliar lleva la MEJOR estación
; vista hasta ahora (su registro completo). Al final, se extrae su ID.
; extraer-id evita anidar un IF dentro del COND (regla de estilo).

(defun mejor-estacion (red mejor)
    (cond
        ((null red) mejor)
        ((not (consp (car red))) (mejor-estacion (cdr red) mejor))
        ((null mejor) (mejor-estacion (cdr red) (car red)))
        ((> (cadr (car red)) (cadr mejor)) (mejor-estacion (cdr red) (car red)))
        (T (mejor-estacion (cdr red) mejor))
    )
)

(defun extraer-id (est)
    (cond
        ((consp est) (car est))
        (T NIL)
    )
)

(defun estacion-mayor-demanda (red)
    (extraer-id (mejor-estacion red nil))
)
; Prueba: (estacion-mayor-demanda '((E1 50 (200 220 240) 35) (E2 80 (210 205 230) 40) (E3 30 (200 250 240) 38)))
;   -> E2


; --- 6b) resumen-estados: distribución sobre la lista de pares (ID ESTADO) ---
; Una sola contadora PARAMETRIZADA por la etiqueta buscada. Más limpio que
; escribir tres contadoras casi iguales.

(defun contar-estado (pares etiqueta)
    (cond
        ((null pares) 0)
        ((eq (cadr (car pares)) etiqueta) (+ 1 (contar-estado (cdr pares) etiqueta)))
        (T (contar-estado (cdr pares) etiqueta))
    )
)

(defun resumen-estados (pares)
    (list 'BAJAS    (contar-estado pares 'BAJA)
          'ESTABLES (contar-estado pares 'ESTABLE)
          'ALTAS    (contar-estado pares 'ALTA))
)
; Prueba: (resumen-estados '((E1 ESTABLE) (E2 BAJA) (E3 ALTA)))
;   -> (BAJAS 1 ESTABLES 1 ALTAS 1)
