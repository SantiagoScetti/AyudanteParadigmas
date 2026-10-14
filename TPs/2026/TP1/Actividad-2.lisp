;; --------------------------------------------------------------------
;; Actividad N° 2: Situaciones problemáticas (con validaciones y locales)
;; --------------------------------------------------------------------

;; 1. Promedio de dos notas
(defun calcular-promedio (nota1 nota2)
  (cond ((or (< nota1 0) (< nota2 0)) "Error: Las notas no pueden ser negativas.")
        (t (let ((suma (+ nota1 nota2)))
             (/ suma 2)))))

;; 2. Capacidad de la biblioteca
(defun capacidad-biblioteca (estantes libros-por-estante)
  (cond ((or (< estantes 0) (< libros-por-estante 0)) "Error: Valores no pueden ser negativos.")
        (t (let ((total (* estantes libros-por-estante)))
             total))))
;; Prueba: (capacidad-biblioteca 15 8)

;; 3. Ganancia de la vendedora de joyas
(defun ganancia-joyas (cajas pares-por-caja costo-par)
    (cond 
        ((or (< cajas 0) (< pares-por-caja 0) (< costo-par 0)) "Error: Valores ingresados inválidos.")
        (t (let ((total-pares (* cajas pares-por-caja))) (* total-pares costo-par)))
    )       
)
;; Prueba: (ganancia-joyas 8 15 15.45)

;; 4. Estampillas de Felipe
(defun total-estampillas (paginas filas-por-pagina estampillas-por-fila)
  (cond ((or (< paginas 0) (< filas-por-pagina 0) (< estampillas-por-fila 0)) "Error: Cantidades negativas.")
        (t (let ((total (* paginas filas-por-pagina estampillas-por-fila)))
             total))))
;; Prueba: (total-estampillas 14 2 9)

;; 5. Ahorros de Pedro (Gasto de 1/4)
(defun ahorros-pedro (monedas10 billetes50 billetes500 billetes100)
  (cond ((or (< monedas10 0) (< billetes50 0) (< billetes500 0) (< billetes100 0)) "Error: Cantidades negativas.")
        (t (let* ((total (+ (* monedas10 10) 
                            (* billetes50 50) 
                            (* billetes500 500) 
                            (* billetes100 100)))
                  (gasto (/ total 4)))
             (- total gasto)))))
;; Prueba: (ahorros-pedro 6 4 1 5)

;; 6. Reparto de agua en envases
(defun envases-necesarios (litros1 centilitros2 litros3 cap-envase)
  (cond ((<= cap-envase 0) "Error: La capacidad del envase debe ser mayor a cero.")
        ((or (< litros1 0) (< centilitros2 0) (< litros3 0)) "Error: Volúmenes negativos.")
        (t (let* ((litros2 (/ centilitros2 100.0)) ; Conversión de cl a litros
                  (total-litros (+ litros1 litros2 litros3)))
             (/ total-litros cap-envase)))))
;; Prueba: (envases-necesarios 357 49800 1765 20)

;; 7. Sacos de papas restantes
(defun papas-restantes (sacos peso-saco)
  (cond ((or (< sacos 0) (< peso-saco 0)) "Error: Valores inválidos.")
        (t (let ((total-kilos (* sacos peso-saco)))
             (/ total-kilos 2))))) ; Si vende la mitad, queda la mitad
;; Prueba: (papas-restantes 62 85)

;; 8. Alertas de bomberos
(defun alertas-historicas (alertas-año1)
  (cond ((< alertas-año1 0) "Error: Las alertas no pueden ser negativas.")
        (t (let ((alertas-año2 (+ alertas-año1 (* alertas-año1 0.20))))
             (+ alertas-año1 alertas-año2)))))
;; Prueba: (alertas-historicas 40)