(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))

(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))

(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2)))
	 (pi-sum (+ a 4) b))))

(load-r "lib/sum.scm")
(define (sum-integers a b)
  (sum (lambda(x) x)
       a
       1+
       b))
(sum-integers 1 10)
(load-r "lib/math.scm")
(define (sum-cubes a b)
  (sum cube
       a
       1+
       b))
(sum-cubes 1 10)
(define (pi-sum a b)
  (sum (lambda(x) (/ 1.0 (* x (+ x 2))))
       a
       (lambda(x) (+ x 4))
       b))
(pi-sum 1 100)

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f
	  (+ a (/ dx 2.0))
	  add-dx
	  b)
     dx))
(integral cube 0 1 0.01)

(integral cube 0 1 0.001)
