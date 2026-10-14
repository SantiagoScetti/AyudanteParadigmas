(defun P3 ()
  (let ((L nil))
    (print "Ingrese lista: ")
    (setq L (read))
    (if (listp L)
        (mapcar 'numberp L)
        (pprint "Ingresar lista"))))
 

(defun es-numero-a-si-no (x)
  (if x 'SI 'NO))

(defun P4 ()
  (let ((L nil))
    (format t "Ingrese lista: ")
    (setq L (read))
    (if (listp L)
        (mapcar (lambda (x) (es-numero-a-si-no (numberp x))) L)
        (pprint "Ingresar lista"))))



(defun p5 ()
  (let ((L nil) (exponente 0))
    (print "Ingrese una lista no vacía: ")
    (setq L (read))
    (print "Ingrese un número entero: ")
    (setq exponente (read))
    
    (if (and (consp L) (integerp exponente))
            (mapcar (lambda (x)
                      (cond
                        ((numberp x) (list (expt x exponente)))
                        (t nil)))
                    L)
            (pprint "error"))))              
                                            

(defun P6 ()
  (let ((L nil))
    (format t "Ingrese lista: ")
    (setq L (read))
    (if (listp L)
        (mapcar (lambda (x) 
                  (cond 
                    ((not (numberp x)) nil)
                    ((> x 0) (list x '> 0))
                    ((< x 0) (list x '< 0))
                    (t (list x '= 0))))
                L)
        (pprint "error"))))
        

(defun P7 ()
  (let ((L nil))
    (format t "Ingrese lista: ")
    (setq L (read))
    (if (listp L)
        (mapcar (lambda (x)
                  (cond
                    ((not (listp x)) nil)
                    ((listp x) (list (length x)))
                    (t (print "error"))))
                L)
        (print "error"))))

              
    