# GUÍA DE PRÁCTICA — EXTRAORDINARIO LISP
### Cómo abarcar TODO lo que puede llegar a entrar

Esta carpeta no busca que memoricen *un* modelo, sino que dominen los **ladrillos** con los que se arma cualquier parcial. El enunciado cambia (drones, sensores, pacientes, electrolineras…), pero las técnicas son siempre las mismas. Si reconocés el ladrillo, resolvés cualquier consigna.

---

## 1. Cómo usar esta carpeta

1. Leé esta guía completa una vez (sección 3 y 4 son el corazón).
2. Resolvé el **Parcial A** (dos listas paralelas) **a mano, sin mirar la solución**. Recién después compará con `parcial-A-dos-listas-SOLUCION.lsp`.
3. Hacé lo mismo con el **Parcial B** (registros con sublista anidada).
4. Practicá el anexo `extras-teoria-y-trazado.md` (teoría + "qué devuelve esta función").
5. Cuando algo no salga, buscá el **patrón** correspondiente en la sección 4 y volvé a intentarlo.

> Regla de oro de la cátedra: *programá con sentido común, no adivinando qué quiere el profe.* Las técnicas de abajo son las que enseñan; con eso alcanza.

---

## 2. Qué cubre cada parcial

| Técnica | A | B | C |
|---|:---:|:---:|:---:|
| Predicado sobre átomos (T/NIL) | ✅ P1 | ✅ P2 | — |
| Predicado **universal** ("¿TODOS cumplen?") | — | — | ✅ P1 |
| Acceso a registro con **sublista anidada** | — | ✅ P1-P3 | — |
| Estado descriptivo con `COND` reutilizando un predicado | — | ✅ P3 | — |
| `MAPCAR` sobre **una** lista | — | ✅ P4 | ✅ P4,P5 |
| `MAPCAR` sobre **dos** listas paralelas | ✅ P2 | — | — |
| `MAPCAR` → **SI/NO** (predicado por elemento) | — | — | ✅ P4 |
| `MAPCAR` → **clasificación por tramos** | — | — | ✅ P5 |
| Recursión: **contar** con condición / parámetro | ✅ P3 | — | ✅ P3 |
| Recursión: **sumar / total** | ✅ P6b | ✅ P4 | — |
| Recursión: **promedio** (suma + conteo) | ✅ P6b | — | — |
| Recursión: **máximo / mínimo** (acumulador) | ✅ P4a, P6a | ✅ P6a | — |
| Recursión: **¿existe al menos uno?** (corte temprano) | ✅ P4b | ✅ P5 | — |
| Recursión: **filtrar** → nueva lista | — | — | ✅ P2 |
| Recursión: **partición** → `((g1)(g2))` | — | — | ✅ P2 |
| Recursión sobre **dos listas en paralelo** | ✅ P3, P6 | — | — |
| **Distribución** / contar por categoría | — | ✅ P6b | — |
| **Quitar repetidos** | — | — | ✅ P7a |
| **¿Ordenada?** (comparar consecutivos) | — | — | ✅ P7b |
| Lista **heterogénea + átomo** → sublistas | — | — | ✅ P7c |
| Función **principal**: leer + validar + integrar | ✅ P5 | ✅ P5 | ✅ P6 |

Entre los **tres** parciales tocás **todas** las estructuras de datos que la cátedra usó alguna vez:
- lista plana de números → *Parcial A* (dentro de las dos listas) y *Parcial C*
- lista plana + **un parámetro suelto** → *Parcial C* (familia del Segundo Parcial 2023)
- **dos listas paralelas** → *Parcial A* (lo nuevo del recu)
- registro `(ID (sub lista) ...)` con campos anidados → *Parcial B*
- lista de registros / lista de sublistas → *Parcial B*
- lista de pares `(ID ETIQUETA)` → *Parcial B P6b*
- lista **heterogénea** (átomos + sublistas) → *Parcial C P7c*

> **Cómo practicar las tres juntas:** hacé A y C completas (son las que más se parecen a lo que están tomando ahora), y B para el formato "registro". Si te sobra tiempo, mezclá: agarrá un punto de cada una y armá tu propio parcial Frankenstein.

---

## 3. Mapa de técnicas: cómo reconocer qué te están pidiendo

| Si la consigna dice… | Te piden el patrón… | Herramienta |
|---|---|---|
| "función predicado", "determine si…", "evalúe si…" | Predicado (devuelve T/NIL) | `and` / `or` / `cond` |
| "si **todas/todos** cumplen…", "todas las cajas…" | Predicado **universal** | recursión que corta con **NIL** |
| "¿hay alguno que…?", "**al menos uno**", "existe" | Predicado **existencial** (corte temprano) | recursión que corta con **T** |
| "retorne `(ID ESTADO)`", "estado descriptivo" | Clasificar con etiqueta | `cond` + `list` |
| "una nueva lista donde cada elemento…", "usando MAPCAR" | Transformar 1 a 1 | `mapcar` |
| "para cada uno, SI o NO / mensaje según…" | `MAPCAR` con `cond` adentro | `mapcar` + `lambda` |
| "compare/combine las dos listas", "cada posición N" | Recorrer 2 listas | `mapcar` con 2 listas **o** recursión doble |
| "cuántos…", "cantidad de…", "menor o igual a X" | Contar con condición | recursión `+ 1` |
| "total", "suma de…" | Acumular suma | recursión `+` |
| "promedio" | Suma ÷ Conteo | dos recursiones |
| "el mayor", "el de máximo…", "el pico" | Máximo | recursión con acumulador |
| "**solo** los que…", "filtrar", "nueva lista con los que cumplen" | Filtrar | recursión con `cons` |
| "una formada por… **y otra** formada por…", "dos sublistas" | **Partición** | dos filtros + `list` |
| "cuántos hay de cada tipo", "distribución" | Contar por categoría | contadora parametrizada |
| "ordenada", "ascendente", "de menor a mayor" | Comparar **consecutivos** | recursión `car` vs `cadr` |
| "simétrica", "palíndromo", "primero = último" | Simetría | `reverse` / primero vs último |
| "sin repetidos", "diferentes", "una sola vez" | Quitar repetidos | `member` + `cons` |
| "solicite al operador", "ingrese", "valide" | Función principal | `let` + `read` + `if` + `progn` |

---

## 4. PLANTILLAS reutilizables (los ladrillos)

> Copiá la forma, cambiá los nombres y la condición. **Todas** respetan las reglas: recursión, sin variables globales, sin `let` fuera de la principal, sin anidar `if` con `cond`, predicados que devuelven T/NIL.

### 4.1 Predicado sobre átomos
```lisp
;; Devuelve T/NIL. Validá numberp para no explotar con datos heterogéneos.
(defun en-rango-p (valor minimo maximo)
    (and (numberp valor)
         (>= valor minimo)
         (<= valor maximo)))
```

### 4.2 Acceso a un registro con sublista anidada
```lisp
;; Dada  (ID  CAMPO  (A  B  C)  OTRO)
;;   (car  est)            -> ID
;;   (cadr est)            -> CAMPO
;;   (caddr est)           -> (A B C)      la sublista
;;   (cadddr est)          -> OTRO
;;   (car   (caddr est))   -> A
;;   (cadr  (caddr est))   -> B
;;   (caddr (caddr est))   -> C
;; SIEMPRE deducí las posiciones del enunciado; el orden cambia entre parciales.
```

### 4.3 Estado descriptivo (clasificar) reutilizando un predicado
```lisp
(defun estado (est)
    (cond
        ((en-rango-p (valor est) (minimo est) (maximo est)) (list (id est) 'OK))
        ((< (valor est) (minimo est))                       (list (id est) 'BAJO))
        (T                                                  (list (id est) 'ALTO))))
;; La 1ra rama que da T gana: por eso el caso "OK" (ya resuelto por el predicado)
;; va primero y no hace falta repetir su condición.
```

### 4.4 MAPCAR sobre UNA lista
```lisp
;; Transforma cada elemento. Devuelve una lista del mismo largo.
(defun estados-de-todos (lista)
    (mapcar 'estado lista))            ; 'estado y #'estado son equivalentes
```

### 4.5 MAPCAR sobre DOS listas paralelas  ← lo nuevo del recu
```lisp
;; mapcar toma un elemento de CADA lista por vez.
;; Si tienen distinto largo, se detiene en la más corta (seguro).
(defun marcar (lista1 lista2)
    (mapcar (lambda (a b)
                (cond
                    ((critico-p a b) 1)
                    (T 0)))
            lista1 lista2))

;; Caso típico: resta/suma elemento a elemento
(defun diferencias (l1 l2)
    (mapcar '- l1 l2))                  ; (diferencias '(10 20) '(3 5)) -> (7 15)
```

### 4.6 Recursión: CONTAR con condición
```lisp
(defun contar (lista)
    (cond
        ((null lista) 0)
        ((not (numberp (car lista))) (contar (cdr lista)))   ; salta basura
        ((cumple-p (car lista)) (+ 1 (contar (cdr lista))))
        (T (contar (cdr lista)))))
```

### 4.7 Recursión: SUMAR / total
```lisp
(defun sumar (lista)
    (cond
        ((null lista) 0)
        ((not (numberp (car lista))) (sumar (cdr lista)))
        (T (+ (car lista) (sumar (cdr lista))))))
```

### 4.8 Recursión: PROMEDIO (suma ÷ conteo, sin variables)
```lisp
(defun promedio (lista)
    (cond
        ((= (contar-todos lista) 0) 0)            ; evita división por cero
        (T (/ (sumar lista) (contar-todos lista)))))
;; Necesitás una contadora y una sumadora por separado (4.6 y 4.7).
```

### 4.9 Recursión: MÁXIMO con acumulador
```lisp
;; La auxiliar lleva "el mejor hasta ahora". El wrapper la arranca.
(defun mayor-desde (lista tope)
    (cond
        ((null lista) tope)
        ((not (numberp (car lista))) (mayor-desde (cdr lista) tope))
        ((> (car lista) tope) (mayor-desde (cdr lista) (car lista)))
        (T (mayor-desde (cdr lista) tope))))

(defun maximo (lista)
    (mayor-desde lista 0))             ; 0 sirve si los valores son >= 0
;; Para MÍNIMO: arrancá con un tope grande (ej. 999999) y usá <.
```

### 4.10 Recursión: ¿EXISTE al menos uno? (corte temprano)
```lisp
(defun hay-alguno-p (lista)
    (cond
        ((null lista) NIL)                          ; recorrí todo, no hubo
        ((cumple-p (car lista)) T)                  ; encontré: corto con T
        (T (hay-alguno-p (cdr lista)))))
```

### 4.11 Recursión: FILTRAR (construir lista con los que cumplen)
```lisp
(defun filtrar (lista)
    (cond
        ((null lista) NIL)                                       ; base: lista vacía
        ((cumple-p (car lista)) (cons (car lista) (filtrar (cdr lista))))
        (T (filtrar (cdr lista)))))                              ; lo descarta
;; Equivalente con función propia de LISP:  (remove-if-not 'cumple-p lista)
```

### 4.12 Recursión sobre DOS listas en paralelo
```lisp
;; Avanzás las dos con (cdr l1) y (cdr l2). El caso base corta si CUALQUIERA
;; se vacía -> nunca hacés (car) sobre NIL aunque tengan distinto largo.
(defun contar-criticas (l1 l2)
    (cond
        ((null l1) 0)
        ((null l2) 0)
        ((critico-p (car l1) (car l2)) (+ 1 (contar-criticas (cdr l1) (cdr l2))))
        (T (contar-criticas (cdr l1) (cdr l2)))))
```

### 4.13 Distribución: contar por categoría (contadora parametrizada)
```lisp
;; Una sola contadora que recibe la etiqueta buscada. Mejor que escribir
;; tres funciones casi iguales.
(defun contar-etiqueta (pares etiqueta)
    (cond
        ((null pares) 0)
        ((eq (cadr (car pares)) etiqueta) (+ 1 (contar-etiqueta (cdr pares) etiqueta)))
        (T (contar-etiqueta (cdr pares) etiqueta))))

(defun resumen (pares)
    (list 'BAJOS  (contar-etiqueta pares 'BAJO)
          'OK     (contar-etiqueta pares 'OK)
          'ALTOS  (contar-etiqueta pares 'ALTO)))
```

### 4.14 Función PRINCIPAL: leer + validar + integrar
```lisp
;; ÚNICO lugar donde se usan variables locales (let), para guardar lo leído.
;; Un solo IF (válido / no válido). En la rama válida, PROGN encadena las
;; impresiones. NO se anida IF con COND.
(defun principal ()
    (let (datos)
        (pprint "Ingrese la lista:")
        (setq datos (read))
        (if (listp datos)
            (progn
                (pprint (funcion-1 datos))
                (pprint (funcion-2 datos))
                (pprint (funcion-3 datos)))
            (pprint "Error: debe ingresar una lista"))))
;; Si pide DOS listas, usá  (let (l1 l2) ...)  con dos read,
;; y validá  (if (and (listp l1) (listp l2)) ...).
```

### 4.15 Construir una lista de sublistas a partir de un número
```lisp
;; Ej.: 150 invitados -> ((MESA 18) (SILLONES 37) (PUFF 75))
(defun lugares (invitados)
    (list (list 'MESA     (truncate (/ invitados 8)))
          (list 'SILLONES (truncate (/ invitados 4)))
          (list 'PUFF     (truncate (/ invitados 2)))))
;; truncate corta los decimales. (Si necesitás redondear hacia arriba, ceiling.)
```

### 4.16 Predicado UNIVERSAL (¿TODOS cumplen?)
```lisp
;; Corta con NIL apenas uno NO cumple. Base: lista vacía -> T.
(defun todos-cumplen-p (lista)
    (cond
        ((null lista) T)
        ((not (cumple-p (car lista))) NIL)
        (T (todos-cumplen-p (cdr lista)))))
;; Es el ESPEJO de "¿existe alguno?" (4.10): ahí cortás con T y la base es NIL.
```

### 4.17 PARTICIÓN en dos sublistas
```lisp
;; Dos filtros (uno por grupo) combinados con list. Cada filtro es el patrón 4.11.
(defun separar (lista)
    (list (solo-grupo-1 lista) (solo-grupo-2 lista)))
;; -> ((elementos del grupo 1) (elementos del grupo 2))
;; Un grupo puede ir transformado (ej.: el 2do dividido, en otra unidad, etc.).
```

### 4.18 MAPCAR con COND adentro (SI/NO o etiqueta por tramos)
```lisp
;; El lambda decide qué devolver por cada elemento. Un parámetro externo
;; (umbral) se "ve" dentro del lambda (cierre léxico: válido en XLISP).
(defun marcar (lista umbral)
    (mapcar (lambda (x)
                (cond
                    ((> x umbral) 'SI)
                    (T 'NO)))
            lista))

;; Variante "sublista con mensaje por tramos":
(defun clasificar (lista)
    (mapcar (lambda (x)
                (cond
                    ((<= x 20) (list x 'BAJO))
                    ((<= x 60) (list x 'MEDIO))
                    (T (list x 'ALTO))))
            lista))
```

### 4.19 Quitar repetidos
```lisp
;; Si el primero ya está en el resto, lo salto; si no, lo conservo.
(defun sin-repetidos (lista)
    (cond
        ((null lista) nil)
        ((member (car lista) (cdr lista)) (sin-repetidos (cdr lista)))
        (T (cons (car lista) (sin-repetidos (cdr lista))))))
```

### 4.20 ¿Ordenada? (comparar consecutivos)
```lisp
;; Compara cada elemento con el SIGUIENTE (car vs cadr).
(defun ascendente-p (lista)
    (cond
        ((null lista) T)
        ((null (cdr lista)) T)              ; un solo elemento: está "ordenada"
        ((> (car lista) (cadr lista)) NIL)
        (T (ascendente-p (cdr lista)))))
```

### 4.21 Simetría / palíndromo
```lisp
;; Una lista es simétrica si es igual a su reverso.
(defun simetrica-p (lista)
    (equal lista (reverse lista)))
;; (simetrica-p '(10 20 10)) -> T   ;   (simetrica-p '(10 20 30)) -> NIL
```

### 4.22 Lista heterogénea: trabajar solo con cierto tipo
```lisp
;; ¿Solo átomos? (predicado universal sobre atom)
(defun solo-atomos-p (lista)
    (cond
        ((null lista) T)
        ((not (atom (car lista))) NIL)
        (T (solo-atomos-p (cdr lista)))))

;; Longitudes SOLO de los elementos que son sublistas (filtra con consp + cons)
(defun longitudes-sublistas (lista)
    (cond
        ((null lista) nil)
        ((consp (car lista)) (cons (length (car lista)) (longitudes-sublistas (cdr lista))))
        (T (longitudes-sublistas (cdr lista)))))
```

### 4.23 Cálculo por tramos (escalonado) — función simple, sin recursión
```lisp
;; Una cuenta distinta según el rango. Típico de descuentos por cantidad.
(defun total-con-descuento (importe cantidad)
    (cond
        ((<= cantidad 150) importe)
        ((<= cantidad 200) (* importe 0.92))     ; 8% de descuento
        (T (* importe 0.88))))                    ; 12% de descuento
```

### 4.24 Ingreso por centinela (leer de a uno hasta FIN)
```lisp
;; Arma la lista leyendo de a uno hasta que el operador escribe FIN.
;; Es una función de entrada, por eso el let acá está permitido.
(defun pedir-numeros ()
    (pprint "Ingrese un numero (o FIN para terminar):")
    (let ((dato (read)))
        (cond
            ((equal dato 'FIN) nil)
            ((numberp dato) (cons dato (pedir-numeros)))
            (T (pprint "Dato invalido, intente de nuevo")
               (pedir-numeros)))))
;; En la principal:  (setq lista (pedir-numeros))
```

---

## 5. Errores que DESCUENTAN (checklist antes de entregar)

- [ ] ¿Usé **recursión** o `mapcar` para recorrer listas? (No bucles raros.)
- [ ] ¿Mis **predicados** devuelven `T`/`NIL` y nada más?
- [ ] ¿Contemplé el caso **lista vacía / NIL** en cada recursión? (sin esto → recursión infinita o error)
- [ ] ¿Validé **datos heterogéneos** (numberp / consp) donde corresponde?
- [ ] ¿La función **principal** valida la entrada antes de procesar?
- [ ] ¿Evité **variables globales**? (`setq` sobre algo no declarado en `let` crea una global → descuenta)
- [ ] ¿Usé `let` **solo** en la función principal, no en las auxiliares?
- [ ] ¿**No** anidé `IF` dentro de `COND` ni `COND` dentro de `IF`? (si una rama necesita decidir, sacá una función auxiliar — ver `extraer-id` en la solución del Parcial B)
- [ ] ¿`IF` para 2 ramas, `COND` para 1 o más? ¿`COND` en vez de `IF` anidados?
- [ ] ¿Nombres **descriptivos** y funciones **cortas** (una sola tarea cada una)?
- [ ] ¿Probé con casos del enunciado **y** casos límite (lista vacía, un solo elemento, dato basura)?

---

## 6. Mini-repaso teórico (entra en el cuestionario)

- **Paradigmas:** imperativo (describe *paso a paso* cómo) vs. declarativo (describe *qué* se quiere). Funcional y lógico son declarativos. El **lógico** se basa en cálculo de predicados / cláusulas de Horn.
- **Generaciones:** 1ra máquina · 2da simbólicos (ensamblador) · 3ra alto nivel independiente de la máquina · 4ta componentes prefabricados · 5ta IA.
- **Predicado:** función que devuelve un valor booleano (T/NIL).
- **Cons:** el bloque básico de LISP; un cons tiene `car` y `cdr`. Una **lista** es una cadena de cons que termina en `NIL`. Una **lista punteada** es cuando el `cdr` de un cons apunta a un **átomo** (no a otra lista ni a NIL).
- **Funciones destructivas** (`nconc`, `nreverse`, `delete`): modifican sus argumentos. Se prefieren las **no destructivas** (`append`, `reverse`, `remove`).
- **Las operaciones aritméticas NO modifican** sus argumentos.
- **Ámbito léxico** ≠ variables globales (las globales son de ámbito dinámico/especial).
- **Ciclo REPL del Lisp Listener:** Read → Eval → Print (en ese orden), repetido.

> Más preguntas resueltas en `extras-teoria-y-trazado.md`.
