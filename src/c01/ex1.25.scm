(define (expmod base exp m)
  (remainder (fast-exp base exp) m))
;; 采用其他技术也是对数级别的时间复杂度
