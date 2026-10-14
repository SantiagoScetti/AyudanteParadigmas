;Analice la siguiente funcion:
(defun listas (a b)
 (cond
 ((and (consp a) (atom b)) (list a b))
 ((and (not (atom a)) (consp b)) (append a b))
 ((and (not (consp a)) (not (atom b))) (cons a b))
 (T (list a b))
 )
)

;a) Determinar el resultado que arrojaria si evalúo la misma con los siguientes parametros:
(listas (car '(+ 20 5 2)) (- (+ 3 12) 10))         ;-> (+ 5)                                      
(listas (cdr '(+ 3 (/ 16 4))) '(* 7 (- 15 5)))     ;-> (3 (/ 16 4) * 7 (- 15 5) )
(listas (> 13 9) (last '(* 3 8 (- 10 5))))         ;-> (T (- 10 5))
(listas (member 10 '(+ 13 4 10 7)) (evenp 4))      ;-> ((10 7) t)

;b) Identificar la cantidad y tipo de elementos (si son átomos o listas) de las listas resultantes en el punto a.

(+ 5)  ;->  2  atomos

(3 (/ 16 4) * 7 (- 15 5) )   ;->  3  atomos  2 SUBLISTAS
 
(T (- 10 5)) ;->  1  atomo  1 SUBLISTA

((10 7) t)  ;->  1  atomo  1 SUBLISTA