;;;file: problem1_2.lsp
;;;determine whether its contents form a palindrome

(defun palindrome_or_not(content)
    (equal content (reverse content)))

(defun palindrome(c)
    (if (palindrome_or_not c)
        (format t "~A form a palindrome.~%" c)
        (format t "~A do not form a palindrome.~%" c)
    )
)

(palindrome '(a b c ))
(palindrome '(m a d a m))
(palindrome '(cat dog))
(palindrome '())
(palindrome '(cat dog bird bird dog cat))


