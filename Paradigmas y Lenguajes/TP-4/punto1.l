;; 1
(defun temp-menos-38 (max-enero)
  (cond
    ((endp max-enero) 0)
    ((and 
        (numberp (car max-enero)) (< (car max-enero) 38)) 
        (+ 1 (temp-menos-38 (cdr max-enero))))
    (t (temp-menos-38 (cdr max-enero)))))

;; 2
(defun temp-promedio (max-enero)
  (/ (suma-recursiva max-enero) (length max-enero)))

(defun suma-recursiva (max-enero)
  (cond
    ((null max-enero) 0)
    (t (+ (car max-enero) (suma-recursiva (cdr max-enero))))))

;; 3
(defun orden-ascendente (temp)
  (cond
    ((or (null temp) (null (cdr temp))) t)
    ((> (car temp) (cadr temp)) nil)
    (t (orden-ascendente (cdr temp)))))

;; 4
(defun eliminar-repetidos (temp)
  (cond
    ((null temp) nil)
    ((member (car temp) (cdr temp)) (eliminar-repetidos (cdr temp)))
    (t (cons (car temp) (eliminar-repetidos (cdr temp)))))
)