(load-r "c02/p129-generic-operator.scm")
;; Reasoner: 用apply-generic 求值 (magnitude z): 错误信息而不是5
;; Hacker: 认为需要添加 (put 'real-part '(complex) real-part) 等等
(define z (make-from-real-imag 3 4))

;; 报错
;; (apply-generic 'magnitude z)

(load-r "c02/p118-complex.scm")
;; 安装复数到通用
(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  ;; 复数构造函数来自于complex包
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ;; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  ;; 新加入到complex
  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  (put 'magnitude '(complex) magnitude)
  (put 'angle '(complex) angle)
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  )
(install-complex-package)
;; apply-generic 根据对象执行操作
(define (apply-generic op . args)
  (display (list op args))
  (newline)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No method for these types -- APPLY-GENERIC"
           (list op type-tags))))))
(apply-generic 'magnitude z)

;; 为什么这样是可行的?apply-generic被调用了几次?每次调用中分派的是哪个过程?
;; 两次,第一次调用得到结果magnitude,第二次调用得到结果magnitude.rectangular. 调用两次,分别调用install-complex-packge和install-rectangular-package
;; (magnitude (complex rectangular 3 . 4))
;; (magnitude (rectangular 3 . 4))
