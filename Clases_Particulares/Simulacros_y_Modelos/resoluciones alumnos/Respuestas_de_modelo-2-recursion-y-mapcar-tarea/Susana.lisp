
Resolucion Punto 1 Predicado

lista ((5 bien 100)(6 danado 75)(8 bien 200)(2 bien 400)(10 danado 90))

1° elemento es la cantidad de dias que el libro estaba prestado 
2° elemento es un atomo que indica el estado de devolucion BIEN o DANADO
3° elemento es la cantidad de paginas del libro

a-Desarrolla una funcion predicado que a partir de la lista sera 
ingresado por parametro determine (si todos) los 
prestamos registrados fueron devuelto en buen estado BIEN

 (defun Predicado(lista)
    (car(cdr(car lista))) Bien 
    (car(cddr(cddr(cdr lista)))) DANADO
    (car(cddr(cddr(cdr lista)))) NIL
    (car(cddr(cddr(cdr lista)))) NIL
    (car(cdr(cddddr(cdr lista)))) Nil

(setq predicado'((5 bien 100)(6 danado 75)(8 bien 200)(2 bien 400)(10 dañado 90)))
((5 Bien 100))(car(cdr(car lista))) Resolucion = BIEN

(6 danado 75) (car(cdr(car(cdr lista)))) DANADO


(8 bien 200) (car(cddr(cddr(cdr lista)))) NIL


(2 bien 400) (car(cddr(cddr(cdr lista)))) NIL

 (10 dañado 90))) (car(cdr(cddddr(cdr lista)))) Nil  