;; ====================================================================
;; PARADIGMAS Y LENGUAJES DE PROGRAMACION - UNIVERSIDAD NACIONAL DEL NORDESTE
;; LENGUAJE LISP - Trabajo Práctico N°4 (Año: 2.026)
;; ====================================================================

;; --------------------------------------------------------------------
;; Actividad N° 1: Predicado Aprobado
;; --------------------------------------------------------------------

(defun Aprobado (notas)

    (cond
        ((null notas) T)
        ((not (numberp (car notas))) NIL)
        ((< (car notas) 4) NIL)
        (T (Aprobado (cdr notas)))
    )
)

(defun ingresar-notas ()

    (let (notas)
        (pprint "Ingrese la lista de notas del alumno:")
        (setq notas (read))

        (Aprobado notas)
    )
)
;; Prueba: (Aprobado '(4 5 6))  ; => T
;; Prueba: (Aprobado '(3 5 6))  ; => NIL


;; --------------------------------------------------------------------
;; Actividad N° 2: Lista heterogénea - sublistas
;; --------------------------------------------------------------------

;; a. Sublistas de la lista original junto con su longitud
;; (usa CONSP en vez de LISTP para no tratar NIL como si fuera una sublista)
(defun sublistas-con-longitud (lista)

    (cond
        ((null lista) nil)
        ((consp (car lista)) (cons (list (car lista) (length (car lista))) (sublistas-con-longitud (cdr lista))))
        (T (sublistas-con-longitud (cdr lista)))
    )
)
;; Prueba: (sublistas-con-longitud '(1 (2 3) A (4 5 6) "x"))  ; => (((2 3) 2) ((4 5 6) 3))

;; b. Evaluar si cada elemento es o no una sublista
(defun evaluar-si-es-sublista (lista)

    (cond
        ((null lista) nil)
        (T (cons (consp (car lista)) (evaluar-si-es-sublista (cdr lista))))
    )
)
;; Prueba: (evaluar-si-es-sublista '(1 (2 3) A))  ; => (NIL T NIL)

(defun ingresar-lista-heterogenea-act2 ()

    (let (lista)
        (pprint "Ingrese la lista heterogenea:")
        (setq lista (read))

        (list (sublistas-con-longitud lista) (evaluar-si-es-sublista lista))
    )
)


;; --------------------------------------------------------------------
;; Actividad N° 3: Diferencia de dos listas, elemento a elemento
;; --------------------------------------------------------------------

(defun diferencia-listas (lista1 lista2)

    (cond
        ((null lista1) nil)
        ((null lista2) nil)
        (T (cons (- (car lista1) (car lista2)) (diferencia-listas (cdr lista1) (cdr lista2))))
    )
)
;; Prueba: (diferencia-listas '(10 20 30) '(1 2 3))  ; => (9 18 27)

(defun ingresar-dos-listas ()

    (let (lista1 lista2)
        (pprint "Ingrese la primera lista de numeros:")
        (setq lista1 (read))
        (pprint "Ingrese la segunda lista de numeros:")
        (setq lista2 (read))

        (diferencia-listas lista1 lista2)
    )
)


;; --------------------------------------------------------------------
;; Actividad N° 4: Separar pares e impares
;; --------------------------------------------------------------------

(defun pares (lista)

    (cond
        ((null lista) nil)
        ((and (numberp (car lista)) (evenp (car lista))) (cons (car lista) (pares (cdr lista))))
        (T (pares (cdr lista)))
    )
)

(defun impares (lista)

    (cond
        ((null lista) nil)
        ((and (numberp (car lista)) (oddp (car lista))) (cons (car lista) (impares (cdr lista))))
        (T (impares (cdr lista)))
    )
)

;; Reutiliza PARES e IMPARES en vez de recorrer la lista de nuevo
(defun separar-pares-impares (lista)

    (list (pares lista) (impares lista))
)
;; Prueba: (separar-pares-impares '(1 2 3 4 5 6))  ; => ((2 4 6) (1 3 5))

(defun ingresar-lista-numeros ()

    (let (lista)
        (pprint "Ingrese la lista de numeros:")
        (setq lista (read))

        (separar-pares-impares lista)
    )
)


;; --------------------------------------------------------------------
;; Actividad N° 5: Temperaturas máximas de enero
;; --------------------------------------------------------------------

(defun suma-lista (lista)

    (cond
        ((null lista) 0)
        (T (+ (car lista) (suma-lista (cdr lista))))
    )
)

(defun cantidad-menores-a (lista umbral)

    (cond
        ((null lista) 0)
        ((< (car lista) umbral) (+ 1 (cantidad-menores-a (cdr lista) umbral)))
        (T (cantidad-menores-a (cdr lista) umbral))
    )
)
;; Prueba: (cantidad-menores-a '(30 40 35 20) 38)  ; => 3

;; Reutiliza SUMA-LISTA
(defun promedio-temperaturas (lista)

    (/ (suma-lista lista) (length lista))
)
;; Prueba: (promedio-temperaturas '(30 32 34))  ; => 32

(defun ascendente-p (lista)

    (cond
        ((null lista) T)
        ((null (cdr lista)) T)
        ((> (car lista) (cadr lista)) NIL)
        (T (ascendente-p (cdr lista)))
    )
)
;; Prueba: (ascendente-p '(30 31 32))  ; => T
;; Prueba: (ascendente-p '(30 29 32))  ; => NIL

(defun pertenece-p (elemento lista)

    (cond
        ((null lista) NIL)
        ((equal elemento (car lista)) T)
        (T (pertenece-p elemento (cdr lista)))
    )
)

;; Reutiliza PERTENECE-P: si el elemento vuelve a aparecer mas adelante,
;; se descarta esta aparicion (va a quedar la ultima)
(defun sin-repetidos (lista)

    (cond
        ((null lista) nil)
        ((pertenece-p (car lista) (cdr lista)) (sin-repetidos (cdr lista)))
        (T (cons (car lista) (sin-repetidos (cdr lista))))
    )
)
;; Prueba: (sin-repetidos '(1 2 2 3 1))  ; => (2 3 1)

(defun ingresar-temperaturas ()

    (let (temperaturas)
        (pprint "Ingrese la lista de temperaturas maximas de enero:")
        (setq temperaturas (read))

        (list (cantidad-menores-a temperaturas 38)
              (promedio-temperaturas temperaturas)
              (ascendente-p temperaturas)
              (sin-repetidos temperaturas))
    )
)


;; --------------------------------------------------------------------
;; Actividad N° 6: Lista heterogénea + valor atómico
;; --------------------------------------------------------------------

;; 1. Predicado: la lista contiene unicamente valores atomicos
(defun solo-atomos-p (lista)

    (cond
        ((null lista) T)
        ((consp (car lista)) NIL)
        (T (solo-atomos-p (cdr lista)))
    )
)
;; Prueba: (solo-atomos-p '(1 2 3))    ; => T
;; Prueba: (solo-atomos-p '(1 (2) 3))  ; => NIL

;; 2. Cantidad de valores <= al valor atomico
(defun cantidad-menores-o-iguales (lista valor)

    (cond
        ((null lista) 0)
        ((and (numberp (car lista)) (<= (car lista) valor)) (+ 1 (cantidad-menores-o-iguales (cdr lista) valor)))
        (T (cantidad-menores-o-iguales (cdr lista) valor))
    )
)
;; Prueba: (cantidad-menores-o-iguales '(1 5 10 3) 5)  ; => 3

;; 3. Sublistas (elemento division) para los elementos mayores a cero
(defun dividir-mayores-a-cero (lista valor)

    (cond
        ((null lista) nil)
        ((and (numberp (car lista)) (> (car lista) 0)) (cons (list (car lista) (/ (car lista) valor)) (dividir-mayores-a-cero (cdr lista) valor)))
        (T (dividir-mayores-a-cero (cdr lista) valor))
    )
)
;; Prueba: (dividir-mayores-a-cero '(10 -5 20 0) 5)  ; => ((10 2) (20 4))

(defun ingresar-lista-y-valor ()

    (let (lista valor)
        (pprint "Ingrese la lista heterogenea:")
        (setq lista (read))
        (pprint "Ingrese el valor atomico:")
        (setq valor (read))

        (list (solo-atomos-p lista)
              (cantidad-menores-o-iguales lista valor)
              (dividir-mayores-a-cero lista valor))
    )
)


;; Nota: de aca en adelante hay que evaluar si conviene una funcion simple
;; o un proceso recursivo, segun lo que pide cada actividad.

;; --------------------------------------------------------------------
;; Actividad N° 7: FunTel - historial de llamadas
;; --------------------------------------------------------------------

;; Reutiliza SUMA-LISTA (Actividad 5)
(defun cuandoHabloMas (historial)

    (cond
        ((= (suma-lista (car historial)) (suma-lista (cadr historial))) 'IGUAL)
        ((> (suma-lista (car historial)) (suma-lista (cadr historial))) 'NORMAL)
        (T 'REDUCIDO)
    )
)
;; Prueba: (cuandoHabloMas '((10 20 5) (30 15)))  ; => REDUCIDO

(defun maximo-lista (lista)

    (cond
        ((null (cdr lista)) (car lista))
        ((> (car lista) (maximo-lista (cdr lista))) (car lista))
        (T (maximo-lista (cdr lista)))
    )
)

(defun minimo-lista (lista)

    (cond
        ((null (cdr lista)) (car lista))
        ((< (car lista) (minimo-lista (cdr lista))) (car lista))
        (T (minimo-lista (cdr lista)))
    )
)

;; Reutiliza MAXIMO-LISTA
(defun LlamadaMasLarga (historial)

    (cond
        ((>= (maximo-lista (car historial)) (maximo-lista (cadr historial))) (list (maximo-lista (car historial)) 'NORMAL))
        (T (list (maximo-lista (cadr historial)) 'REDUCIDO))
    )
)
;; Prueba: (LlamadaMasLarga '((10 20 5) (30 15)))  ; => (30 REDUCIDO)

;; Reutiliza MINIMO-LISTA
(defun LlamadaMasCorta (historial)

    (cond
        ((<= (minimo-lista (car historial)) (minimo-lista (cadr historial))) (list (minimo-lista (car historial)) 'NORMAL))
        (T (list (minimo-lista (cadr historial)) 'REDUCIDO))
    )
)
;; Prueba: (LlamadaMasCorta '((10 20 5) (30 15)))  ; => (5 NORMAL)

(defun ingresar-historial-llamadas ()

    (let (historial)
        (pprint "Ingrese la lista con las dos sublistas de duraciones (horario normal y horario reducido):")
        (setq historial (read))

        (list (cuandoHabloMas historial)
              (LlamadaMasLarga historial)
              (LlamadaMasCorta historial))
    )
)


;; --------------------------------------------------------------------
;; Actividad N° 8: Archivos gráficos y de texto
;; --------------------------------------------------------------------

(defun primero-igual-ultimo-p (lista)

    (= (car lista) (car (last lista)))
)
;; Prueba: (primero-igual-ultimo-p '(100 200 300))  ; => NIL

;; Reutiliza SUMA-LISTA (Actividad 5)
(defun graficos-ocupan-mas-p (arch-graficos arch-texto)

    (> (suma-lista arch-graficos) (suma-lista arch-texto))
)
;; Prueba: (graficos-ocupan-mas-p '(100 200 300) '(50 60 900))  ; => NIL

(defun sumas-mayores-a (lista1 lista2 limite)

    (cond
        ((null lista1) nil)
        ((null lista2) nil)
        ((> (+ (car lista1) (car lista2)) limite) (cons (+ (car lista1) (car lista2)) (sumas-mayores-a (cdr lista1) (cdr lista2) limite)))
        (T (sumas-mayores-a (cdr lista1) (cdr lista2) limite))
    )
)
;; Prueba: (sumas-mayores-a '(100 200 300) '(50 60 900) 150)  ; => (260 1200)

(defun ingresar-archivos ()

    (let (arch-graficos arch-texto limite)
        (pprint "Ingrese la lista de tamanios de archivos graficos:")
        (setq arch-graficos (read))
        (pprint "Ingrese la lista de tamanios de archivos de texto:")
        (setq arch-texto (read))
        (pprint "Ingrese el valor minimo a considerar para las sumas:")
        (setq limite (read))

        (list (primero-igual-ultimo-p arch-graficos)
              (graficos-ocupan-mas-p arch-graficos arch-texto)
              (sumas-mayores-a arch-graficos arch-texto limite))
    )
)


;; --------------------------------------------------------------------
;; Actividad N° 9: Sensores - primerDesbalance, sonIgualesHasta, prefijoComun
;; --------------------------------------------------------------------

;; Corte temprano: apenas difieren, deja de recorrer el resto de las listas
(defun primerDesbalance-desde (lista1 lista2 posicion)

    (cond
        ((null lista1) NIL)
        ((null lista2) NIL)
        ((not (= (car lista1) (car lista2))) posicion)
        (T (primerDesbalance-desde (cdr lista1) (cdr lista2) (1+ posicion)))
    )
)

(defun primerDesbalance (sensores)

    (primerDesbalance-desde (car sensores) (cadr sensores) 0)
)
;; Prueba: (primerDesbalance '((10 20 30 40) (10 20 25 40)))  ; => 2

(defun igualesHastaN (lista1 lista2 n)

    (cond
        ((or (< n 0)(null lista1)(null lista2)) T)
        ((not (= (car lista1) (car lista2))) NIL)
        (T (igualesHastaN (cdr lista1) (cdr lista2) (1- n)))
    )
)

(defun sonIgualesHasta (sensores n)

    (igualesHastaN (car sensores) (cadr sensores) n)
)
;; Prueba: (sonIgualesHasta '((10 20 30 40) (10 20 25 40)) 1)  ; => T (posiciones 0 y 1 coinciden)
;; Prueba: (sonIgualesHasta '((10 20 30 40) (10 20 25 40)) 2)  ; => NIL (la posicion 2 ya difiere)

(defun prefijoComunListas (lista1 lista2)

    (cond
        ((null lista1) nil)
        ((null lista2) nil)
        ((not (= (car lista1) (car lista2))) nil)
        (T (cons (car lista1) (prefijoComunListas (cdr lista1) (cdr lista2))))
    )
)

(defun prefijoComun (sensores)

    (prefijoComunListas (car sensores) (cadr sensores))
)
;; Prueba: (prefijoComun '((10 20 30 40) (10 20 25 40)))  ; => (10 20)

(defun ingresar-sensores ()

    (let (sensores n)
        (pprint "Ingrese la estructura con las dos listas de mediciones de los sensores:")
        (setq sensores (read))
        (pprint "Ingrese la posicion N hasta la cual verificar igualdad:")
        (setq n (read))

        (list (primerDesbalance sensores)
              (sonIgualesHasta sensores n)
              (prefijoComun sensores))
    )
)
