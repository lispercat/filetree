(in-package :filetree)

;;; Multiple stores may be defined. The last defined store will be the
;;; default.
;(defstore *filetree-memory-store* :memory)

(defstore *filetree-prevalence-store* :prevalence
  (merge-pathnames (make-pathname :directory '(:relative "data"))
		   (asdf-system-directory :filetree)))

(defmethod class-store ((class-name (eql 'filetree)))
  (declare (ignore class-name))
  *filetree-prevalence-store*
  ;;*filetree-memory-store*
)
