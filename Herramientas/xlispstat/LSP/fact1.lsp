(defun fact (n)
       (cond ((zerop n) 1)
	     ((= n 1) 1)
	     (t (* n (fact (- n 1))))))
