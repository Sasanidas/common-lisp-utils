(in-package :postabon-helper)

(defun curry (function &rest args)
  (lambda (&rest more-args)
    (apply function (append args more-args))))

(defun compose (&rest fns)
  (if fns
      #'(lambda (&rest args)
	    (reduce #'funcall (butlast fns)
		      :from-end t
		      :initial-value (apply (car (last fns)) args)))
      #'identity))

(defun pmapcar (f list)
  (let ((result (mapcar #'(lambda (n) 
			    (pcall:pexec (funcall f n))) 
			list)))
    (map-into result #'pcall:join result)))