;; ------------------------------------------------------------ 3.5 流
;; ------------------------------------------------------------ 3.5.1 流作为延时的表
;; (cons-stream x y)
;; (stream-car s)
;; (stream-cdr s)
;; the-empty-stream
;; stream-null?
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))
(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
		   (stream-map proc (stream-cdr s)))))
(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
	     (stream-for-each proc (stream-cdr s)))))
;; stream-for-each对考察流非常有用
(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x)
  (newline)
  (display x))
;; 流和常规表数据抽象完全一样,不同点在于元素的求值时间
;; promise
;; (delay exp) => promise
;; (force promise) => exp
(define (cons-stream a b)
  (cons a (delay b)))
(define (stream-car stream)
  (car stream))
(define (stream-cdr stream)
  (force (cdr stream)))
(define the-empty-stream ())
(define (stream-null? stream) (null? stream))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))
;; (cons 10000 (delay (stream-enumerate-interval 10001 1000000)))
(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
	((pred (stream-car stream))
	 (cons-stream (stream-car stream)
		      (stream-filter pred
				     (stream-cdr stream))))
	(else (stream-filter pred (stream-cdr stream)))))
;; ------------------------------------------------------------ delay和force的实现
(define (delay proc)
  (memo-proc (lambda() proc)))
(define (force delayed-object)
  (delayed-object))
(define (memo-proc proc)
  (let ((already-run? false) (result false))
    (lambda()
      (if (not already-run?)
	  (begin (set! result (proc))
		 (set! already-run? true)
		 result)
	  result))))
;; ------------------------------ ex3.50 stream-map的推广
;; (define (stream-map proc . argstreams)
;;   (if (stream-null? (car argstreams))
;;       the-empty-stream
;;       (cons-stream
;;        (apply proc (map stream-car argstreams))
;;        (apply stream-map
;; 	      (cons proc (map stream-cdr argstreams))))))
;; ------------------------------ ex3.51
(define (show x)
  (display-line x)
  x)

;; 按执行顺序 0 1 2 3 4 5 6 7 8 9 10
(define x (stream-map show (stream-enumerate-interval 0 10)))

;; 从第0个开始算,5
(stream-ref x 5)
(stream-ref x 7)
;; ------------------------------ ex3.52
(define sum 0)
;; sum=0
(define (accum x)
  (set! sum (+ x sum))
  sum)
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
;; sum=210
(define y (stream-filter even? seq))
(define z (stream-filter (lambda(x) (= (remainder x 5) 0))
			 seq))
(stream-ref y 7)
(display-stream z)
sum
;; 上面表达式求值后sum的值210,
;; stream-ref ,第8个偶数, display-stream z ,所有整除5的数的序列
;; 不使用memo-proc会有不同.因为原来accum执行20次, 不使用accum执行210次.这就是赋值带来的复杂性
