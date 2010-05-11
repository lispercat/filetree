(in-package :filetree)

(defclass common-data ()
  ((id)
   (name :accessor data-name :initarg :name :initform nil :type string)
   (description :accessor data-description :initarg :description :initform nil)))



