(in-package :filetree)

(defclass one-to-many-field-presentation (presentation)
  ((data-class :accessor presentation-data-class :initarg :data-class :initform nil)
   (data-slot-accessor :accessor presentation-data-slot-accessor :initarg :data-slot-accessor :initform nil)
   (form-view :accessor presentation-form-view :initarg :form-view :initform nil)))

(defmethod render-view-field-value (value (presentation one-to-many-field-presentation)
				    field view widget data &rest args
				    &key highlight &allow-other-keys)
  (declare (ignore highlight args))
  (with-slots (data-class data-slot-accessor form-view) presentation
    (add-edit-one-to-many-link data data-class data-slot-accessor form-view)
    (with-html
      (:div
       (dolist (item (get-field data data-slot-accessor))
         (with-slots (name description) item
           (htm (:h1 (str (format nil "~A; ~A" name description))))))))))


(defclass list-presentation (presentation)
  ((data-slot-accessor :accessor presentation-data-slot-accessor :initarg :data-slot-accessor :initform nil)
   (label-key :accessor presentation-label-key :initarg :label-key :initform nil)))

(defmethod render-view-field-value (value (presentation list-presentation)
				    field view widget data &rest args
				    &key highlight &allow-other-keys)
  (declare (ignore highlight args))
  (with-slots (data-slot-accessor label-key) presentation
    (render-dropdown
     (view-field-slot-name field)
     (loop for i in (get-field data data-slot-accessor) collect (funcall (fdefinition label-key) i)))))
