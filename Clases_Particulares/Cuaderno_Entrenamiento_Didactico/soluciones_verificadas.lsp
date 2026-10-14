;;; =============================================================================
;;; SOLUCIONES VERIFICADAS - CUADERNO DE ENTRENAMIENTO DIDACTICO
;;; Catedra de Paradigmas de Programacion - Funcional (LISP)
;;; =============================================================================

;; -----------------------------------------------------------------------------
;; MODULO 1: Accesores
;; -----------------------------------------------------------------------------
(defun obtener-mesa (p) (car p))
(defun obtener-mozo (p) (car (cadr p)))
(defun obtener-turno (p) (cadr (cadr p)))
(defun obtener-total (p) (cadddr p))
(defun obtener-estado (p) (car (cddddr p)))

;; -----------------------------------------------------------------------------
;; MODULO 2: Clasificador de Consumo
;; -----------------------------------------------------------------------------
(defun categorizar-consumo (monto)
    (cond
        ((not (numberp monto)) 'ERROR-DATO)
        ((< monto 2000)        'BASICO)
        ((<= monto 5000)       'REGULAR)
        (T                     'VIP)))

(defun clasificar-pedido-demo (precio minutos)
    (cond
        ((not (and (numberp precio) (numberp minutos))) 'DATOS-INVALIDOS)
        ((and (>= precio 3000) (<= minutos 5))          'PREMIUM-EXPRESS)
        ((>= precio 3000)                               'PREMIUM)
        ((<= minutos 5)                                 'EXPRESS)
        (T                                              'ESTANDAR)))

;; -----------------------------------------------------------------------------
;; MODULO 3: Recursion Basica
;; -----------------------------------------------------------------------------
(defun sumar-precios (lista)
    (cond
        ((null lista) 0)
        (T (+ (car lista) (sumar-precios (cdr lista))))))

(defun contar-caros (lista limite)
    (cond
        ((null lista) 0)
        ((> (car lista) limite)
            (+ 1 (contar-caros (cdr lista) limite)))
        (T
            (contar-caros (cdr lista) limite))))

(defun filtrar-para-llevar (pedidos)
    (cond
        ((null pedidos) nil)
        ((equal (caddr (car pedidos)) 'LLEVAR)
            (cons (car pedidos) 
                  (filtrar-para-llevar (cdr pedidos))))
        (T
            (filtrar-para-llevar (cdr pedidos)))))

(defun todas-libres-p (mesas)
    (cond
        ((null mesas) T)
        ((not (equal (car mesas) 'LIBRE)) nil)
        (T (todas-libres-p (cdr mesas)))))

;; -----------------------------------------------------------------------------
;; MODULO 4: MAPCAR
;; -----------------------------------------------------------------------------
(defun evaluar-tiempos-cocina (lista-pedidos)
    (mapcar (lambda (pedido)
                (cond
                    ((> (caddr pedido) 15)  'URGENTE)
                    ((>= (caddr pedido) 6)  'EN-HORA)
                    (T                      'A-TIEMPO)))
            lista-pedidos))

(defun aplicar-descuento-todos (lista porcentaje)
    (mapcar (lambda (precio) 
                (* precio (- 1 porcentaje)))
            lista))

;; -----------------------------------------------------------------------------
;; MODULO 6: Simulacro Integrador - Cafeteria "El Buen Grano"
;; Formato: (ID_PEDIDO (TIPO_GRANO TOSTADO) TAMANO PRECIO_BASE MINUTOS_ESPERA)
;; -----------------------------------------------------------------------------

;; Accesores
(defun obtener-grano (pedido)
    (car (cadr pedido)))

(defun obtener-tostado (pedido)
    (cadr (cadr pedido)))

(defun obtener-precio (pedido)
    (cadddr pedido))

(defun obtener-tiempo (pedido)
    (car (cddddr pedido)))

;; Predicado
(defun es-colombia-p (pedido)
    (equal (obtener-grano pedido) 'COLOMBIA))

;; Clasificador de espera con COND
(defun clasificar-espera (pedido)
    (cond
        ((<= (obtener-tiempo pedido) 5)  (list (car pedido) 'EXPRESS))
        ((<= (obtener-tiempo pedido) 12) (list (car pedido) 'NORMAL))
        (T                               (list (car pedido) 'DEMORADO))))

;; Informe masivo con MAPCAR
(defun informe-tiempos (lista-pedidos)
    (mapcar 'clasificar-espera lista-pedidos))

;; Recaudacion total con RECURSION pura
(defun recaudacion-total (lista-pedidos)
    (cond
        ((null lista-pedidos) 0)
        (T (+ (obtener-precio (car lista-pedidos))
              (recaudacion-total (cdr lista-pedidos))))))

;; Filtrar colombianos con RECURSION y CONS
(defun pedidos-colombianos (lista-pedidos)
    (cond
        ((null lista-pedidos) nil)
        ((es-colombia-p (car lista-pedidos))
            (cons (car lista-pedidos)
                  (pedidos-colombianos (cdr lista-pedidos))))
        (T
            (pedidos-colombianos (cdr lista-pedidos)))))

;; Contar demorados con RECURSION
(defun contar-demorados (lista-pedidos tiempo-limite)
    (cond
        ((null lista-pedidos) 0)
        ((> (obtener-tiempo (car lista-pedidos)) tiempo-limite)
            (+ 1 (contar-demorados (cdr lista-pedidos) tiempo-limite)))
        (T
            (contar-demorados (cdr lista-pedidos) tiempo-limite))))

;; Predicado universal con RECURSION (corte temprano)
(defun todos-express-p (lista-pedidos)
    (cond
        ((null lista-pedidos) T)
        ((> (obtener-tiempo (car lista-pedidos)) 5) nil)
        (T (todos-express-p (cdr lista-pedidos)))))

;; Descuento con MAPCAR y lambda
(defun aplicar-promo (lista-pedidos porcentaje)
    (mapcar (lambda (pedido)
                (* (obtener-precio pedido) (- 1 porcentaje)))
            lista-pedidos))

;; Menu principal
(defun menu-cafeteria ()
    (let ((pedidos nil) (tiempo-max nil))
        (print "=== SISTEMA DE GESTION CAFETERIA EL BUEN GRANO ===")
        (print "Ingrese la lista de pedidos: ")
        (setq pedidos (read))
        (print "Ingrese el tiempo maximo de espera aceptable (minutos): ")
        (setq tiempo-max (read))

        (if (and (consp pedidos) (numberp tiempo-max))
            (progn
                (print "--------------------------------------------------")
                (print "INFORME DE TIEMPOS DE ESPERA:")
                (print (informe-tiempos pedidos))

                (print "RECAUDACION TOTAL DEL DIA ($):")
                (print (recaudacion-total pedidos))

                (print "PEDIDOS DE CAFE COLOMBIANO:")
                (print (pedidos-colombianos pedidos))

                (print "CANTIDAD DE PEDIDOS DEMORADOS:")
                (print (contar-demorados pedidos tiempo-max))

                (print "TODOS LOS PEDIDOS FUERON EXPRESS? (T/NIL):")
                (print (todos-express-p pedidos))

                (print "PRECIOS CON 10% DE DESCUENTO:")
                (print (aplicar-promo pedidos 0.10))
                (print "--------------------------------------------------"))
            (print "ERROR: Los datos ingresados no son validos. Revise la lista y el numero."))))


;; =============================================================================
;; SUITE DE PRUEBAS AUTOMATIZADAS (TESTS)
;; =============================================================================
(defun ejecutar-tests ()
    (format t "~%>>> EJECUTANDO PRUEBAS DE VERIFICACION...~%")
    
    ;; Test Pedido individual
    (let ((p '(4 (JUAN TARDE) 3 4500 PAGADO)))
        (assert (= (obtener-mesa p) 4))
        (assert (equal (obtener-mozo p) 'JUAN))
        (assert (equal (obtener-turno p) 'TARDE))
        (assert (= (obtener-total p) 4500))
        (assert (equal (obtener-estado p) 'PAGADO)))

    ;; Test Modulo 2
    (assert (equal (categorizar-consumo 1500) 'BASICO))
    (assert (equal (categorizar-consumo 3500) 'REGULAR))
    (assert (equal (categorizar-consumo 6000) 'VIP))
    (assert (equal (clasificar-pedido-demo 3500 4) 'PREMIUM-EXPRESS))

    ;; Test Modulo 3
    (assert (= (sumar-precios '(1000 2000 1500)) 4500))
    (assert (= (contar-caros '(1000 3500 4200 1800) 3000) 2))
    (assert (equal (filtrar-para-llevar '((101 CAFE LLEVAR) (102 TE LOCAL) (103 SUB LLEVAR)))
                   '((101 CAFE LLEVAR) (103 SUB LLEVAR))))
    (assert (equal (todas-libres-p '(LIBRE LIBRE LIBRE)) T))
    (assert (equal (todas-libres-p '(LIBRE OCUPADA LIBRE)) NIL))

    ;; Test Modulo 4
    (assert (equal (evaluar-tiempos-cocina '((1 2500 4) (2 4200 18) (3 1500 12)))
                   '(A-TIEMPO URGENTE EN-HORA)))
    (assert (equal (aplicar-descuento-todos '(1000 2000) 0.10)
                   '(900.0 1800.0)))

    ;; Test Modulo 6 (Simulacro completo)
    (let ((pedidos '( (101 (COLOMBIA MEDIO) GRANDE 3500 4)
                      (102 (BRASIL FUERTE) CHICO 2800 14)
                      (103 (ETIOPIA SUAVE) MEDIANO 4200 8)
                      (104 (COLOMBIA FUERTE) MEDIANO 3800 16)
                      (105 (BRASIL MEDIO) GRANDE 3200 5) )))
        
        ;; Accesores
        (assert (equal (obtener-grano (car pedidos)) 'COLOMBIA))
        (assert (equal (obtener-tostado (car pedidos)) 'MEDIO))
        (assert (= (obtener-precio (car pedidos)) 3500))
        (assert (= (obtener-tiempo (car pedidos)) 4))
        
        ;; Predicado y clasificador
        (assert (equal (es-colombia-p (car pedidos)) T))
        (assert (equal (es-colombia-p (cadr pedidos)) NIL))
        (assert (equal (clasificar-espera (car pedidos)) '(101 EXPRESS)))
        (assert (equal (clasificar-espera (cadr pedidos)) '(102 DEMORADO)))
        (assert (equal (clasificar-espera (caddr pedidos)) '(103 NORMAL)))

        ;; Lista de pedidos
        (assert (equal (informe-tiempos pedidos)
                       '((101 EXPRESS) (102 DEMORADO) (103 NORMAL) (104 DEMORADO) (105 EXPRESS))))
        (assert (= (recaudacion-total pedidos) 17500))
        (assert (equal (pedidos-colombianos pedidos)
                       '((101 (COLOMBIA MEDIO) GRANDE 3500 4)
                         (104 (COLOMBIA FUERTE) MEDIANO 3800 16))))
        (assert (= (contar-demorados pedidos 10) 2))
        (assert (= (contar-demorados pedidos 5) 3))
        (assert (equal (todos-express-p pedidos) NIL))
        (assert (equal (todos-express-p '( (101 (COLOMBIA MEDIO) GRANDE 3500 4)
                                          (105 (BRASIL MEDIO) GRANDE 3200 5) )) T))
        (assert (equal (aplicar-promo pedidos 0.10)
                       '(3150.0 2520.0 3780.0 3420.0 2880.0))))

    (format t ">>> TODOS LOS TESTS PASARON EXITOSAMENTE! (100% OK)~%"))

;; Ejecutar tests al cargar el archivo
(ejecutar-tests)
