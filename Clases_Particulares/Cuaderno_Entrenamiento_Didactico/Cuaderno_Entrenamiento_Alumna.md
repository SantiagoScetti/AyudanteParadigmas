# Cuaderno de Entrenamiento Didáctico: LISP y Programación Funcional
### Preparación Intensiva para Exámenes y Recuperatorios
**Cátedra de Paradigmas de Programación — Lenguaje Common LISP / XLISP**

---

> ### 📌 Cómo usar este cuaderno de trabajo
> Este material está pensado para que vayas paso a paso, sin saltear etapas y sin frustrarte frente a una hoja en blanco. No tenés que resolver todo en un solo día: tomate tu tiempo para entender el "por qué" de cada estructura.
> 
> **Metodología de trabajo:**
> 1. Leé con atención la **caja de conceptos clave** de cada módulo.
> 2. Resolvé los ejercicios en lápiz sobre este cuaderno (marcá los `[ ]`, completá las líneas de puntos `..........` y rellená los huecos de código `______`).
> 3. En los ejercicios de código, **no abras el intérprete de Lisp de entrada**: forzate a predecir qué hace en tu cabeza o en papel, tal como en un examen presencial.
> 4. Antes de escribir cualquier función de parcial, pasá por la lista de verificación: *¿Es recursión o MAPCAR? ¿Cuál es el caso base? ¿Qué tipo de dato debe devolver?*

---

# MÓDULO 1: Anatomía de Listas y Cirugía de Accesores

### 💡 Conceptos Clave
En LISP, toda lista está compuesta por pares ordenados llamados celdas de construcción (`cons`). 
- **`car`**: Toma el **primer elemento** de la lista (puede ser un átomo o una sublista).
- **`cdr`**: Toma el **resto de la lista** (siempre devuelve una lista, o `nil` si ya no quedan elementos).
- **Regla de las dos etapas para sublistas:**
  - *Paso 1 (Moverse hasta la sublista deseada):* Se usan `cdr` sucesivos para avanzar y un `car` final para entrar.
  - *Paso 2 (Extraer el campo de esa sublista):* Dentro de la sublista, el 1º dato es `(car ...)`, el 2º es `(cadr ...)` o `(car (cdr ...))`, el 3º es `(caddr ...)`.
- **Diferencia crucial entre constructores:**
  - `(cons elemento lista)`: Agrega un elemento **al principio** de una lista existente.
  - `(list a b c)`: Crea una lista nueva cuyos elementos son exactamente los argumentos pasados.
  - `(append lista1 lista2)`: Une dos o más listas al mismo nivel en una sola lista resultante.

---

### Ejercicio 1.1 — Verdadero o Falso (Conceptos de Estructura)
*Marcá con una cruz `[X]` en V o F según corresponda, y justificá brevemente tu elección.*

1. **[  ] V  /  [  ] F** — La expresión `(cdr '(42))` devuelve `nil`.
   *Justificación:* .........................................................................................................................

2. **[  ] V  /  [  ] F** — Si ejecutamos `(cons '(1 2) '(3 4))`, el resultado es una lista plana de 4 elementos `(1 2 3 4)`.
   *Justificación:* .........................................................................................................................

3. **[  ] V  /  [  ] F** — En una lista de la forma `((A B) (C D) (E F))`, la función `(caadr ...)` extrae el elemento `B`.
   *Justificación:* .........................................................................................................................

4. **[  ] V  /  [  ] F** — La función `(append '(A B) '(C D))` genera exactamente la misma lista que `(list '(A B) '(C D))`.
   *Justificación:* .........................................................................................................................

5. **[  ] V  /  [  ] F** — La expresión `(car nil)` y `(cdr nil)` en LISP devuelven ambas `nil` sin arrojar error de ejecución.
   *Justificación:* .........................................................................................................................

---

### Ejercicio 1.2 — Predicción de Retornos: ¿Qué devuelve LISP?
*Escribí exactamente el valor de retorno que arroja cada expresión. Prestá especial atención a los paréntesis.*

Dada la siguiente lista asignada a la variable `M`:
```lisp
'(CAFE (BRASIL MEDIO) 1500 (LECHE AZUCAR))
```

1. `(car M)`
   → Respuesta: `________________________________________________`

2. `(cdr M)`
   → Respuesta: `________________________________________________`

3. `(cadr M)`
   → Respuesta: `________________________________________________`

4. `(caddr M)`
   → Respuesta: `________________________________________________`

5. `(car (cadr M))`
   → Respuesta: `________________________________________________`

6. `(cadr (cadr M))`
   → Respuesta: `________________________________________________`

7. `(cadddr M)`
   → Respuesta: `________________________________________________`

8. `(car (cadddr M))`
   → Respuesta: `________________________________________________`

---

### Ejercicio 1.3 — Completar el Código (Accesores Quirúrgicos)
*Dada una lista `P` que representa un pedido de cafetería:*
```lisp
;; Formato del registro P:
;; (NUM-MESA (MOZO TURNO) CANT-ITEMS TOTAL-PESOS ESTADO)
;; Ejemplo real:
;; '(4 (JUAN TARDE) 3 4500 PAGADO)
```

Completá los accesores para definir cada función selectora modular:

```lisp
;; a) Obtener el número de mesa (ej: 4):
(defun obtener-mesa (p)
    (________________ p))

;; b) Obtener el nombre del mozo (ej: JUAN):
(defun obtener-mozo (p)
    (car (________________ p)))

;; c) Obtener el turno del mozo (ej: TARDE):
(defun obtener-turno (p)
    (cadr (________________ p)))

;; d) Obtener el total a pagar (ej: 4500):
(defun obtener-total (p)
    (cadddr p))  ;; ¿Qué combinación equivalente con car y cdr sería?:
    ;; (car (cdr (cdr (________________ p))))

;; e) Obtener el estado del pedido (ej: PAGADO):
(defun obtener-estado (p)
    (car (cddddr p)))  ;; o mediante nth: (nth ______ p)
```

---

### Ejercicio 1.4 — Caza de Bichos: Los Errores de Susana
*El siguiente código fue escrito por una alumna en su parcial. La función debía recibir una lista de 3 clientes de cafetería y devolver una lista con los nombres de los 3 mozos que los atendieron:*
```lisp
;; Lista de entrada:
;; '((1 (LUCIA MANANA) 1200) (2 (MARCOS TARDE) 2500) (3 (SOFIA NOCHE) 3100))

;; Código escrito por la alumna:
(defun nombres-mozos (lista)
    (list (car (cdr (car lista)))
          (car (cdr (car (cdr lista))))
          (car (cdr (car (cdr (cdr lista)))))))
```

1. ¿Funciona este código si la cafetería tiene 5 mesas en vez de 3? ¿Por qué?
   *Respuesta:* .........................................................................................................................
   .........................................................................................................................................

2. ¿Qué error conceptual comete al resolver cada posición a mano con `cddr` sucesivos en vez de usar una herramienta iterativa o recursiva?
   *Respuesta:* .........................................................................................................................
   .........................................................................................................................................

---

# MÓDULO 2: Lógica Condicional y Predicados Puros

### 💡 Conceptos Clave
- **Predicado Puro**: Es toda función que responde a una pregunta de "sí o no" devolviendo **exclusivamente `T` o `NIL`**. Por convención de la cátedra llevan el sufijo `-p` (ej: `es-caro-p`, `vencido-p`).
- **Comparación de Tipos de Datos**:
  - Para números: `=` , `<`, `>`, `<=`, `>=`. *(¡Nunca uses `=` con símbolos ni textos!)*
  - Para símbolos y listas: `equal` (o `eq` para símbolos idénticos). `(equal 'CAFE 'CAFE)` da `T`, pero `(= 'CAFE 'CAFE)` explota con error de tipo numérico.
- **La Regla de Oro del `IF` vs `COND` en la Cátedra**:
  - `if`: Se usa **únicamente cuando hay 2 ramas exactas** (verdadero y falso simple). Formato: `(if condicion rama-true rama-false)`.
  - `cond`: Se usa cuando hay **3 o más alternativas** o condiciones compuestas. Formato: `(cond (condicion1 res1) (condicion2 res2) (T res-por-defecto))`.
  - **PROHIBIDO**: Anidar un `if` dentro de un `cond` o un `cond` dentro de un `if`. Se descuentan puntos directamente.
- **Peligro mortal en `cond`**: Cada cláusula debe ser una lista de dos elementos: `(condición resultado)`. Si escribís `((and (numberp x) (> x 10)))` sin poner el resultado al lado, el `cond` devuelve el resultado de la condición (`T`), arruinando el cálculo.

---

### Ejercicio 2.1 — Verdadero o Falso (Decisiones y Tipos)
*Marcá V o F y justificá.*

1. **[  ] V  /  [  ] F** — La expresión `(= 'PAGADO 'PAGADO)` evalúa a `T`.
   *Justificación:* .........................................................................................................................

2. **[  ] V  /  [  ] F** — En la estructura `(cond ((< x 0) -1) ((> x 0) 1))`, si `x` vale `0`, la función arroja un error de sistema.
   *Justificación:* .........................................................................................................................

3. **[  ] V  /  [  ] F** — La rama final `(T valor)` en un `cond` actúa como el caso por defecto (*else*) y se ejecuta solo si ninguna condición previa fue verdadera.
   *Justificación:* .........................................................................................................................

4. **[  ] V  /  [  ] F** — Si una función predicado devuelve el número `0`, LISP lo considera automáticamente como falso (`NIL`).
   *Justificación:* .........................................................................................................................

5. **[  ] V  /  [  ] F** — La expresión `(and (numberp 25) (> 25 10) 'DESCUENTO)` devuelve `T`.
   *Justificación:* .........................................................................................................................

---

### Ejercicio 2.2 — Predicción de Retornos: Clasificador de Cafés
*Analizá detenidamente la siguiente función:*

```lisp
(defun clasificar-pedido (precio minutos)
    (cond
        ((not (and (numberp precio) (numberp minutos))) 'DATOS-INVALIDOS)
        ((and (>= precio 3000) (<= minutos 5))          'PREMIUM-EXPRESS)
        ((>= precio 3000)                               'PREMIUM)
        ((<= minutos 5)                                 'EXPRESS)
        (T                                              'ESTANDAR)))
```

Indicá el resultado exacto de evaluar cada llamada:

1. `(clasificar-pedido 3500 4)`  → `________________________________________`
2. `(clasificar-pedido 3200 12)` → `________________________________________`
3. `(clasificar-pedido 1500 3)`  → `________________________________________`
4. `(clasificar-pedido 2000 10)` → `________________________________________`
5. `(clasificar-pedido 'MUCHO 5)`→ `________________________________________`

---

### Ejercicio 2.3 — Completar el Código (Clasificador con COND)
*En la cafetería, los pedidos se etiquetan según el monto total consumido:*
- Menor a $2000: `'BASICO`
- Entre $2000 y $5000 (inclusive): `'REGULAR`
- Mayor a $5000: `'VIP`

Completá los espacios vacíos respetando la regla de **no anidar `if`**:

```lisp
(defun categorizar-consumo (monto)
    (cond
        ((not (numberp monto)) ________________________)
        ((< monto 2000)        'BASICO)
        ((<= monto 5000)       ________________________)
        (T                     'VIP)))
```

---

### Ejercicio 2.4 — Caza de Bichos: El Error de Valen
*Mirá la siguiente función que escribió un alumno para verificar si un pedido está listo para entregar:*

```lisp
;; Código con error:
(defun listo-para-entregar-p (estado minutos)
    (cond
        ((equal estado 'LISTO))
        ((and (equal estado 'PREPARANDO) (> minutos 15)) 'URGENTE)
        (T 'ESPERAR)))
```

1. ¿Qué valor devuelve la función si llamamos `(listo-para-entregar-p 'LISTO 5)`?
   *Respuesta:* .........................................................................................................................

2. ¿Cuál es el error en la primera cláusula del `cond` y cómo debe corregirse?
   *Respuesta:* .........................................................................................................................
   .........................................................................................................................................

---

# MÓDULO 3: El Molde Sagrado de la Recursividad

### 💡 Conceptos Clave
Una función recursiva bien construida en LISP nunca requiere variables globales (`setq`). El valor final **viaja y se arma en el retorno de las llamadas**.

Toda función recursiva sobre listas se compone de **tres elementos obligatorios**:
1. **Caso base (siempre primero en el `cond`)**: Condición de detención cuando la lista queda vacía: `((null lista) neutro)`.
2. **Operación de combinación con el primer elemento `(car lista)`**: Se procesa el elemento que tenemos a mano.
3. **Paso recursivo que avanza hacia el final**: Llamada a la misma función pasando estrictamente el resto de la lista: `(nombre-funcion (cdr lista))`.

### 📋 La Tabla Sagrada de Neutros y Combinadores

| Tipo de Problema | Pregunta que responde | Valor neutro en Caso Base | Combinador con `(car lista)` |
|---|---|:---:|:---:|
| **Contar** | "¿Cuántos cumplen?" | `0` | `(+ 1 (recursión (cdr l)))` |
| **Sumar / Total** | "¿Cuánto suma en total?" | `0` | `(+ valor (recursión (cdr l)))` |
| **Multiplicar** | "¿Cuál es el producto?" | `1` | `(* valor (recursión (cdr l)))` |
| **Filtrar** | "¿Cuáles son los que cumplen?" | `nil` | `(cons (car l) (recursión (cdr l)))` |
| **Todos cumplen** (Universal) | "¿Todos cumplen la condición?" | `T` | Si no cumple: `nil`. Si cumple: llamada recursiva. |
| **Al menos uno** (Existencial)| "¿Existe alguno que cumpla?" | `nil` | Si cumple: `T`. Si no: llamada recursiva. |

---

### Ejercicio 3.1 — Verdadero o Falso (Mecánica Recursiva)
*Marcá V o F y justificá.*

1. **[  ] V  /  [  ] F** — En una función recursiva que cuenta elementos, el caso base `((null lista) nil)` es correcto porque una lista vacía equivale a `nil`.
   *Justificación:* .........................................................................................................................

2. **[  ] V  /  [  ] F** — Si en la llamada recursiva escribimos `(sumar lista)` en vez de `(sumar (cdr lista))`, el programa entra en un bucle infinito (*stack overflow*).
   *Justificación:* .........................................................................................................................

3. **[  ] V  /  [  ] F** — Para filtrar los números mayores a 10 de una lista, la rama verdadera del cond debe usar `(+ (car lista) (filtrar (cdr lista)))`.
   *Justificación:* .........................................................................................................................

4. **[  ] V  /  [  ] F** — El caso base de una recursión debe ubicarse siempre al principio del `cond` para evitar intentar hacer `car` de una lista vacía.
   *Justificación:* .........................................................................................................................

5. **[  ] V  /  [  ] F** — Para saber si **todos** los clientes pagaron su cuenta, el caso base con lista vacía `(null lista)` debe devolver `T`.
   *Justificación:* .........................................................................................................................

---

### Ejercicio 3.2 — Trazado Manual Paso a Paso: La Pila de Llamadas
Dada la siguiente función y la lista de precios de cafés `'(1000 2000 1500)`:

```lisp
(defun sumar-precios (lista)
    (cond
        ((null lista) 0)
        (T (+ (car lista) (sumar-precios (cdr lista))))))
```

Completá la tabla del camino de **ida** (apilar llamadas) y de **vuelta** (desapilar y resolver sumas):

| Paso | Llamada activa | Argumento `lista` | `(car lista)` | ¿Llegó al caso base? | Retorno pendiente de calcular |
|:---:|---|---|:---:|:---:|---|
| **1** | `(sumar-precios '(1000 2000 1500))` | `'(1000 2000 1500)` | `1000` | NO | `(+ 1000 (sumar-precios '(2000 1500)))` |
| **2** | `(sumar-precios '(2000 1500))` | `..................` | `......` | NO | `(+ 2000 (sumar-precios '(1500)))` |
| **3** | `(sumar-precios '(1500))` | `..................` | `......` | NO | `(+ 1500 (sumar-precios '()))` |
| **4** | `(sumar-precios '())` | `nil` | `nil` | **SÍ** | Devuelve neutro: `______` |
| **←** | *Resolución hacia atrás:* | `(+ 1500 ______)` = `______` | | | |
| **←** | *Resolución hacia atrás:* | `(+ 2000 ______)` = `______` | | | |
| **←** | *Resultado final devuelto:* | `(+ 1000 ______)` = `______` | | | |

---

### Ejercicio 3.3 — Completar Código: Los Tres Patrones Fundamentales

#### Patrón A: Contar cuántos cafés superan un precio límite
```lisp
(defun contar-caros (lista limite)
    (cond
        ((null lista) ________)  ;; <- ¿Qué neutro va al contar?
        ((> (car lista) limite)
            (+ 1 (contar-caros (____________ lista) limite)))
        (T
            (contar-caros (cdr lista) limite))))
```

#### Patrón B: Filtrar los pedidos que son para llevar (devolver una sublista con ellos)
```lisp
;; Cada elemento es: '(ID CONSUMICION TIPO) -> ej: '(101 CAFE LLEVAR)
(defun filtrar-para-llevar (pedidos)
    (cond
        ((null pedidos) ________)  ;; <- ¿Qué neutro va al armar lista?
        ((equal (caddr (car pedidos)) 'LLEVAR)
            (cons (____________ pedidos) 
                  (filtrar-para-llevar (cdr pedidos))))
        (T
            (filtrar-para-llevar (____________ pedidos)))))
```

#### Patrón C: Predicado Universal (¿Todas las mesas están desocupadas?)
```lisp
;; Lista de estados: '(LIBRE LIBRE OCUPADA LIBRE)
(defun todas-libres-p (mesas)
    (cond
        ((null mesas) ________)  ;; Si no quedó ninguna ocupada, ¿es T o NIL?
        ((not (equal (car mesas) 'LIBRE)) ________)  ;; Al primer fallo: corta
        (T (todas-libres-p (cdr mesas)))))
```

---

### Ejercicio 3.4 — Caza de Bichos: Los 3 Clásicos de Parcial
Identificá la línea que tiene el error, explicá por qué falla y escribí la línea corregida:

**Bicho 1:**
```lisp
(defun contar-express (tiempos)
    (cond
        ((null tiempos) nil)
        ((<= (car tiempos) 5) (+ 1 (contar-express (cdr tiempos))))
        (T (contar-express (cdr tiempos)))))
```
- *Línea con error:* ....................................................................................................................
- *¿Por qué explota al ejecutarse?:* .................................................................................................
- *Línea corregida:* ...................................................................................................................

**Bicho 2:**
```lisp
(defun pedidos-mayores (montos)
    (cond
        ((null montos) nil)
        ((> (car montos) 3000) (cons (car montos) (pedidos-mayores montos)))
        (T (pedidos-mayores (cdr montos)))))
```
- *Línea con error:* ....................................................................................................................
- *¿Qué le pasa a la computadora al correr esto?:* .................................................................................
- *Línea corregida:* ...................................................................................................................

**Bicho 3:**
```lisp
(defun total-ventas (lista)
    (cond
        ((numberp (car lista)) (+ (car lista) (total-ventas (cdr lista))))
        ((null lista) 0)
        (T (total-ventas (cdr lista)))))
```
- *Línea con error:* ....................................................................................................................
- *¿Por qué falla cuando `lista` llega al final?:* ...................................................................................
- *¿Cómo se corrige?:* .................................................................................................................

---

# MÓDULO 4: MAPCAR y Funciones de Orden Superior

### 💡 Conceptos Clave
- **¿Qué hace `mapcar`?**: Aplica una función a cada elemento de una o más listas y **devuelve una nueva lista con los resultados, exactamente de la misma longitud que la original**.
- **La Pregunta Decisiva: ¿MAPCAR o Recursión?**
  - Si el enunciado te pide: *"para cada café calcular su precio con IVA"*, *"obtener la lista de nombres de mozos"*, *"convertir cada tiempo a mensaje"* → **MAPCAR** (porque la salida tiene la misma cantidad de elementos que la entrada: transformación 1 a 1).
  - Si el enunciado te pide: *"sumar el total"*, *"contar cuántos cumplen"*, *"quedarse SOLO con los mayores a $2000"*, *"determinar si todos están listos"* → **RECURSIÓN** (porque cambia la cantidad de elementos o reduce a un único valor).
- **Sintaxis de la Cátedra**:
  - Función con nombre existente: `(mapcar 'car lista)` o `(mapcar 'evenp lista)`.
  - Lógica con cálculo propio o varias ramas: Usar siempre `lambda` con `cond` adentro:
    ```lisp
    (mapcar (lambda (x)
                (cond
                    ((< x 10) 'POCO)
                    (T        'MUCHO)))
            lista)
    ```
- **El error de pasar un parámetro escalar como lista**:
  `mapcar` solo acepta listas como argumentos a iterar. Si tenés una variable fija (como un porcentaje de recargo o un límite), **no se pasa a `mapcar`**, sino que el `lambda` la captura automáticamente del entorno (*cierre léxico*):
  ```lisp
  ;; BIEN: el lambda accede a "recargo" directamente
  (defun aplicar-recargo (precios recargo)
      (mapcar (lambda (p) (* p (+ 1 recargo))) precios))
  ```

---

### Ejercicio 4.1 — ¿Recursión o MAPCAR? (Toma de Decisiones)
*Para cada una de las siguientes consignas de examen, indicá qué herramienta corresponde usar y justificá en exactamente un renglón basándote en la longitud de la lista de salida.*

1. *"Dada una lista de pedidos `((ID TIPO PRECIO) ...)`, obtener una nueva lista que contenga solo los precios de cada pedido."*
   - Herramienta: `[  ] MAPCAR   /   [  ] RECURSIÓN`
   - *Justificación:* ...................................................................................................................

2. *"Dada una lista de pedidos, obtener una lista con los pedidos cuyo precio supere los $4.000."*
   - Herramienta: `[  ] MAPCAR   /   [  ] RECURSIÓN`
   - *Justificación:* ...................................................................................................................

3. *"Dada una lista de consumos, determinar el monto promedio gastado por mesa."*
   - Herramienta: `[  ] MAPCAR   /   [  ] RECURSIÓN`
   - *Justificación:* ...................................................................................................................

4. *"Dada una lista de tiempos de espera en minutos, transformar cada tiempo en un mensaje: 'RAPIDO' (<= 5), 'NORMAL' (<= 15) o 'DEMORADO' (> 15)."*
   - Herramienta: `[  ] MAPCAR   /   [  ] RECURSIÓN`
   - *Justificación:* ...................................................................................................................

5. *"Dadas dos listas de números de igual longitud (precios base y costos de adicionales), generar una nueva lista con el costo total de cada consumición sumando posición a posición."*
   - Herramienta: `[  ] MAPCAR   /   [  ] RECURSIÓN`
   - *Justificación:* ...................................................................................................................

6. *"Verificar si existe al menos un pedido cuyo estado sea 'URGENTE'."*
   - Herramienta: `[  ] MAPCAR   /   [  ] RECURSIÓN`
   - *Justificación:* ...................................................................................................................

---

### Ejercicio 4.2 — Predicción de Retornos con MAPCAR
*Escribí qué devuelve cada una de las siguientes expresiones:*

1. `(mapcar 'cadr '((1 CAFE 2000) (2 TE 1500) (3 SUBMARINO 2800)))`
   → Respuesta: `________________________________________________`

2. `(mapcar '+ '(1000 2000 3000) '(200 300 400))`
   → Respuesta: `________________________________________________`

3. `(mapcar (lambda (x) (> x 1500)) '(1000 1500 2000 3000))`
   → Respuesta: `________________________________________________`

4. `(mapcar (lambda (p) (if (>= p 2500) 'CARO 'ACCESIBLE)) '(2000 3500 1800 2500))`
   → Respuesta: `________________________________________________`

5. `(mapcar (lambda (cant precio) (* cant precio)) '(2 3 1) '(1500 2000 4000))`
   → Respuesta: `________________________________________________`

---

### Ejercicio 4.3 — Completar Código: MAPCAR con Lambda y COND
Dada una lista de pedidos donde cada elemento es `'(ID-MESA PRECIO MINUTOS)`:
```lisp
;; Ejemplo de lista:
;; '((1 2500 4) (2 4200 18) (3 1500 12))
```
Queremos una función que devuelva una lista de etiquetas de prioridad para la cocina:
- Si tardó más de 15 minutos: `'URGENTE`
- Si tardó entre 6 y 15 minutos: `'EN-HORA`
- Si tardó 5 minutos o menos: `'A-TIEMPO`

Completá el lambda:
```lisp
(defun evaluar-tiempos-cocina (lista-pedidos)
    (mapcar (lambda (pedido)
                (cond
                    ((> (caddr pedido) 15)  ________________________)
                    ((>= (caddr pedido) 6)  'EN-HORA)
                    (T                      ________________________)))
            ________________________))
```

---

### Ejercicio 4.4 — Caza de Bichos: El Clásico Parámetro Escalar
Mirá la siguiente función que intentó hacer un alumno para aplicarle a todos los precios de una lista un descuento ingresado por el operador:

```lisp
;; Código con error de examen:
(defun aplicar-descuento-todos (lista porcentaje)
    (mapcar (lambda (precio desc) (* precio (- 1 desc)))
            lista
            porcentaje))
```

1. ¿Qué error arroja LISP al invocar `(aplicar-descuento-todos '(2000 3000) 0.10)`?
   *Respuesta:* .........................................................................................................................

2. ¿Por qué ocurrió ese error? ¿Cuántas listas esperaba `mapcar` y qué era `porcentaje`?
   *Respuesta:* .........................................................................................................................
   .........................................................................................................................................

3. Escribí la versión corregida utilizando cierre léxico:
```lisp
(defun aplicar-descuento-todos (lista porcentaje)
    (mapcar (lambda (precio) 
                (* precio (- 1 ________________)))
            ________________))
```

---

# MÓDULO 5: El Gimnasio Didáctico (Pareo, Traza y Depuración)

### Ejercicio 5.1 — Pareo de Enunciados a Plantillas LISP
*Uní con una flecha (o escribí la letra en el corchete) cada consigna en lenguaje coloquial con su plantilla estructural LISP correspondiente:*

**Consignas:**
1. `[   ]` Contar cuántos elementos cumplen un criterio.
2. `[   ]` Generar una lista con un mensaje descriptivo para cada elemento (mismo largo).
3. `[   ]` Obtener una nueva lista conteniendo únicamente los elementos que cumplen un filtro.
4. `[   ]` Determinar si absolutamente todos los elementos verifican una propiedad.
5. `[   ]` Calcular la suma acumulada de un campo numérico.

**Plantillas LISP:**
- **A)** `(cond ((null l) T) ((not (condicion (car l))) nil) (T (fun (cdr l))))`
- **B)** `(cond ((null l) 0) (T (+ (campo (car l)) (fun (cdr l)))))`
- **C)** `(mapcar (lambda (x) (cond ((c1 x) 'M1) (T 'M2))) lista)`
- **D)** `(cond ((null l) nil) ((cumple (car l)) (cons (car l) (fun (cdr l)))) (T (fun (cdr l))))`
- **E)** `(cond ((null l) 0) ((cumple (car l)) (+ 1 (fun (cdr l)))) (T (fun (cdr l))))`

---

### Ejercicio 5.2 — Caza de 4 Bichos Históricos de Exámenes
*Leé cada fragmento y corregí la línea defectuosa:*

#### Caso 1: El fantasma del COND sin retorno (Error típico de parcial)
```lisp
(defun estado-cafetera (temperatura)
    (cond
        ((and (numberp temperatura) (> temperatura 95)))
        (T 'NORMAL)))
```
- *Qué ocurre al llamar `(estado-cafetera 100)`:* .............................................................................
- *Corrección de la primera cláusula:* `((and (numberp temperatura) (> temperatura 95)) ____________)`

#### Caso 2: El comparador de símbolos fatal
```lisp
(defun es-descafeinado-p (tipo-cafe)
    (= tipo-cafe 'DESCAFEINADO))
```
- *¿Por qué explota?:* .................................................................................................................
- *Corrección:* `(____________ tipo-cafe 'DESCAFEINADO)`

#### Caso 3: El acumulador con variable global
```lisp
(defun sumar-items (lista)
    (cond
        ((null lista) total)
        (T (setq total (+ total (car lista))) (sumar-items (cdr lista)))))
```
- *¿Por qué descuenta la cátedra este código?:* ...............................................................................
- *Escribilo de forma funcional pura (sin `setq` ni variables externas):*
```lisp
(defun sumar-items (lista)
    (cond
        ((null lista) ____)
        (T (+ ________________ (sumar-items ________________)))))
```

#### Caso 4: La llamada recursiva con typo de nombre
```lisp
(defun total-propinas (lista-mozos)
    (cond
        ((null lista-mozos) 0)
        (T (+ (cadar lista-mozos) (totalPropinas (cdr lista-mozos))))))
```
- *¿Qué mensaje de error arroja el compilador/intérprete?:* ..................................................................
- *Corrección:* .........................................................................................................................

---

# MÓDULO 6: Gran Simulacro Integrador
## Cafetería de Especialidad "El Buen Grano"

### 📋 Enunciado General
Un sistema de gestión de una cafetería de especialidad registra la información de los pedidos que se atienden durante el día.

Cada pedido individual se representa mediante una lista con la siguiente estructura:
```lisp
(ID_PEDIDO (TIPO_GRANO TOSTADO) TAMANO PRECIO_BASE MINUTOS_ESPERA)
```
Donde:
- `ID_PEDIDO`: Identificador numérico del pedido (ej: `101`).
- `(TIPO_GRANO TOSTADO)`: Sublista con el tipo de grano (átomo: `'COLOMBIA`, `'BRASIL` o `'ETIOPIA'`) y nivel de tostado (átomo: `'SUAVE`, `'MEDIO` o `'FUERTE'`).
- `TAMANO`: Átomo con el tamaño de la taza (`'CHICO`, `'MEDIANO'` o `'GRANDE'`).
- `PRECIO_BASE`: Número con el precio en pesos (ej: `3200`).
- `MINUTOS_ESPERA`: Número de minutos que demoró la preparación (ej: `8`).

---

### PARTE A: Operaciones sobre un Pedido Individual (Nivel TP1 a TP3)

#### Consigna 1: Funciones Selectoras Modulares
*Desarrollar las siguientes funciones auxiliares para aislar los campos de un pedido:*
1. `(obtener-grano pedido)`: Devuelve el átomo del tipo de grano (ej: `'COLOMBIA`).
2. `(obtener-tostado pedido)`: Devuelve el nivel de tostado (ej: `'MEDIO`).
3. `(obtener-precio pedido)`: Devuelve el precio base del café.
4. `(obtener-tiempo pedido)`: Devuelve los minutos de espera.

*Espacio para tu código:*
```lisp
;; 1. Tipo de grano:
(defun obtener-grano (pedido)
    ________________________________________________)

;; 2. Nivel de tostado:
(defun obtener-tostado (pedido)
    ________________________________________________)

;; 3. Precio base:
(defun obtener-precio (pedido)
    ________________________________________________)

;; 4. Minutos de espera:
(defun obtener-tiempo (pedido)
    ________________________________________________)
```

---

#### Consigna 2: Predicado de Café Colombiano
*Desarrollar una función predicado `es-colombia-p` que, a partir de un pedido, determine si el café utilizado es de origen `'COLOMBIA`.*
- *Recordar:* Debe devolver `T` o `NIL`.

*Espacio para tu código:*
```lisp
(defun es-colombia-p (pedido)
    _____________________________________________________________________)
```

---

#### Consigna 3: Clasificador del Tiempo de Espera con COND
*Desarrollar una función `clasificar-espera` que reciba un pedido individual y devuelva una lista con el formato `(ID_PEDIDO ETIQUETA)`, donde la etiqueta será:*
- `'EXPRESS`: Si demoró 5 minutos o menos.
- `'NORMAL`: Si demoró entre 6 y 12 minutos (inclusive).
- `'DEMORADO`: Si demoró más de 12 minutos.

*Espacio para tu código:*
```lisp
(defun clasificar-espera (pedido)
    (cond
        ((<= (obtener-tiempo pedido) 5)  (list (car pedido) 'EXPRESS))
        ((<= (obtener-tiempo pedido) 12) (list (car pedido) ________________))
        (T                               (list (car pedido) ________________))))
```

---

### PARTE B: Operaciones sobre la Lista de Pedidos (Nivel TP4 y TP5)
Ahora el sistema recibe la lista completa de todos los pedidos del día:
```lisp
( (101 (COLOMBIA MEDIO) GRANDE 3500 4)
  (102 (BRASIL FUERTE) CHICO 2800 14)
  (103 (ETIOPIA SUAVE) MEDIANO 4200 8)
  (104 (COLOMBIA FUERTE) MEDIANO 3800 16)
  (105 (BRASIL MEDIO) GRANDE 3200 5) )
```

> **¡ATENCIÓN!** Antes de codificar cada función de abajo, marcá qué herramienta vas a usar y por qué. Si no podés justificarlo, todavía no arranques a tipear.

---

#### Consigna 4: Clasificación Masiva de Tiempos
*Desarrollar una función `informe-tiempos` que, a partir de la lista de pedidos, devuelva una lista donde cada elemento sea la clasificación de su tiempo de espera `(ID_PEDIDO ETIQUETA)` (reutilizando la función de la Consigna 3).*

- Herramienta elegida: `[  ] MAPCAR   /   [  ] RECURSIÓN`
- *¿Por qué?:* .........................................................................................................................

*Espacio para tu código:*
```lisp
(defun informe-tiempos (lista-pedidos)
    (________________ 'clasificar-espera lista-pedidos))
```

---

#### Consigna 5: Calcular Total Recaudado en el Día
*Desarrollar una función `recaudacion-total` que, a partir de la lista de pedidos, calcule la suma total en pesos de los precios de todos los cafés servidos.*

- Herramienta elegida: `[  ] MAPCAR   /   [  ] RECURSIÓN`
- *¿Por qué?:* .........................................................................................................................
- *Caso base:* Si la lista está vacía, devuelve: `______`

*Espacio para tu código:*
```lisp
(defun recaudacion-total (lista-pedidos)
    (cond
        ((null lista-pedidos) ______)
        (T (+ (obtener-precio (car lista-pedidos))
              (recaudacion-total (cdr lista-pedidos))))))
```

---

#### Consigna 6: Filtrar los Pedidos de Café Colombiano
*Desarrollar una función `pedidos-colombianos` que reciba la lista de pedidos y devuelva una nueva lista formada **únicamente por las sublistas completas** de aquellos pedidos cuyo grano sea de Colombia (reutilizando `es-colombia-p`).*

- Herramienta elegida: `[  ] MAPCAR   /   [  ] RECURSIÓN`
- *¿Por qué?:* .........................................................................................................................
- *Caso base:* Si la lista está vacía, devuelve: `______`

*Espacio para tu código:*
```lisp
(defun pedidos-colombianos (lista-pedidos)
    (cond
        ((null lista-pedidos) ______)
        ((es-colombia-p (car lista-pedidos))
            (cons (car lista-pedidos)
                  (pedidos-colombianos (cdr lista-pedidos))))
        (T
            (pedidos-colombianos (cdr lista-pedidos)))))
```

---

#### Consigna 7: Contar Pedidos con Demora Excesiva
*Desarrollar una función `contar-demorados` que reciba la lista de pedidos y una cantidad de minutos máxima permitida por parámetro, y determine cuántos pedidos demoraron más que ese tiempo.*

- Herramienta elegida: `[  ] MAPCAR   /   [  ] RECURSIÓN`
- *¿Por qué?:* .........................................................................................................................

*Espacio para tu código:*
```lisp
(defun contar-demorados (lista-pedidos tiempo-limite)
    (cond
        ((null lista-pedidos) 0)
        ((> (obtener-tiempo (car lista-pedidos)) tiempo-limite)
            (+ 1 (contar-demorados (cdr lista-pedidos) tiempo-limite)))
        (T
            (contar-demorados (cdr lista-pedidos) tiempo-limite))))
```

---

#### Consigna 8: Predicado Universal (¿Todos los pedidos fueron Express?)
*Desarrollar una función predicado `todos-express-p` que verifique si **absolutamente todos** los pedidos de la lista tuvieron un tiempo de espera de 5 minutos o menos.*

- Herramienta elegida: `[  ] MAPCAR   /   [  ] RECURSIÓN`
- *¿Por qué?:* .........................................................................................................................
- *Caso base:* Si la lista está vacía (o llega al final sin encontrar ninguno demorado), devuelve: `______`

*Espacio para tu código:*
```lisp
(defun todos-express-p (lista-pedidos)
    (cond
        ((null lista-pedidos) ______)
        ((> (obtener-tiempo (car lista-pedidos)) 5) ______)  ;; Corte temprano
        (T (todos-express-p (cdr lista-pedidos)))))
```

---

#### Consigna 9: Precios con Descuento por Promoción (MAPCAR + Lambda con Cierre Léxico)
*Desarrollar una función `aplicar-promo` que reciba la lista de pedidos y un porcentaje de descuento (por ejemplo `0.15` para el 15%), y retorne una nueva lista con los precios finales calculados para cada pedido.*

- Herramienta elegida: `[  ] MAPCAR   /   [  ] RECURSIÓN`
- *¿Por qué?:* .........................................................................................................................

*Espacio para tu código:*
```lisp
(defun aplicar-promo (lista-pedidos porcentaje)
    (mapcar (lambda (pedido)
                (* (obtener-precio pedido) (- 1 porcentaje)))
            lista-pedidos))
```

---

### PARTE C: Función Menú Principal (Interacción y Validación)

#### Consigna 10: Función Principal `MENU-CAFETERIA`
*Desarrollar una función sin parámetros `menu-cafeteria` que:*
1. Declare las variables locales necesarias mediante `LET`.
2. Solicite al operador el ingreso de la lista completa de pedidos con `(read)`.
3. Solicite el tiempo límite de demora a controlar con `(read)`.
4. Valide que la lista sea una lista no vacía (`consp`) y que el tiempo límite sea un número (`numberp`).
5. Si los datos son válidos, imprima con mensajes alusivos los resultados de todas las funciones desarrolladas.
6. Si los datos no son válidos, muestre un mensaje de error descriptivo.

*Espacio para tu código:*
```lisp
(defun menu-cafeteria ()
    (let ((pedidos) (tiempo-max))
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

---

## 🏁 Lista de Chequeo Final (Antes de Dar por Terminado un Examen)
- [ ] ¿Los nombres de las llamadas recursivas coinciden exactamente letra por letra con el `defun`?
- [ ] ¿Todos los casos base están **primeros** en el `cond`?
- [ ] ¿Usaste `0` para contar/sumar y `nil` para armar listas con `cons`?
- [ ] ¿Todas las recursiones avanzan usando `(cdr lista)`?
- [ ] ¿No usaste ninguna variable global (`setq` fuera de `let`)?
- [ ] ¿No anidaste ningún `if` dentro de un `cond` ni viceversa?
- [ ] ¿Validaste que los símbolos se comparen con `equal` y no con `=`?
- [ ] ¿En los `MAPCAR`, el `lambda` recibe únicamente elementos de la lista y captura variables fijas por fuera?
