(in-package :filetree)

(defclass folder (common-data)
  ((folders :accessor folder-folders :initform nil :type list)
   (files :accessor folder-files :initform nil :type list)))

(defmethod print-object ((f folder) (s stream))
  (if (not (eql s *weblocks-output-stream*))
      (call-next-method)
      (with-html-output (s)
        (:p (str (format s "Folder ~A" (data-name f)))))))