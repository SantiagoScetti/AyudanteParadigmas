-- Actividad 3.2.
-- Definir una función predicado llamada palíndromo, que indique si una lista ingresada por el
-- operador, es una lista palíndromo (se lee igual de izquierda a derecha y de derecha a izquierda).
-- Por ejemplo: ( I T A T I) es una lista palíndromo

(defun palindromo()
    (let ((palabra))

        (print"Ingresa una palabra para ver si es palíndromo")
        (setq palabra (READ))
        
        (if (and (listp palabra)(equal palabra (reverse palabra)))
            ("Si es palindromo ")
            ("No es palíndromo")
        )
    )
)


Actividad 3.3.
A partir de un determinado valor de temperatura, que será ingresado por el operador, definir una
función llamada clima que me indique el estado del clima, teniendo en cuenta:
Temperatura Clima
< 0 Helado
= 0 y < 10 Frio
= 10 y < 20 Templado
= 20 y < 30 Cálido
>30 Abrasador


(defun clima()
    (let ((Temperatura))
        (print"Ingresa la temperatura actual para emitir mensaje descriptivo")
        (setq Temperatura (READ))
        (cond
            ((NOT (numberp Temperatura)) (pprint "no pusiste un numero"))
            ((< Temperatura 0)(print "está heladoo"))
            ((or (equal Temperatura 0)(< Temperatura 10)) (print "ta fríiio"))
            ((or (equal Temperatura 10)(< Temperatura 20)) (print "está templado"))
            ((or (equal Temperatura 20)(< Temperatura 30)) (print "está Cálido"))
            (T (pprint "Abrasador"))
        )
    )
)



Actividad 3.4
Definir una función llamada mi-segundo, la que a partir de una lista y un átomo ingresados por el
operador deberá devolver una nueva lista donde el átomo ocupará la primera posición de la lista.
(Recuerde que las posiciones comienzan a contarse desde la 0)


(defun mi()
    (let ((lista1)(atomo1))

        (print"Ingresa una lista")
        (setq lista1 (READ))
        (print"Ingresa un atomo")
        (setq atomo1 (READ))

        (if (and (listp lista1)(atom atomo1))
            (print "datos ingresados correctamente" (nuevaLista lista1 atomo1))
            (pprint "datos ingresados incorrectamente")
        )
    )
)

(defun nuevaLista (lista1 atomo1)
    (cons atomo1 lista1)
)



Actividad 3.5
Definir una función llamada clasifico-triángulos, la que a partir de los valores de los lados de un
triángulo ingresados por el operador, clasifique el mismo en: isósceles, equilátero o escaleno. Tener
en cuenta que todo triangulo debe cumplir que. “Un lado es menor que la suma de los otros dos y
mayor que la diferencia”.

(defun clasi ()

    (l1 l2 l3)
    (print"Ingresa 2do lado")
    (setq l1 (READ))
    (print"Ingresa 2do lado")
    (setq l2 (READ))
    (print"Ingresa 3er lado")
    (setq l3 (READ))

    (cond
        ((not (and (numberp l1)(numberp l2)(numberp l3)) ) (print"todos los valores tienen que ser numericos"))
        ((and (< l1 0) (< l2 0) (< l3 0)) (print"todos los valores tienen que ser mayores a 0"))

        (NOT(or
            (and (< l1 (+ l2 l3))(> l1 (- l2 l3)(> l1 (- l3 l2))))
            (and (< l2 (+ l1 l3))(> l2 (- l1 l3))(> l2 (- l3 l1)))
            (and (< l3 (+ l2 l1))(> l3 (- l2 l1))(> l3 (- l1 l2)))
            )
        ) (print"algun lado está mal :c")

    (equal l1 l2 l3 ) (print"Es equilátero")

    )
)

Actividad 3.6 
Definir una función llamada mediano ̧ la que a partir de tres valores numéricos ingresados  por el 
operador,  devuelva  el  valor  mediano  (puede  ayudarse  con  las  funciones  max  y  min).  El  valor 
mediano será aquel que no es ni el mayor ni el menor valor. 

(defun mediano()
    (defun a b c)
    (print"Ingresa primer valor")
    (setq a (READ))
     (print"Ingresa segundo valor")
    (setq b (READ))
     (print"Ingresa tercer valor")
    (setq c (READ))

    calcularmed(a b c)


)

(defun calcularmed(a b c)
    (let ((min (min a b c)) (max (max a b c)))
        (cond
            ((and (< a max) (> a min)) a)
            ((and (< b max) (> b min)) b)
            ((and (< c max) (> c min)) c)
        )
    )
)