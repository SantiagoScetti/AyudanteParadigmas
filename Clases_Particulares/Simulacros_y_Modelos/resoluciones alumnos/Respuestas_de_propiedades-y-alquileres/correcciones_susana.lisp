; =============================================================================
; CORRECCIONES - SUSANA
; Ejercicio de propiedades:  REGISTRO = (ID_PROPIEDAD AMBIENTE VALOR_ALQUILER)
; =============================================================================
; Estado punto por punto:
;
;   P1 devolver-Propiedad  ANDA
;   P1 devolver-Ambiente   NO COMPILA: una coma en vez de punto y coma
;   P1 devolver-Valor      ANDA
;   P2 Predicado           compila, pero EXPLOTA al correr. Ademas no cumple la
;                          consigna: pide 3 parametros y la hizo con 1
;   P3 contar-...          NO CORRE: usa ID_PROOPIEDAD como si fuera variable
;   P3 existe-...          NO COMPILA: falta un parentesis
;   P4 filtrar-por-ambiente CORRE PERO NO FILTRA: devuelve todos los ID
;   P4 filtrar-economicas  no la hizo
;   P5 generar-informe     ANDA y la estructura esta bien. Umbral equivocado
;
; -----------------------------------------------------------------------------
; EL ERROR DE FONDO: NO REUTILIZA LO QUE YA TIENE
;
; En el punto 1 se definio tres funciones correctas para sacar cada dato. El
; enunciado del punto 3 dice, con todas las letras, "Utilizar las funciones
; definidas en el punto anterior". De ahi en adelante no las uso ni una vez:
;
;   1. En contar-Alquiler-accesible escribio (CADDAR lista) en vez de llamar a
;      (devolver-Valor (car lista)).
;
;   2. En existe-alquiler-exclusivo, en vez de usar la devolver-Valor que ya
;      tenia, la REDEFINIO:  (defun devolver-Valor (car lista) (cddr lista))
;      Esa linea rompe tres cosas a la vez:
;        - le puso DOS parametros, asi que la llamada de abajo, que le pasa uno
;          solo, da "Too few arguments (1 instead of at least 2)";
;        - al primer parametro lo llamo CAR, que es el nombre de una funcion de
;          LISP. Nunca ponerle a una variable el nombre de una funcion;
;        - devuelve (cddr lista), que es la LISTA (4500), no el numero 4500.
;          Con una lista, el (> ... 400000) de abajo tampoco iba a funcionar.
;      Y la que ya tenia andaba bien.
;
;   3. En el punto 4 volvio a REDEFINIR devolver-Ambiente, y al lado escribio
;      "use la funcion anterior". No la uso: la escribio de nuevo, y esta vez
;      sin la validacion que tenia la original.
;
;   4. En el mismo punto 4 uso (caar lista) en vez de
;      (devolver-Propiedad (car lista)), y en el punto 5 uso (caddr x) y (car x).
;
; POR QUE IMPORTA: si manana el enunciado cambia y el registro pasa a ser
; (ID AMBIENTE VALOR ANTIGUEDAD), con las funciones reutilizadas se toca UN solo
; lugar. Escribiendo car/cadr/caddr sueltos por todos lados hay que revisar
; funcion por funcion. Y como se vio aca, cada vez que reescribio una funcion
; que ya tenia, la escribio peor que la primera vez.
;
; LA REGLA PARA ESTE EJERCICIO: despues del punto 1, NO se vuelve a escribir
; car, cdr, cadr ni caddr sobre una propiedad. Todo sale de las tres funciones.
; =============================================================================


; =============================================================================
; PUNTO 1 - LOS TRES ACCESORES
; devolver-Propiedad y devolver-Valor estaban bien. A devolver-Ambiente solo le
; sobra una coma: escribio  ),defun  en vez de  );defun
; La coma en LISP no es un comentario, y fuera de un backquote es un error:
; "comma is illegal outside of backquote". El comentario va con PUNTO Y COMA.
;
; Se dejan con nombres mas cortos para que las llamadas de abajo se lean mejor.
; La validacion del largo va una sola vez, en el menu, no en cada accesor.
; =============================================================================
(defun devolver-id (propiedad)
    (car propiedad)
)

(defun devolver-ambiente (propiedad)
    (cadr propiedad)
)

(defun devolver-alquiler (propiedad)
    (caddr propiedad)
)


; =============================================================================
; PUNTO 2 - PREDICADO
; Lo que escribio:
;     (if (and (listp lista) (= (length lista) 3)
;              (> (cadr lista) 0) (> (caddr lista) 28000)))
;     (t nil)
;
;   - Al IF le falta el resultado. Quedo (if CONDICION) y nada mas, porque el
;     parentesis que cierra el AND cierra tambien el IF. Al correrla:
;     "too few parameters for special operator IF". Compila igual, por eso
;     parecia que estaba bien: el error aparece recien al llamarla.
;   - (t nil) quedo SUELTO, afuera del defun. LISP intenta ejecutar T como si
;     fuera una funcion: "undefined function T".
;   - Un predicado NO necesita IF ni COND: el AND ya devuelve T o NIL solo.
;   - La consigna pide TRES parametros (la propiedad, los ambientes buscados y
;     el importe) y lo hizo con uno, con el 28000 escrito a mano adentro. Asi la
;     funcion sirve para un solo caso.
;   - Y aca ya tenia que haber usado los accesores del punto 1.
; =============================================================================
(defun propiedad-buscada-p (propiedad ambientes tope)
    (and (= (devolver-ambiente propiedad) ambientes)
         (<= (devolver-alquiler propiedad) tope))
)


; =============================================================================
; PUNTO 3 - CONTAR ALQUILERES ACCESIBLES
; Lo que escribio:
;     ((< (CADDAR lista) 15000)
;      (+ 1 (devolver-Propiedad (cdr ID_PROOPIEDAD) (cdr ID_PROOPIEDAD))))
;     (t (contar-Alquiler-accesible (cdr ID_PROOPIEDAD) (cdr lista)))
;
;   - ID_PROOPIEDAD no es una variable: es el NOMBRE DEL CAMPO en el enunciado.
;     Adentro de la funcion el unico dato que existe es el parametro LISTA.
;     Al correrla: "variable ID_PROOPIEDAD has no value".
;   - En la rama que suma llamo a devolver-Propiedad (que devuelve un ID, no un
;     numero) donde iba la LLAMADA RECURSIVA a si misma. Contar es
;     "1 + lo que cuente el resto de la lista".
;   - La funcion recibe UN parametro, asi que las llamadas recursivas van con
;     uno solo: (cdr lista).
;   - El tope es 150000, no 15000. Le falto un cero.
;   - (CADDAR lista) es el accesor correcto, pero aca va (devolver-alquiler
;     (car lista)), que es lo que pide el enunciado.
;   - La rama ((not (listp lista)) nil) sobra y ademas esta despues del caso
;     base. Si hiciera falta validar, eso va una sola vez en el menu.
; =============================================================================
(defun contar-accesibles (lista)
    (cond
        ((null lista) 0)
        ((<= (devolver-alquiler (car lista)) 150000)
            (+ 1 (contar-accesibles (cdr lista))))
        (T (contar-accesibles (cdr lista)))
    )
)


; =============================================================================
; PUNTO 3 (segunda parte) - EXISTE ALQUILER EXCLUSIVO
; El razonamiento estaba BIEN: caso base NIL, corta con T apenas encuentra uno,
; y si no sigue con el resto. Es el molde correcto de "existe al menos uno".
; Fallo en dos cosas, ninguna de logica:
;   - Falta un parentesis al cerrar la rama (t ...). El interprete llega al
;     final del archivo esperando y avisa "input stream ends within an object".
;     Ese mensaje SIEMPRE significa que falta un parentesis.
;   - La devolver-Valor redefinida de la que se hablo arriba. Sacandola y
;     usando la original, esta funcion andaba.
; =============================================================================
(defun existe-exclusivo-p (lista)
    (cond
        ((null lista) NIL)
        ((> (devolver-alquiler (car lista)) 400000) T)
        (T (existe-exclusivo-p (cdr lista)))
    )
)


; =============================================================================
; PUNTO 4 - FILTRAR POR AMBIENTE
; Esta es la mas enganosa de todas: CORRE Y NO AVISA NADA, pero esta mal.
;
;     ((= (devolver-Ambiente (car lista)))
;
;   - El = quedo con UN SOLO argumento. En LISP (= x) con un solo valor
;     devuelve T SIEMPRE, porque "un numero es igual a si mismo". Entonces la
;     condicion se cumple en todas las vueltas y la funcion devuelve TODOS los
;     ID en vez de los que coinciden. Probado:
;         (filtrar-por-ambiente '((prop102 2 45000) (prop102 3 5000)
;                                 (prop103 4 600)))  ->  (PROP102 PROP102 PROP103)
;     Los tres, cuando con 2 ambientes tendria que haber devuelto uno solo.
;   - Falta el segundo parametro. Ella misma la probo con dos argumentos
;     (... 2), y asi da "too many arguments": la definicion tiene uno solo.
;     El numero de ambientes no cambia nunca, pero hay que volver a pasarlo en
;     CADA llamada recursiva.
;   - (caar lista) va reemplazado por (devolver-id (car lista)).
; =============================================================================
(defun filtrar-por-ambiente (lista ambientes)
    (cond
        ((null lista) NIL)
        ((= (devolver-ambiente (car lista)) ambientes)
            (cons (devolver-id (car lista))
                  (filtrar-por-ambiente (cdr lista) ambientes)))
        (T (filtrar-por-ambiente (cdr lista) ambientes))
    )
)


; =============================================================================
; PUNTO 4 (segunda parte) - FILTRAR PROPIEDADES ECONOMICAS
; NO LA HIZO. Es el mismo molde que la de arriba, con dos diferencias:
;   - la condicion compara el alquiler contra el monto;
;   - lo que se guarda con CONS es la SUBLISTA ENTERA (car lista), no el ID.
; =============================================================================
(defun filtrar-economicas (lista monto)
    (cond
        ((null lista) NIL)
        ((< (devolver-alquiler (car lista)) monto)
            (cons (car lista) (filtrar-economicas (cdr lista) monto)))
        (T (filtrar-economicas (cdr lista) monto))
    )
)


; =============================================================================
; PUNTO 5 - GENERAR INFORME
; LA MEJOR DE TODAS. El MAPCAR esta bien elegido, el LAMBDA recibe la propiedad
; entera y arma la sublista con LIST. Ese punto lo tiene.
; Dos cosas:
;   - El umbral: el enunciado dice PREMIUM con valor MAYOR O IGUAL a 250000, y
;     ella escribio (> ... 400000). Con 300000 su version dice ESTANDAR y
;     tendria que decir PREMIUM. Ojo con "mayor o igual": va >= y no >.
;   - Otra vez (caddr x) y (car x) en vez de las funciones del punto 1.
; Se saca la decision a una auxiliar: adentro del LAMBDA, un COND dentro de un
; LIST se vuelve ilegible.
; =============================================================================
(defun categoria (propiedad)
    (cond
        ((>= (devolver-alquiler propiedad) 250000) 'PREMIUM)
        (T 'ESTANDAR)
    )
)

(defun generar-informe (lista)
    (mapcar (lambda (propiedad)
                (list (devolver-id propiedad) (categoria propiedad)))
            lista)
)


; =============================================================================
; PARA PRACTICAR, EN ESTE ORDEN
;   1) Reescribir el punto 3 (contar-accesibles) sin mirar: es el molde mas
;      simple, caso base 0 y (+ 1 ...).
;   2) El punto 3b (existe-exclusivo-p): el mismo recorrido, pero cortando con T.
;   3) Recien despues los dos filtros del punto 4, que son el mismo molde con
;      CONS y con un parametro extra que hay que arrastrar.
; En los tres, la regla es la misma: NI UN car/cdr sobre una propiedad. Si
; necesita un dato, llama a la funcion del punto 1.
; =============================================================================


; =============================================================================
; DATOS DE PRUEBA
; (setq base '((PROP101 2 120000) (PROP102 3 450000) (PROP103 2 90000)
;              (PROP104 4 250000) (PROP105 3 500000)))
;
;   (devolver-id (car base))                 -> PROP101
;   (devolver-ambiente (car base))           -> 2
;   (devolver-alquiler (car base))           -> 120000
;   (propiedad-buscada-p (car base) 2 150000) -> T
;   (contar-accesibles base)                 -> 2    (PROP101 y PROP103)
;   (existe-exclusivo-p base)                -> T    (PROP102 y PROP105)
;   (filtrar-por-ambiente base 2)            -> (PROP101 PROP103)
;   (filtrar-economicas base 200000)         -> ((PROP101 2 120000)
;                                                (PROP103 2 90000))
;   (generar-informe base)                   -> ((PROP101 ESTANDAR)
;                                                (PROP102 PREMIUM)
;                                                (PROP103 ESTANDAR)
;                                                (PROP104 PREMIUM)
;                                                (PROP105 PREMIUM))
; =============================================================================
