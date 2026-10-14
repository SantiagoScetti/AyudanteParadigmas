(defun armo (A B)
    (cond 
        ((and (consp A) (consp B)) (append A B)) ;(APPEND LISTA LISTA ... LISTA SEXP) Crea una nueva lista concatenando dos o mas listas, solo acepta listas excepto en el ultimo elemento que puede ser lista o atomo, no crea listas impropias 
         ;  (APPEND '(A) '(B) '(C)) -> (A B C)  
         ;  (APPEND '(A) '(B C) '((D) (E))) -> (A B C (D) (E))


        ((and (consp A) (not (consp B))) (list A B)); (LIST SEXP SEXP) Devuelve lista formada por elementos pasados como argumentos, pueden ser listas o atomos, solo crea listas propias 
        ;(LIST 'A 'B 'C) -> (A B C)  
        ;(LIST 'A '(B C) '((D) (E)))-> (A (B C) ((D) (E)))

        ((and (not (consp A)) (consp B)) (cons A B)); (CONS SEXP SEXP) Crea una nueva estructura cons, acepta listas o atomos, si la segunda expresion es atomo crea una lista impropia: 
         ;(CONS 'A '(B C D))-> (A B C D)     
         ;(cons '(A B) 'C) -> (A B . C)


        (T (list A B))
    ))

(defun prints ()
    (progn 
        (pprint(armo (car '(+ 20 50)) (*(+ 3 2) 10))) ;(+ 50) 
        (pprint(armo '(* 7 10 (- 15 5)) (cdr '(+ 3 4)))); (* 7 10 (-15 5) 3 4) 
        (pprint(armo (+ 3 4) (Last '(* 7 10 (- 15 5))))); (7 (-155)) 
        (pprint (armo (member 3 '(+ 3 4)) (numberp 4)))); ((34) T)
)

