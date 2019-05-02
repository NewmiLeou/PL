;;;file: problem1_3.lsp
;;;Fibonacci function with original recursion and tail recursion


;;Original func. name : fib1
(princ "Original recursion:")
(format t "~%")
(defun fib1(n)
    "Compute the n'th Fibonacci number."
    (if (< n 2)
        n
        (+ (fib1 (- n 1)) (fib1 (- n 2)))))

(trace fib1)
(format t "~D~%~%" (fib1 3))

;;Tail func. name : fib2
(princ "Tail recursion:")
(format t "~%")
(defun fib_nto2(a b n)
     (if (= n 0)
          a
          (fib_nto2 b (+ a b) (- n 1))))
(defun fib2(n)
    (fib_nto2 0 1 n))

(trace fib2)
(format t "~D~%" (fib2 8))



