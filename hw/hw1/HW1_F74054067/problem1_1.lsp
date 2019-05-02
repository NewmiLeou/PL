;;; file: problem1_1.lsp

;;;a boolean function forall which takes a list and a predicate and returns true if and only if the predicate returns true for every element in the list
(defun forall(list func)
    (if (null list)
        T
        (and (funcall func (car list))
            (forall (cdr list) func) )
    )
)


;;;returns a list of the numbers in the range start..stop inclusive
(defun nums(start stop)
    (setq L nil)
    (loop ( when(> start stop) (return (reverse L)) )
        (setq L (cons start L) )
        (incf start)    ;+1
    )
)


;;; checks whether the input number is a prime number
(defun prime_or_not(n)
    (and
    (> n 1)  ;picky case so we don't say numbers <=1 are prime
    ;;A number is prime if it is not divisible by any number in the range 2..(floor (sqrt n))
    (forall (nums 2 (floor (sqrt n)))
        #'(lambda (divisor) (not (= (mod n divisor) 0)))
    )
    )
)

;;;print the result
(defun prime(n)
    (if (prime_or_not n)
        (format t "~D is a prime number.~%" n)
        (format t "~D is not a prime number.~%" n)
    )
)

(prime 2)(prime 239)(prime 999)(prime 17)
