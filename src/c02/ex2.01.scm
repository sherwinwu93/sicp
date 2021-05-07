(load "p57-make-rat.scm")
;; 改进可以,处理正负问题
(define (make-rat n d)
  (let ((g (gcd n d))
        (n-pos (> n 0))
        (p-pos (> d 0)))
    (cond ((and n-pos p-pos) (cons (/ n g) (/ d g)))
          ((and n-pos (not p-pos)) (cons (- (/ n g)) (- (/ d g))))
          ((and (not n-pos) p-pos) (cons (/ n g) (/ d g)))
          ((and (not n-pos) (not p-pos)) (cons (- (/ n g)) (- (/ d g)))))))


(print-rat (make-rat -1 1))
(print-rat (make-rat 1 -1))
(print-rat (make-rat -1 -1))
(print-rat (make-rat 1 -1))

