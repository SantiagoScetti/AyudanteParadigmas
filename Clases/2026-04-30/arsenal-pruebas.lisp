; Actividad N° 3: Diferencia de Listas
(diferencia-listas '(10 20) '(5 5))         ; Ideal: (5 15)
(diferencia-listas '(10 20) '(5))           ; no validó largos distintos. Da error de cdr
(diferencia-listas '(10 A) '(5 5))          ; No validó numberp. Explota la resta

;Actividad N° 4: Separar Pares e Impares
(separar-pares-impares '(1 2 3 4 5))        ; Ideal: ((2 4) (1 3 5))
(separar-pares-impares '())                 ; error por no contemplar la lista vacía de entrada
(separar-pares-impares '(1 2 A 4))          ; Explota la validación de pares

;Actividad N° 5: Análisis Meteorológico

(es-ascendente-p '(30 32 32 35))
(quitar-repetidos '(30 35 30 38))

;Actividad N° 6: Lista Heterogénea y Átomo
(generar-divisiones '(10 A 20 -5 0) 2)   ; Ideal: ((10 5) (20 10))
(generar-divisiones '(10 20) 0)          ; Error de división por cero en Lisp


;Actividad N° 7: Historial de Llamadas (FunTel)
(cuandoHabloMas '((10 20) (5 5))) ; Debería devolver algo como Normal o lista 1
(cuandoHabloMas '((10 10) (5 15))) ;Debería devolver IGUAL
(cuandoHabloMas '(() (10 20)))

(LlamadaMasLarga '((10 50 5) (20 30))) ;Debería devolver (50 Normal) 
(LlamadaMasLarga '((50) (50)))
(LlamadaMasLarga '(() (20 30)))


(LlamadaMasCorta '((10 50) (5 30))) ;Debería devolver (5 Reducido)
(LlamadaMasCorta '((0 50) ()))



;Actividad N° 8: Archivos Digitales (Diseño)
(simetria-graficos '(10 20 10)) ;Debería devolver T
(simetria-graficos '(10 20 30)) ;Debería devolver NIL
(simetria-graficos '(15))
(simetria-graficos '())


(consumen-mas-graficos '(50 50) '(20 20)) ;Debería devolver T.
(consumen-mas-graficos '(50 50) '(100))

(combinar-filtrar '(10 20 30) '(5 25 10) 30) ;(45 40)

(combinar-filtrar '(10 20) '(5 25 10) 20)

(combinar-filtrar '(1 2) '(3 4) 50)



;Actividad N° 9: Sensores (Corte Temprano)

(evaluar-sensores '(10 20 30) '(10 20 30))       ; NIL 
(evaluar-sensores '(10 20) '(10 20 30))          ; Falla común: Explota si se asume que siempre tienen el mismo tamaño exacto y no validó null por separado.
(evaluar-sensores '(10 25 30) '(10 20 30))       ;  1-