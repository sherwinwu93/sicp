;; Carmichael欺骗fermat测试
(load-r "c01/p34-fermat-test.scm")
(define (carmichael-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (define (test a)
    (cond ((= a n) true)
	  ((try-it a) (test (+ a 1)))
	  (else false)))
  (test 2))
(carmichael-test 561)
(carmichael-test 562)
(carmichael-test 1105)
(carmichael-test 1729)
(carmichael-test 2465)
(carmichael-test 2821)
(carmichael-test 6601)
	
    

