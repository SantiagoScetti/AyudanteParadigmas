MODELO 2 — RECURSIVIDAD Y MAPCAR

Alcance: foco en TP4 (recursividad) y TP5 (MAPCAR).

Ningún punto te dice qué herramienta usar
A diferencia de las prácticas anteriores, acá no vas a encontrar la palabra "recursividad" ni "MAPCAR" en las consignas. Decidir cuál corresponde en cada punto es parte del ejercicio. Antes de escribir una sola línea de código, escribí al lado de cada punto qué elegiste y por qué. Si no podés justificarlo en una frase, todavía no entendiste el punto.

Estructura de datos general:
Una biblioteca registra los préstamos de libros en una lista formada por sublistas, donde cada sublista posee tres elementos:
- El primer elemento es la cantidad de días que el libro estuvo prestado.
- El segundo elemento es un átomo que indica el estado de devolución: BIEN o DANADO.
- El tercer elemento es la cantidad de páginas del libro.

Se define el ritmo de lectura de un préstamo como la cantidad de páginas del libro dividida por la cantidad de días que estuvo prestado.

================================================================================

Consigna a)
Desarrollar una función predicado, la que a partir de la lista que será ingresada por parámetro, determine si todos los préstamos registrados fueron devueltos en buen estado (BIEN).

Respuesta a)

(defun Pa (L)
  (cond
    ((null L) T)
    ((not (cadar (car L))) Nil); que estas queriendo negar?? ((not (equal (cadar L) 'BIEN)) NIL)?
    (T (Pa (cdr L))))
  )
; lo demas bien
================================================================================

Consigna b)
Desarrollar una función, la que a partir de la lista y una cantidad de días, ambos ingresados como parámetros, determine la cantidad de préstamos cuya duración superó la cantidad de días ingresada.

Respuesta b)
(defun Pb (L D)
  (cond
    ((null L) 0)
    ((not (numberp (car L))) (Pb (cdr L) D));(car L) NO son los dias
    ((> (car L) D) (+ 1 (Pb (cdr L) D)))
    (T (Pb (cdr L) D))))
; ver correccion en el otro archivo
================================================================================

Consigna c)
Desarrollar una función que permita determinar la cantidad total de préstamos registrados en la lista.

Respuesta c)
(defun Pc (L)
  (cond
    ((listp L) 0); no se controla asi el final de lista!!
    ((car (cadr (cadr L))) + 1)
    (T (Pc (cdr L)))))
; ver correccion en el otro archivo

================================================================================

Consigna d)
Desarrollar una función, la cual a partir de la lista ingresada como parámetro, devuelva una nueva lista formada solamente por la cantidad de páginas de cada libro.

Respuesta d)
(defun Pd (L)
  (cond
    ((numberp (last L)) nil); last de l va a ser el último prestamo 
    ((car (last L)) nil)
    (T (Pd (cdr L)))))
; no hace lo que pide el ejercicio
; ver correccion en el otro archivo !

================================================================================

Consigna e)
Definir una función, la cual a partir de la lista ingresada como parámetro, devuelva una nueva lista solamente por las sublistas de los préstamos devueltos DANADO.

Respuesta e)
(defun Pe (L)
  (mapcar (lambda (x)
            (cond
              ((consp x) T) ; no es lo que se pide
              ((list (= x (= (cadr L) Dañado))) nil) ; quiero lista de sublistas no resultados t o nil
              (T (Pe (cdr L)))))
          L))
; = solo compara NUMEROS. Para comparar simbolos se usa EQUAL.
; ver correccion en el otro archivo !
================================================================================

Consigna f)
Definir una función, la que a partir de la lista que será ingresada por parámetro, devuelva una nueva lista formada por mensajes según el ritmo de lectura de cada préstamo:
- "lento", si el ritmo es menor o igual a 20 páginas por día.
- "normal", si el ritmo es mayor a 20 y menor o igual a 60 páginas por día.
- "veloz", si el ritmo es mayor a 60 páginas por día.

Respuesta f)
Ritmo = Cantidad Pzg / Días P

(defun Ritmo (L)
  (cond
    ((consp L) nil)
    ((/ (cadr (last L)) (car L)) nil)
    (T (Ritmo (cdr L)))))

(defun Pf (L)
  (mapcar (lambda (x)
            (cond
              ((not (consp x)) nil)
              ((and (<= Ritmo x 20) "lento") (and (> Ritmo 20) (<= Ritmo 60))); este esta mal armado para el normal fiajte en el otro archivo
              (T "veloz")
            )
          )
          L))

================================================================================

Consigna g)
Desarrollar una función que, a partir de la lista ingresada como parámetro, devuelva una única sublista: la del préstamo con mayor ritmo de lectura de entre todos los que fueron devueltos en buen estado (BIEN). Si en la lista no hay ningún préstamo devuelto BIEN, la función debe devolver NIL.

Respuesta g)
(defun Bien (L)
  (if (consp L)
      (cond
        ((Atomp L) T)
        ((= (cadr L) Bien) nil)
        (+ (Bien (cdr L))))))

(defun Pg (L)
  (mapcar (lambda (x)
            (cond
              ((consp x) nil)
              ((list (= Bien (> Ritmo 60))) T)))
          L))
;el punto pide devolver UNA SOLA sublista y hay que
; COMPARAR los prestamos entre si. MAPCAR no puede hacer ninguna de
; las dos cosas: devuelve una lista y mira cada elemento aislado.
; Va recursion acá

; ver correccion en el otro archivo !

================================================================================

Consigna h)
Desarrollar una función que reciba como parámetros dos listas: la lista de préstamos y una segunda lista, de igual longitud, con los nombres de los socios que retiraron cada libro (en el mismo orden). La función debe devolver una nueva lista en la que cada elemento sea una sublista de la forma (SOCIO RITMO OBSERVACION), donde:
- SOCIO es el nombre del socio correspondiente a ese préstamo.
- RITMO es el ritmo de lectura truncado a un número entero (usar floor).
- OBSERVACION es un átomo que vale:
    - RECLAMAR, si el libro fue devuelto DANADO.
    - MOROSO, si el libro fue devuelto BIEN pero estuvo prestado más de 30 días.
    - OK, en cualquier otro caso.

Respuesta h)
(defun observacion (LP)
  (let ((Bien) (Moroso 30) (OK))
    (cond
      ((consp LP) nil)
      ((and (= (car LP) Bien) (= (car LP) Moroso)) nil)
      (+ ok (observacion (cdr LP))))))

(defun Ph (LP LS)
  (mapcar (lambda (x y)
            ((consp x y) nil)
            ((list x (Floor y) observacion)))
          LP LS))

================================================================================

Consigna i)
Desarrollar una función Menú que permita al operador ingresar las listas y valores que sean necesarios y que llame a todas las funciones que se desarrollaron en los ejercicios anteriores.