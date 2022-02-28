(load-r "lib/attach-tag.scm")
;; ------------------------------ 2.74
;; 公司和多个分支
;; 分支多个人事记录
;; 人事记录: key雇员名称
;; 雇员记录: 名称 address salary
;; a. 实现get-record
;;  特定文件,提取雇员记录
(define (get-record files username)
  (get 'get-record (type-tag files) username))
;; b. get-salary过程
