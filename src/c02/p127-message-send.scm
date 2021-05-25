;; 智能数据对象
;; 将每一个数据对象表示为一个过程.以操作的名字作为输入,能够去执行指定的操作
(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude)
           (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else
           (error "Unknown op -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)
;; 通用型操作:只需将操作名告诉数据对象,并让那个对象工作
(define (apply-generic op arg) (arg op))
(apply-generic 'real-part (make-from-real-imag 3 4))
(apply-generic 'imag-part (make-from-real-imag 3 4))
(apply-generic 'magnitude (make-from-real-imag 3 4))
(apply-generic 'angle (make-from-real-imag 3 4))
