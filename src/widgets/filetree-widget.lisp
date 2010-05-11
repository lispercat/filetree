(in-package :filetree)

(defwidget drive-widget ()
  ((drive :accessor drive :initarg :drive))
  (:documentation "widget to display a drive"))


(defmethod render-widget-body ((w drive-widget) &rest args)
  (let ((d (drive w)))
    (labels ((print-file (f)
             (with-html
               (:li (str (format nil "File: ~a" (data-name f))))))
             (print-folder (f)
               (with-html
                 (:li (str (format nil "Folder: ~a" (data-name f))))
                 (:ul
                  (dolist (f (folder-folders f))
                    (print-folder f)))
                 (:ul
                  (dolist (f (folder-files f))
                    (print-file f))))))
      (with-html
        (:div
         (:ul
          (:li 
           (:h1 (str (format nil "Drive: ~A" (data-name d))))
           (:ul
            (dolist (f (drive-folders d))
              (print-folder f)))
           (:ul
            (dolist (f (drive-files d))
              (print-file f))))))))))


(defwidget filetree-widget ()
  ((drives :accessor filetree-drives :initarg :drives :initform (make-instance 'composite)))
  (:documentation "Widget which can display all file tree structure"))

(defmethod initialize-instance :after ((obj filetree-widget) &key)
  (refresh-drives :the-widget obj))

(defun refresh-drives (&key the-widget)
  (let ((filetree-widget (or the-widget (get-from-session 'filetree-widget))))
    (let ((drive-list
           (mapcar (lambda (drive)
                     (make-instance 'drive-widget :drive drive))
                   (all-drives))))
      (setf (composite-widgets (filetree-drives filetree-widget)) drive-list))))



(defmethod render-widget-body ((w filetree-widget) &rest args)
  (with-html
    (:div
     (:a :href "/filetree/admin" "Edit your data tree"))
    (:h1 "Your data structure"))
  (dolist (item (composite-widgets (filetree-drives w)))
    (render-widget item)))