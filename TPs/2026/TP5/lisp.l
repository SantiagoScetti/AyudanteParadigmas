
(defun comparar-con-cero (lista)

    (mapcar (lambda (x)
            (cond 
                ((and (numberp x) (> x 0))(list x '> 0))
                ((and (numberp x) (< x 0))(list x '< 0))
                ((and (numberp x) (= x 0))(list x '= 0))
                (T(list x 'NO-ES-NUMERO))
            )
        )
    lista)
)
(-1 0 1 ñ)
((-1 < 0)(0 = 0)(ñ NO-ES-NUMERO))