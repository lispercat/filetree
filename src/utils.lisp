(in-package :filetree)

(defun dbg-print (format &rest args)
  (if args
      (apply #'format t format args)
      (print format))
    (force-output))

(defun save-in-session (key data)
  (setf (webapp-session-value key)
	  data))

(defun get-from-session (key)
  (multiple-value-bind (data success)
      (webapp-session-value key)
    (if success data "err")))

(defun get-field (o accessor)
  (funcall (fdefinition accessor) o))

(defun set-field (o accessor new)
  (funcall (fdefinition `(setf ,accessor)) new o))

(defun append-to-field (o accessor el)
  (set-field o accessor (append (get-field o accessor) (list el))))