;; ------------------------------------------------------------ 消息传递
;; 第一种策略:数据类型分派 表格按行分解,op type procedure,每个通用型操作看作一行.让每个操作管理自己的分派
;; 另一种策略:智能数据对象 表格换列分解
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
(define intelligent-data-object (make-from-real-imag 3 4))
(define (apply-generic op arg) (arg op))
(apply-generic 'real-part intelligent-data-object)
;; 这种风格叫消息传递
;; ------------------------------ ex2.75
;; 消息传递风格的make-from-mag-ang
(define (make-from-mag-ang m a)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* m (cos a)))
	  ((eq? op 'imag-part) (* m (sin a)))
	  ((eq? op 'magnitude) m)
	  ((eq? op 'angle) a)
	  (else
	   (error "Unknown op -- MAKE-FROM-MAG-ANG" op))))
  dispatch)
;; ------------------------------ex2.76
;; 三种策略
;;     1. 显式分派的通用型操作. 每个通用性操作,判断类型,选择实际操作(避免重名)
;;     2. 数据导向的风格. 按表的行来划分. op-type-procedure.方便加入新类型和新操作
;;     3. 消息传递风格. 将数据看作实体.方便加入新类型
;;  加入新类型或新操作,系统必须做的修改
;;      1. 修改分派代码 修改各个类型代码
;;      2. 增加并安装 修改各个类型代码,并重新安装
;;      3. 增加并修改分派代码 修改各个类型代码,但不影响旧系统
;;  最适合经常需要加入新操作的系统: 消息传递风格
;;      1. 增加新操作时需要使用者避免命名冲突,增加新类型,所有同样操作都需要做相应的的改动.
;;      2. 数据导向
;;      3. 方便加入新类型,但不方便加入新操作
