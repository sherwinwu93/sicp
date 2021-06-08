;; 实部`虚部`摸和幅角都可以是常规数值`有理数的复数,需要做什么修改
;; 答: 需要将复数的add-complex内部的+-*/替换成add/sub/mul/div
;;     对于模和幅角则需要将基本过程sin/cos替换成sine/cosine
