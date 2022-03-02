(define *op-table* (make-hash-table))

(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table/get *op-table* (list op type) #f))

(define *op-coercion-table* (make-hash-table))

(define (put-coercion op type proc)
  (hash-table/put! *op-coercion-table* (list op type) proc))

(define (get-coercion op type)
  (hash-table/get *op-coercion-table* (list op type) #f))
