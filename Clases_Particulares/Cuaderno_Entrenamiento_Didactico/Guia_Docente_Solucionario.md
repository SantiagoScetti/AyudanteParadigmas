# Guía Docente y Solucionario Comentado
### Cuaderno de Entrenamiento Didáctico: LISP y Programación Funcional
**Para uso del Ayudante / Docente — Paradigmas de Programación**

---

## 📌 Guía Pedagógica: Cómo guiar a la alumna en cada módulo

Cuando una alumna viene de un aplazo, suele tener **inseguridad operativa**: siente que no sabe nada porque en la hoja no le compila o se le cuelga el código. En realidad, la mayoría de los errores son solo **3 o 4 vicios mecánicos** (confundir neutros 0/nil, olvidar el `(cdr lista)`, o mezclar `mapcar` con filtros).

### Estrategia recomendada en la clase de apoyo:
1. **Que ella lea en voz alta la consigna:** Antes de tocar el teclado o escribir código, preguntale: *"¿Qué entra y qué tiene que salir? ¿Sale un número, una lista de igual tamaño o una lista filtrada?"*
2. **Hacer que dibuje la lista en papel:** Si le cuesta un accesor como `(car (cadr ...))`, que encierre entre corchetes o dibuje cajas para ver en qué nivel de anidación está el dato.
3. **No corregirle el error de inmediato:** Si escribe `(sumar lista)` en vez de `(sumar (cdr lista))`, preguntale: *"Si en la segunda vuelta le pasás la misma lista, ¿cuándo llega a nil?"* Dejala que ella misma descubra el bucle infinito.

---

# SOLUCIONARIO DETALLADO POR MÓDULOS

## MÓDULO 1: Anatomía de Listas y Cirugía de Accesores

### Ejercicio 1.1 — Verdadero o Falso
1. **VERDADERO.** `(cdr '(42))` devuelve `NIL`.
   - *Explicación docente:* Una lista de un elemento tiene un cons cuyo `car` es `42` y cuyo `cdr` apunta a `nil` (fin de lista).
2. **FALSO.** `(cons '(1 2) '(3 4))` devuelve `((1 2) 3 4)`, **no** una lista plana.
   - *Alerta ayudante:* Es la confusión más común entre `cons` y `append`. `cons` mete el primer argumento como **un único elemento** a la cabeza.
3. **FALSO.** `(caadr '((A B) (C D) (E F)))` extrae `C`, no `B`.
   - *Explicación docente:* `(cadr l)` es el segundo elemento `(C D)`. El `car` de eso es `C`. Para sacar `B` se necesita `(cadar l)`: primer elemento `(A B)`, y su segundo dato `B`.
4. **FALSO.** `(append '(A B) '(C D))` da `(A B C D)` (4 átomos), mientras que `(list '(A B) '(C D))` da `((A B) (C D))` (2 sublistas).
5. **VERDADERO.** En LISP puro y XLISP, `(car nil)` es `nil` y `(cdr nil)` es `nil`. Esto es una propiedad clave que previene caídas cuando una lista se vacía, aunque en funciones aritméticas como `(+ (car nil) ...)` explota porque `+` no acepta `nil`.

---

### Ejercicio 1.2 — Predicción de Retornos
Lista dada: `'(CAFE (BRASIL MEDIO) 1500 (LECHE AZUCAR))`
1. `(car M)` → `CAFE`
2. `(cdr M)` → `((BRASIL MEDIO) 1500 (LECHE AZUCAR))`
3. `(cadr M)` → `(BRASIL MEDIO)`
4. `(caddr M)` → `1500`
5. `(car (cadr M))` → `BRASIL`
6. `(cadr (cadr M))` → `MEDIO`
7. `(cadddr M)` → `(LECHE AZUCAR)`
8. `(car (cadddr M))` → `LECHE`

---

### Ejercicio 1.3 — Completar Código de Accesores
```lisp
;; a) Número de mesa:
(defun obtener-mesa (p)
    (car p))

;; b) Nombre del mozo:
(defun obtener-mozo (p)
    (car (cadr p)))  ;; o (caadr p)

;; c) Turno del mozo:
(defun obtener-turno (p)
    (cadr (cadr p))) ;; o (cadadr p)

;; d) Total a pagar:
(defun obtener-total (p)
    (cadddr p))
    ;; Equivalente desglosado: (car (cdr (cdr (cdr p))))

;; e) Estado del pedido:
(defun obtener-estado (p)
    (car (cddddr p)))  ;; o (nth 4 p)
```

---

### Ejercicio 1.4 — Caza de Bichos: El Caso Susana
1. **Respuesta:** No funciona para 5 mesas. Si vienen 5 mesas, solo procesará las 3 primeras y descartará las otras 2. Y si vinieran menos de 3 mesas (por ejemplo 2), `(cdr (cdr lista))` sería `nil`, y el tercer accesor devolvería `nil`, generando datos falsos.
2. **Error conceptual:** Intentar resolver la colección "a mano" con un accesor específico para la posición 1, otro para la posición 2 y otro para la posición 3. **La esencia de la programación funcional es procesar de forma genérica:** la función siempre mira el primero `(car lista)` y repite el proceso para el resto `(cdr lista)` recursivamente, o delega el recorrido a `MAPCAR`.

---

## MÓDULO 2: Lógica Condicional y Predicados Puros

### Ejercicio 2.1 — Verdadero o Falso
1. **FALSO.** La función `=` solo compara valores numéricos. Al pasarle símbolos lanza error de tipo: *`'PAGADO is not a number`*. Debe usarse `equal` (o `eq`).
2. **FALSO.** Si ninguna condición se cumple y no hay rama `T`, el `cond` no arroja error: devuelve simplemente `NIL`. Sin embargo, esto suele ser un bug lógico en el examen porque la función devuelve `nil` silenciosamente.
3. **VERDADERO.** La rama `(T valor)` se evalúa siempre que se alcance, funcionando como la cláusula *default* o *else*.
4. **FALSO.** En LISP, el número `0` **no es falso**. Cualquier valor distinto de `NIL` (incluyendo `0`, `""`, `'()` falso es solo `nil`) es considerado verdadero (`truthy`). Por eso `(if 0 'SI 'NO)` evalúa a `'SI`.
5. **FALSO.** `and` evalúa todas sus expresiones y, si todas son verdaderas, devuelve **el valor de la última expresión evaluada**. Como `'DESCUENTO` es no-nil, la expresión devuelve el símbolo `'DESCUENTO`, no `T`.

---

### Ejercicio 2.2 — Predicción de Retornos: Clasificador
1. `(clasificar-pedido 3500 4)`  → `PREMIUM-EXPRESS` (cumple precio >= 3000 y minutos <= 5).
2. `(clasificar-pedido 3200 12)` → `PREMIUM` (precio >= 3000, pero minutos > 5).
3. `(clasificar-pedido 1500 3)`  → `EXPRESS` (precio < 3000, pero minutos <= 5).
4. `(clasificar-pedido 2000 10)` → `ESTANDAR` (cae en la rama `T`).
5. `(clasificar-pedido 'MUCHO 5)`→ `DATOS-INVALIDOS` (salta la validación `(not (and (numberp ...)))`).

---

### Ejercicio 2.3 — Completar Código: Categorizar Consumo
```lisp
(defun categorizar-consumo (monto)
    (cond
        ((not (numberp monto)) 'ERROR-DATO)
        ((< monto 2000)        'BASICO)
        ((<= monto 5000)       'REGULAR)
        (T                     'VIP)))
```

---

### Ejercicio 2.4 — Caza de Bichos: El Error de Valen
1. **Respuesta:** Devuelve `T`.
2. **Explicación del error:** En la primera cláusula escribió `((equal estado 'LISTO))`. Un par de `cond` tiene la forma `(CONDICION RESULTADO)`. Al poner solo la condición sin el valor de retorno asociado, LISP evalúa la condición y, al ser verdadera, **devuelve el resultado de la propia condición**, que es `T`.
   - *Corrección:* `((equal estado 'LISTO) 'ENTREGAR)` o el símbolo/mensaje que correspondiera.

---

## MÓDULO 3: El Molde Sagrado de la Recursividad

### Ejercicio 3.1 — Verdadero o Falso
1. **FALSO.** Si el caso base de un contador devuelve `nil`, en la última suma se intentará ejecutar `(+ 1 nil)`, lo cual aborta con error de tipo. El neutro de contar y sumar **siempre debe ser `0`**.
2. **VERDADERO.** Si se pasa `lista` en vez de `(cdr lista)`, el argumento nunca se achica, la condición `(null lista)` nunca se alcanza y la memoria de pila se desborda (*stack overflow*).
3. **FALSO.** Para filtrar se construye una nueva lista usando `(cons (car lista) ...)`. Usar `+` sumaría los números en lugar de conservarlos en una lista.
4. **VERDADERO.** Si se pone una operación sobre `(car lista)` antes de verificar `(null lista)`, cuando la lista quede vacía se intentará operar sobre `nil`, rompiendo la función.
5. **VERDADERO.** El cuantificador universal "¿todos cumplen?" es verdadero por vaciedad (en lógica: $\forall x \in \emptyset, P(x)$ es verdadero). Si la lista se vació sin que ninguno falle, significa que todos cumplieron.

---

### Ejercicio 3.2 — Trazado Manual: Tabla de Pila
- Paso 2: Argumento: `'(2000 1500)`, `(car lista)`: `2000`, Base: NO, Pendiente: `(+ 2000 (sumar-precios '(1500)))`
- Paso 3: Argumento: `'(1500)`, `(car lista)`: `1500`, Base: NO, Pendiente: `(+ 1500 (sumar-precios '()))`
- Paso 4: Argumento: `nil`, `(car lista)`: `nil`, Base: **SÍ**, Devuelve neutro: `0`
- Vuelta 1: `(+ 1500 0)` = `1500`
- Vuelta 2: `(+ 2000 1500)` = `3500`
- Vuelta final: `(+ 1000 3500)` = **`4500`**

---

### Ejercicio 3.3 — Completar los Tres Patrones
```lisp
;; Patrón A (Contar):
(defun contar-caros (lista limite)
    (cond
        ((null lista) 0)
        ((> (car lista) limite)
            (+ 1 (contar-caros (cdr lista) limite)))
        (T
            (contar-caros (cdr lista) limite))))

;; Patrón B (Filtrar con CONS):
(defun filtrar-para-llevar (pedidos)
    (cond
        ((null pedidos) nil)
        ((equal (caddr (car pedidos)) 'LLEVAR)
            (cons (car pedidos) 
                  (filtrar-para-llevar (cdr pedidos))))
        (T
            (filtrar-para-llevar (cdr pedidos)))))

;; Patrón C (Predicado Universal):
(defun todas-libres-p (mesas)
    (cond
        ((null mesas) T)
        ((not (equal (car mesas) 'LIBRE)) nil)
        (T (todas-libres-p (cdr mesas)))))
```

---

### Ejercicio 3.4 — Caza de Bichos (Recursión)
- **Bicho 1:**
  - Línea con error: `((null tiempos) nil)`
  - Causa: Al terminar, ejecuta `(+ 1 nil)`.
  - Corrección: `((null tiempos) 0)`
- **Bicho 2:**
  - Línea con error: `(cons (car montos) (pedidos-mayores montos))`
  - Causa: Pasa `montos` en vez de `(cdr montos)` provocando bucle infinito (*stack overflow*).
  - Corrección: `(cons (car montos) (pedidos-mayores (cdr montos)))`
- **Bicho 3:**
  - Línea con error: Poner `((numberp (car lista)) ...)` antes de `((null lista) 0)`.
  - Causa: Al llegar al final de la lista, `(car nil)` da `nil`, `numberp` da falso y cae en la rama `T`, llamando a `(total-ventas (cdr nil))` indefinidamente.
  - Corrección: Mover el caso base `((null lista) 0)` al **primer lugar** del `cond`.

---

## MÓDULO 4: MAPCAR y Funciones de Orden Superior

### Ejercicio 4.1 — ¿Recursión o MAPCAR?
1. **MAPCAR.** *Justificación:* Hay que transformar cada pedido extrayendo su precio; la lista resultante tiene exactamente la misma longitud.
2. **RECURSIÓN.** *Justificación:* Es un filtro condicional (solo los > 4000); la lista resultante tendrá menos elementos que la original.
3. **RECURSIÓN.** *Justificación:* Calcular un promedio reduce toda la lista a un único número escalar.
4. **MAPCAR.** *Justificación:* A cada elemento le corresponde un mensaje; es una relación 1 a 1 de igual largo.
5. **MAPCAR.** *Justificación:* Se recorren dos listas en paralelo sumando posición a posición para dar una lista del mismo tamaño.
6. **RECURSIÓN.** *Justificación:* Es una búsqueda con corte temprano que devuelve un único valor de verdad (`T` o `NIL`).

---

### Ejercicio 4.2 — Predicción de Retornos MAPCAR
1. `(mapcar 'cadr '((1 CAFE 2000) (2 TE 1500) (3 SUBMARINO 2800)))` → `(CAFE TE SUBMARINO)`
2. `(mapcar '+ '(1000 2000 3000) '(200 300 400))` → `(1200 2300 3400)`
3. `(mapcar (lambda (x) (> x 1500)) '(1000 1500 2000 3000))` → `(NIL NIL T T)`
4. `(mapcar (lambda (p) (if (>= p 2500) 'CARO 'ACCESIBLE)) '(2000 3500 1800 2500))` → `(ACCESIBLE CARO ACCESIBLE CARO)`
5. `(mapcar (lambda (cant precio) (* cant precio)) '(2 3 1) '(1500 2000 4000))` → `(3000 6000 4000)`

---

### Ejercicio 4.3 — Completar Código: Lambda y COND
```lisp
(defun evaluar-tiempos-cocina (lista-pedidos)
    (mapcar (lambda (pedido)
                (cond
                    ((> (caddr pedido) 15)  'URGENTE)
                    ((>= (caddr pedido) 6)  'EN-HORA)
                    (T                      'A-TIEMPO)))
            lista-pedidos))
```

---

### Ejercicio 4.4 — Caza de Bichos: El Parámetro Escalar
1. Error: LISP avisa que `porcentaje` no es una lista válida para `mapcar` (*"0.10 is not a list"*).
2. Causa: `mapcar` espera que todos los argumentos tras la función sean listas para iterar elemento por elemento en paralelo.
3. Corrección:
```lisp
(defun aplicar-descuento-todos (lista porcentaje)
    (mapcar (lambda (precio) 
                (* precio (- 1 porcentaje)))
            lista))
```

---

## MÓDULO 5: El Gimnasio Didáctico (Pareo y Depuración)

### Ejercicio 5.1 — Pareo
- 1 → **E** (Contar: caso base 0, combina con `+ 1`)
- 2 → **C** (Transformación 1 a 1 con mensajes: `mapcar` + `lambda`)
- 3 → **D** (Filtrar: caso base `nil`, combina con `cons`)
- 4 → **A** (Universal: caso base `T`, corta con `nil` al primer fallo)
- 5 → **B** (Sumar acumulado: caso base 0, combina con `+ (campo ...)`)

---

### Ejercicio 5.2 — Caza de 4 Bichos Históricos
1. **Caso 1:** Al llamar `(estado-cafetera 100)` devuelve `T` porque no tiene valor de retorno.
   - *Corrección:* `((and (numberp temperatura) (> temperatura 95)) 'ALERTA-CALOR)`
2. **Caso 2:** Explota con error de tipo porque `=` es exclusivo para números.
   - *Corrección:* `(equal tipo-cafe 'DESCAFEINADO)`
3. **Caso 3:** La cátedra descuenta puntos por usar variables globales mutables (`setq total ...`), lo cual viola el paradigma funcional puro.
   - *Corrección:*
   ```lisp
   (defun sumar-items (lista)
       (cond
           ((null lista) 0)
           (T (+ (car lista) (sumar-items (cdr lista))))))
   ```
4. **Caso 4:** Error *"Undefined function totalPropinas"*. LISP no encuentra la función porque difiere en mayúsculas/minúsculas o en el nombre exacto declarado en `defun`.

---

## MÓDULO 6: Solución Completa del Simulacro Integrador

### Código LISP Verificado:

```lisp
;; =============================================================================
;; SIMULACRO INTEGRADOR: CAFETERÍA "EL BUEN GRANO"
;; SOLUCIÓN MODELO VERIFICADA (CÁTEDRA DE PARADIGMAS)
;; =============================================================================

;; -----------------------------------------------------------------------------
;; PARTE A: Operaciones sobre un Pedido Individual
;; Formato del pedido: (ID (GRANO TOSTADO) TAMANO PRECIO MINUTOS)
;; -----------------------------------------------------------------------------

;; 1. Funciones selectoras
(defun obtener-grano (pedido)
    (car (cadr pedido)))

(defun obtener-tostado (pedido)
    (cadr (cadr pedido)))

(defun obtener-precio (pedido)
    (cadddr pedido))

(defun obtener-tiempo (pedido)
    (car (cddddr pedido)))

;; 2. Predicado de grano colombiano (devuelve T o NIL)
(defun es-colombia-p (pedido)
    (equal (obtener-grano pedido) 'COLOMBIA))

;; 3. Clasificador de tiempo de espera con COND
(defun clasificar-espera (pedido)
    (cond
        ((<= (obtener-tiempo pedido) 5)  (list (car pedido) 'EXPRESS))
        ((<= (obtener-tiempo pedido) 12) (list (car pedido) 'NORMAL))
        (T                               (list (car pedido) 'DEMORADO))))


;; -----------------------------------------------------------------------------
;; PARTE B: Operaciones sobre la Lista de Pedidos
;; -----------------------------------------------------------------------------

;; 4. Clasificación masiva con MAPCAR (1 a 1)
(defun informe-tiempos (lista-pedidos)
    (mapcar 'clasificar-espera lista-pedidos))

;; 5. Recaudación total acumulada con RECURSIÓN pura
(defun recaudacion-total (lista-pedidos)
    (cond
        ((null lista-pedidos) 0)
        (T (+ (obtener-precio (car lista-pedidos))
              (recaudacion-total (cdr lista-pedidos))))))

;; 6. Filtrar pedidos colombianos con RECURSIÓN y CONS
(defun pedidos-colombianos (lista-pedidos)
    (cond
        ((null lista-pedidos) nil)
        ((es-colombia-p (car lista-pedidos))
            (cons (car lista-pedidos)
                  (pedidos-colombianos (cdr lista-pedidos))))
        (T
            (pedidos-colombianos (cdr lista-pedidos)))))

;; 7. Contar pedidos demorados con RECURSIÓN
(defun contar-demorados (lista-pedidos tiempo-limite)
    (cond
        ((null lista-pedidos) 0)
        ((> (obtener-tiempo (car lista-pedidos)) tiempo-limite)
            (+ 1 (contar-demorados (cdr lista-pedidos) tiempo-limite)))
        (T
            (contar-demorados (cdr lista-pedidos) tiempo-limite))))

;; 8. Predicado universal con RECURSIÓN (corte temprano)
(defun todos-express-p (lista-pedidos)
    (cond
        ((null lista-pedidos) T)
        ((> (obtener-tiempo (car lista-pedidos)) 5) nil)
        (T (todos-express-p (cdr lista-pedidos)))))

;; 9. Precios con descuento mediante MAPCAR y Lambda
(defun aplicar-promo (lista-pedidos porcentaje)
    (mapcar (lambda (pedido)
                (* (obtener-precio pedido) (- 1 porcentaje)))
            lista-pedidos))


;; -----------------------------------------------------------------------------
;; PARTE C: Función Menú Principal
;; -----------------------------------------------------------------------------

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
```
