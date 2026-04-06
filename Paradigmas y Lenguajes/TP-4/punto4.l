4.'(21 45 62 32) '(11 10 9 7 8)
(defun resta-listas(l1 l2)
    (cond 
        ((or (endp l1) (endp l2)) nil)
        ((and (numberp (car l1)) (numberp (car l2))) (cons (- (car l1) (car l2)) (resta-listas (cdr l1) (cdr l2))))
        (t (resta-listas (cdr l1) (cdr l2))) 
    )
)