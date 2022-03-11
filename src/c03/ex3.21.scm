(load-r "c03/p180-queue.scm")
(define (print-queue queue)
  (front-ptr queue))

(define q1 (make-queue))

(insert-queue! q1 'a)
(insert-queue! q1 'b)
(print-queue q1)
(delete-queue! q1)
(delete-queue! q1)

;; 之所以出现两次,是因为打印的时间是分别指向列表首尾的pair
