(in-package :filetree)

(defclass file (common-data)
  ((type :accessor file-type :initform :text :initarg :type)))
