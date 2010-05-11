(in-package :filetree)


(defclass drive (common-data)
  ((folders :accessor drive-folders :initform nil :type list)
   (files :accessor drive-files :initform nil :type list)))

(defun all-drives (&rest args)
  "return all objects of class DRIVE.  Args is an added argument that is ignored (needed for use in dropdown lists in views"
  (declare (ignore args))
  (find-persistent-objects (class-store 'filetree) 'drive))

(defun drive-by-id (id)
  (first
   (remove-if-not (lambda (drive)
                    (when (slot-boundp drive 'id)
                      (= id (slot-value drive 'id))))
                  (all-drives))))
