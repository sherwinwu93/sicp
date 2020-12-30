(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
	 (sum term (next a) next b))))

(define (sum-cubes a b)
  (sum cube a 1+ b))
(define (cube x)
  (* x x x))

(cube 2)
(sum-cubes 0 3)
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))
  (define (odd? k)
    (= 1 (remainder k 2)))
(define (integral-new a b n)
  (define h (/ (- b a)
	       n))
  (define (cube-by-index k)
	   (cube (+ a
		    (* k h))))
  (define (term k)
    (cond ((or (= k 0) (= k n)) (cube-by-index k))
	  ((odd? k) (* 4 (cube-by-index k)))
	  (else (* 2 (cube-by-index k)))))
  (* (/ h 3)
     (sum term 0 1+ n)))
(integral cube 0 1 0.01)
(integral cube 0 1 0.001)
(integral-new  0 1.0 1000)
(integral-new  0 1.0 10000)




