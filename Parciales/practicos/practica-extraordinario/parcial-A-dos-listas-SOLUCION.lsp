; =============================================================================
; PRÁCTICA EXTRAORDINARIO - MODELO A - SOLUCIÓN DE REFERENCIA
; PARADIGMAS Y LENGUAJES DE PROGRAMACIÓN - LENGUAJE LISP
; Tema: DOS LISTAS PARALELAS
; =============================================================================
;
; Estructura del dato: NO hay registros, son dos listas planas de enteros
; que se recorren EN PARALELO (la posición N de ambas es la misma hora).
;
;   lista-pm25 -> (40 55 30 60 45 70 20)
;   lista-co   -> (5  8  10 7  4  12 6)
;
; Una hora es CRITICA si  PM2.5 > 50  O  CO > 9.
;
; Resultados esperados con los datos de prueba:
;   combinar-lecturas   -> (0 1 1 1 0 1 0)
;   estado-jornada      -> (ACTIVAR PROTOCOLO)   ; hay 4 horas criticas
;   pico-pm25           -> 70
;   hay-co-peligroso-p  -> T
;   hora-pico           -> 6                      ; hora 6: 70+12 = 82 (el mayor)
;   promedio-pm25-criticas -> 53.75               ; (55+30+60+70)/4
;
; IDEA CLAVE DEL MODELO: para recorrer dos listas a la vez hay dos herramientas
;   - MAPCAR con dos listas:  (mapcar 'fn lista1 lista2)    -> punto 2
;   - RECURSION avanzando las dos con (cdr l1) y (cdr l2)    -> puntos 3, 6
; En la recursion el caso base se corta cuando CUALQUIERA de las dos se vacía,
; así nunca se hace (car) sobre NIL aunque tengan distinto largo.
; =============================================================================


; =============================================================================
; PUNTO 1 - lectura-critica-p   (PREDICADO sobre dos átomos)
; =============================================================================
; Recibe DOS valores sueltos (no listas). Devuelve T/NIL.
; Valida numberp: si llega basura (un símbolo, NIL) el AND corta y devuelve NIL.

(defun lectura-critica-p (pm co)
    (and (numberp pm)
         (numberp co)
         (or (> pm 50) (> co 9)))
)
; Pruebas:
; (lectura-critica-p 55 8)   -> T   (PM > 50)
; (lectura-critica-p 30 10)  -> T   (CO > 9)
; (lectura-critica-p 40 5)   -> NIL
; (lectura-critica-p 'X 5)   -> NIL (dato no numérico, no explota)


; =============================================================================
; PUNTO 2 - combinar-lecturas   (MAPCAR sobre DOS listas)
; =============================================================================
; MAPCAR toma un elemento de cada lista a la vez (p de pm25, c de co) y arma
; la lista de 1 y 0. Si las listas tienen distinto largo, MAPCAR se detiene
; en la más corta (comportamiento seguro, no explota).

(defun combinar-lecturas (pms cos)
    (mapcar (lambda (p c)
                (cond
                    ((lectura-critica-p p c) 1)
                    (T 0)))
            pms cos)
)
; Prueba:
; (combinar-lecturas '(40 55 30 60 45 70 20) '(5 8 10 7 4 12 6))
;   -> (0 1 1 1 0 1 0)


; =============================================================================
; PUNTO 3 - contar-criticas + estado-jornada   (RECURSIÓN sobre DOS listas)
; =============================================================================
; contar-criticas avanza las dos listas en paralelo con (cdr pms) y (cdr cos).
; El caso base corta si CUALQUIERA se vacía -> seguro ante largos distintos.

(defun contar-criticas (pms cos)
    (cond
        ((null pms) 0)
        ((null cos) 0)
        ((lectura-critica-p (car pms) (car cos))
            (+ 1 (contar-criticas (cdr pms) (cdr cos))))
        (T (contar-criticas (cdr pms) (cdr cos)))
    )
)

; estado-jornada decide con el conteo. Reutiliza la recursión de arriba.
(defun estado-jornada (pms cos)
    (cond
        ((>= (contar-criticas pms cos) 4) (list 'ACTIVAR 'PROTOCOLO))
        (T (list 'MONITOREO 'NORMAL))
    )
)
; Pruebas:
; (contar-criticas '(40 55 30 60 45 70 20) '(5 8 10 7 4 12 6))  -> 4
; (estado-jornada  '(40 55 30 60 45 70 20) '(5 8 10 7 4 12 6))  -> (ACTIVAR PROTOCOLO)


; =============================================================================
; PUNTO 4 - pico-pm25 (máximo)  y  hay-co-peligroso-p (al menos uno)
; =============================================================================

; --- 4a) pico-pm25: el valor más alto de la lista de PM2.5 ---
; Patrón "máximo con acumulador": una auxiliar lleva el mayor visto hasta ahora.
; Empieza en 0 porque las concentraciones nunca son negativas.
; Salta valores no numéricos (lista heterogénea) sin explotar.

(defun mayor-desde (lista tope)
    (cond
        ((null lista) tope)
        ((not (numberp (car lista))) (mayor-desde (cdr lista) tope))
        ((> (car lista) tope) (mayor-desde (cdr lista) (car lista)))
        (T (mayor-desde (cdr lista) tope))
    )
)

(defun pico-pm25 (pms)
    (mayor-desde pms 0)
)
; Prueba: (pico-pm25 '(40 55 30 60 45 70 20))  -> 70


; --- 4b) hay-co-peligroso-p: T si al menos un CO >= 9 (corte temprano) ---
; Patrón "existe": en cuanto encuentra uno devuelve T y deja de buscar.

(defun hay-co-peligroso-p (cos)
    (cond
        ((null cos) NIL)
        ((not (numberp (car cos))) (hay-co-peligroso-p (cdr cos)))
        ((>= (car cos) 9) T)
        (T (hay-co-peligroso-p (cdr cos)))
    )
)
; Pruebas:
; (hay-co-peligroso-p '(5 8 10 7))  -> T
; (hay-co-peligroso-p '(5 8 7 6))   -> NIL


; =============================================================================
; PUNTO 5 - informe-aire   (FUNCIÓN PRINCIPAL: leer + validar + integrar)
; =============================================================================
; Único lugar donde se usan variables locales (let): para guardar lo leído.
; Valida el PEOR ESCENARIO: que ambas entradas sean realmente listas.
; Un solo IF (válido / no válido); en la rama válida un PROGN encadena las
; impresiones. No se anida IF con COND.

(defun informe-aire ()
    (let (pms cos)
        (pprint "Ingrese la lista de PM2.5:")
        (setq pms (read))
        (pprint "Ingrese la lista de CO:")
        (setq cos (read))
        (if (and (listp pms) (listp cos))
            (progn
                (pprint (combinar-lecturas pms cos))
                (pprint (estado-jornada pms cos))
                (pprint (pico-pm25 pms))
                (pprint (hay-co-peligroso-p cos)))
            (pprint "Error: ambas entradas deben ser listas")
        )
    )
)


; =============================================================================
; PUNTO 6 - DESAFÍO
; =============================================================================

; --- 6a) hora-pico: posición (base 1) con mayor índice combinado PM2.5+CO ---
; Patrón "máximo con posición": la auxiliar recorre las dos listas en paralelo
; llevando la posición actual, la mejor posición y el mejor valor encontrados.
; (Se asume contenido numérico para el desafío.)

(defun indice-mayor (pms cos pos mejor-pos mejor-val)
    (cond
        ((null pms) mejor-pos)
        ((null cos) mejor-pos)
        ((> (+ (car pms) (car cos)) mejor-val)
            (indice-mayor (cdr pms) (cdr cos) (+ pos 1) pos (+ (car pms) (car cos))))
        (T (indice-mayor (cdr pms) (cdr cos) (+ pos 1) mejor-pos mejor-val))
    )
)

(defun hora-pico (pms cos)
    (cond
        ((null pms) NIL)
        ((null cos) NIL)
        (T (indice-mayor (cdr pms) (cdr cos) 2 1 (+ (car pms) (car cos))))
    )
)
; Prueba: (hora-pico '(40 55 30 60 45 70 20) '(5 8 10 7 4 12 6))  -> 6


; --- 6b) promedio-pm25-criticas: promedio de PM2.5 solo en horas críticas ---
; Patrón "promedio": se necesitan SUMA y CONTEO por separado (sin variables).
; Reutiliza contar-criticas (Punto 3) para el divisor.

(defun suma-pm-criticas (pms cos)
    (cond
        ((null pms) 0)
        ((null cos) 0)
        ((lectura-critica-p (car pms) (car cos))
            (+ (car pms) (suma-pm-criticas (cdr pms) (cdr cos))))
        (T (suma-pm-criticas (cdr pms) (cdr cos)))
    )
)

(defun promedio-pm25-criticas (pms cos)
    (cond
        ((= (contar-criticas pms cos) 0) 0)
        (T (/ (suma-pm-criticas pms cos) (contar-criticas pms cos)))
    )
)
; Prueba: (promedio-pm25-criticas '(40 55 30 60 45 70 20) '(5 8 10 7 4 12 6))
;   -> 53.75   ; (55+30+60+70)/4
