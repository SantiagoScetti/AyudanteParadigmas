(defun P7 ()
  (let ((L nil))
    (format t "Ingrese lista: ")
    (setq L (read))
      (if (listp L)
          (mapcar (lambda (x)
                  (cond
                    ((not (listp x)) nil)
                    ((listp x) (list (length x)))
                    (t (print "error")))
                  )
          L)
          (print "error, debe ingresar una lista")
      )
  ))

              
    