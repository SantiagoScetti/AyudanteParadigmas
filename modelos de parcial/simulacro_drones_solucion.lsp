; SIMULACRO DE PARCIAL - SOLUCIÓN DE REFERENCIA
; PARADIGMAS Y LENGUAJES DE PROGRAMACIÓN - LENGUAJE LISP

; Estructura del dato de cada dron:
; (ID_DRON  CARGA  (BATERIA_ACTUAL  BATERIA_MIN  BATERIA_MAX)  AUTONOMIA)
;
; Acceso a los campos:
;   (car dron)              -> ID_DRON
;   (cadr dron)             -> CARGA
;   (caddr dron)            -> (BATERIA_ACTUAL BATERIA_MIN BATERIA_MAX)
;   (cadddr dron)           -> AUTONOMIA
;   (caaddr dron)           -> BATERIA_ACTUAL  [car de la sublista = car del tercer elemento]
;   (cadr (caddr dron))     -> BATERIA_MIN     [cadr de la sublista]
;   (caddr (caddr dron))    -> BATERIA_MAX     [caddr de la sublista]
;
; Datos de prueba:
;   (D001 12.5 (78 20 90) 150)   -> LISTO,     distancia: 117 km
;   (D002 8.0  (15 20 90) 200)   -> CRITICO,   distancia: 30 km
;   (D003 20.0 (95 20 90) 180)   -> SOBRECARGA,distancia: 171 km
;
; Lista de prueba para punto 4:
; ((D001 12.5 (78 20 90) 150) (D002 8.0 (15 20 90) 200) (D003 20.0 (95 20 90) 180))

; =============================================================================
; PUNTO 1 - distancia-real
; =============================================================================
; Calcula: AUTONOMIA * (BATERIA_ACTUAL / 100)
; Accede al último elemento (cadddr) y al primer elemento de la sublista (caaddr)

(defun distancia-real (dron)
    (* (cadddr dron) (/ (caaddr dron) 100.0))
)

; Prueba: (distancia-real '(D001 12.5 (78 20 90) 150))  -> 117.0

; =============================================================================
; PUNTO 2 - bateria-segura-p (predicado)
; =============================================================================
; Verifica: BATERIA_ACTUAL >= BATERIA_MIN  Y  BATERIA_ACTUAL <= BATERIA_MAX
; Nota: la sublista tiene orden (ACTUAL MIN MAX), distinto al parcial anterior.
; El alumno debe identificar correctamente la posición de cada valor.

(defun bateria-segura-p (dron)
    (and (>= (caaddr dron) (cadr (caddr dron)))
         (<= (caaddr dron) (caddr (caddr dron))))
)
; Pruebas:
; (bateria-segura-p '(D001 12.5 (78 20 90) 150))  -> T
; (bateria-segura-p '(D002 8.0  (15 20 90) 200))  -> NIL  (CRITICO)
; (bateria-segura-p '(D003 20.0 (95 20 90) 180))  -> NIL  (SOBRECARGA)

; =============================================================================
; PUNTO 3 - estado-dron
; =============================================================================
; CLAVE: el alumno debe razonar que el caso LISTO ya fue resuelto en el Punto 2.
; Reutilizar bateria-segura-p evita duplicar lógica y es la solución esperada.

(defun estado-dron (dron)
    (cond
        ((bateria-segura-p dron)                  (list (car dron) 'LISTO))
        ((< (caaddr dron) (cadr (caddr dron)))     (list (car dron) 'CRITICO))
        (T                                         (list (car dron) 'SOBRECARGA))
    )
)

; Pruebas:
; (estado-dron '(D001 12.5 (78 20 90) 150))  -> (D001 LISTO)
; (estado-dron '(D002 8.0  (15 20 90) 200))  -> (D002 CRITICO)
; (estado-dron '(D003 20.0 (95 20 90) 180))  -> (D003 SOBRECARGA)

; =============================================================================
; PUNTO 4 - funciones auxiliares y función principal
; =============================================================================

; 4a) Lista de estados con MAPCAR
; Aplica estado-dron a cada dron de la flota

(defun lista-estados (flota)
    (mapcar 'estado-dron flota)
)
; Alternativa con lambda:
; (defun lista-estados (flota)
;     (mapcar (lambda (x) (estado-dron x)) flota)
; )

; 4b) Distancia total (proceso recursivo)
; Suma la distancia-real de cada dron; valida con consp para listas heterogéneas

(defun distancia-total (flota)
    (cond
        ((null flota) 0)
        ((consp (car flota)) (+ (distancia-real (car flota)) (distancia-total (cdr flota))))
        (T (distancia-total (cdr flota)))
    )
)

; 4c) Al menos un dron fuera del rango seguro
; CLAVE: el enunciado NO dice "usar recursión" pero es la única forma de recorrer la lista.
; El alumno debe inferirlo. Usa bateria-segura-p (Punto 2) sobre cada elemento.

(defun hay-inseguro-p (flota)
    (cond
        ((null flota) NIL)
        ((not (bateria-segura-p (car flota))) T)
        (T (hay-inseguro-p (cdr flota)))
    )
)

; Función principal que integra todo
; Valida con listp y usa progn para ejecutar los tres reportes en la rama verdadera
(defun informe-flota ()
    (let (flota)
        (pprint "Ingrese la lista completa de la flota:")
        (setq flota (read))
        (if (listp flota)
            (progn
                (pprint (lista-estados flota))
                (pprint (distancia-total flota))
                (pprint (hay-inseguro-p flota))
            )
            (pprint "Error: debe ingresar una lista valida")
        )
    )
)

; =============================================================================
; PUNTO 5 - DESAFÍO
; =============================================================================

; --- 5a) Dron con mayor alcance real ---
; Recursión por comparación: elimina el dron con menor distancia hasta quedar uno.
; El alumno debe razonar la estrategia sin que se la den servida.
;
; La validación del caso base (único elemento) requiere chequear consp.
; Como no se puede anidar IF dentro de COND, se extrae en función auxiliar.

(defun extraer-id (dron)
    (cond
        ((consp dron) (car dron))
        (T NIL)
    )
)

(defun max-alcance (flota)
    (cond
        ((null flota) NIL)                                                              ; Lista vacía → no hay nada que comparar, devuelvo NIL
        ((null (cdr flota))              (extraer-id (car flota)))                      ; Solo queda UN elemento → ese es el ganador, extraigo su ID
        ((not (consp (car flota)))       (max-alcance (cdr flota)))                     ; El PRIMER elemento no es una sublista válida (dato basura) → lo ignoro y avanzo
        ((not (consp (cadr flota)))      (max-alcance (cons (car flota) (cddr flota)))) ; El SEGUNDO elemento no es válido → lo salto, pero conservo el primero para comparar con el tercero
        ((>= (distancia-real (car flota)) (distancia-real (cadr flota))) ; El primero llega MÁS LEJOS que el segundo → el segundo pierde: lo elimino y repito
            (max-alcance (cons (car flota) (cddr flota))))         ; cons arma una nueva lista: (primero tercero cuarto ...)
        (T (max-alcance (cdr flota)))         ; El segundo llega más lejos → el primero pierde: simplemente avanzo con cdr
    )
)

; Prueba con lista de prueba -> D003 (171 km)

; --- 5b) Promedio de batería ---
; Sin variables locales en las funciones auxiliares: se requieren dos helpers recursivos.
; El alumno debe descubrir que necesita suma Y conteo por separado.

(defun suma-baterias (flota)
    (cond
        ((null flota) 0)
        ((consp (car flota)) (+ (caaddr (car flota)) (suma-baterias (cdr flota))))
        (T (suma-baterias (cdr flota)))
    )
)

(defun contar-drones (flota)
    (cond
        ((null flota) 0)
        ((consp (car flota)) (+ 1 (contar-drones (cdr flota))))
        (T (contar-drones (cdr flota)))
    )
)

(defun promedio-bateria (flota)
    (cond
        ((null flota) 0)
        (T (/ (suma-baterias flota) (contar-drones flota)))
    )
)

; Prueba con lista de prueba -> (78 + 15 + 95) / 3 = 62.666...

; --- 5c) Distribución de estados ---
; Recibe la lista generada en 4a -> lista de pares (ID ESTADO)
; Requiere tres funciones contadoras o una sola con tres condiciones.

(defun contar-criticos (estados)
    (cond
        ((null estados) 0)
        ((eq (cadr (car estados)) 'CRITICO) (+ 1 (contar-criticos (cdr estados))))
        (T (contar-criticos (cdr estados)))
    )
)

(defun contar-listos (estados)
    (cond
        ((null estados) 0)
        ((eq (cadr (car estados)) 'LISTO) (+ 1 (contar-listos (cdr estados))))
        (T (contar-listos (cdr estados)))
    )
)

(defun contar-sobrecarga (estados)
    (cond
        ((null estados) 0)
        ((eq (cadr (car estados)) 'SOBRECARGA) (+ 1 (contar-sobrecarga (cdr estados))))
        (T (contar-sobrecarga (cdr estados)))
    )
)

(defun distribucion-estados (estados)
    (list 'CRITICOS    (contar-criticos estados)
          'LISTOS       (contar-listos estados)
          'SOBRECARGA   (contar-sobrecarga estados))
)

; Prueba con ((D001 LISTO) (D002 CRITICO) (D003 SOBRECARGA))
; -> (CRITICOS 1  LISTOS 1  SOBRECARGA 1)
;(distribucion-estados (lista-estados flota))