(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

(define (cube x)
  (* x x x ))
(define (p x)
  (- (* 3 x)
     (* 4 (cube x))))

(sine 12.15)
(write-to-string 'w)






