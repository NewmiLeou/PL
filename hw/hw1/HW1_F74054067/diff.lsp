;;;file: diff.lsp
;;;diff is an useful command on Unix-based system. You can use it to compare two files. It will show you the difference between them.

(defvar list1 nil)
(defvar list2 nil)

;; check if the element in list1 is equal to one element in list2
(defun same(element1)
    (dolist (element2 list2)
        (if (equal element1 element2)
            (return-from same T)))
    (return-from same nil))

;; read file1
(with-open-file
    (stream "file1.txt"
        :direction :input
        :if-does-not-exist nil)
    (loop for line1 = (read-line stream nil 'eof) until (eq line1 'eof)
        do (push line1 list1)))

;; read file2
(with-open-file
    (stream "file2.txt"
        :direction :input
        :if-does-not-exist nil)
    (loop for line2 = (read-line stream nil 'eof) until (eq line2 'eof)
        do (push line2 list2)))

;; compare two files
(setq list1 (reverse list1))
(setq list2 (reverse list2))
(dolist (element1 list1)
    (if (eq (same element1) T)
        (dolist (element2 list2)
            (if (equal element1 element2)
                ;; true:print same lines
                (progn
                    (format t " ~A~%" (pop list1))
                    (pop list2)
                    (return))
                ;; false:print c++ code
                (format t "~c[32m+~A~c[0m~%" #\ESC (pop list2) #\ESC)))  ;"~c[32mabc~c[0m~%" ---> green"abc"
        (format t "~c[31m-~A~c[0m~%" #\ESC (pop list1) #\ESC)))  ;red



