(in-package :filetree)

(defwidget one-to-many-grid (gridedit)
  ((data
    :reader 	one-to-many-grid-data
    :initform 	nil
    :initarg 	:data
    :documentation "Parent data object which has other objects this grid will take care of")
   (data-slot-accessor
    :reader data-slot-accessor
    :initform nil
    :initarg :data-slot-accessor
    :documentation "Accessor to the parent's object slot containing a list of data which the grid will edit"))
  (:documentation "A gridedit to edit a data slot (list) of some data object"))


(defun add-edit-one-to-many-link (data data-class data-slot-accessor form-view)
  (render-link 
   (lambda (&rest args)
     (do-page
      (make-instance 
       'one-to-many-grid
       :data data
       :name 'one-to-many
       :data-class data-class
       :data-slot-accessor data-slot-accessor
       :widget-prefix-fn 
       (lambda (&rest args)
         (declare (ignore args))
         (with-html 
          (:div
           (:h1 (str (concatenate 'string "Add or delete " (string-downcase (symbol-name data-class)) "s"))))))
       :on-query
       (lambda (w order range &key countp) 
         (with-slots (data data-slot-accessor) w
           (if countp
               (length (get-field data data-slot-accessor))
               (get-field data data-slot-accessor))))
       :on-add-item
       (lambda (w new-item)
         (with-slots (data data-slot-accessor) w
           (append-to-field data data-slot-accessor new-item)))
       :on-delete-items
       (lambda (w items-ids-to-remove)
         (let ((items-to-remove
                (loop for item-id in (cdr items-ids-to-remove) collect 
                      (find-persistent-object-by-id (dataseq-class-store w)
                                                    (dataseq-data-class w)
                                                    item-id))))
           (with-slots (data data-slot-accessor) w
             (set-field data
                        data-slot-accessor
                        (remove-if (lambda (item) (member item items-to-remove)) 
                                   (get-field data data-slot-accessor))))))
                                                  
       :widget-suffix-fn 
       (lambda (w &rest args)
         (declare (ignore args))
         (render-link 
          (lambda (&rest args)
            (declare (ignore args))
            (answer w))
          "Done"))
       :item-form-view form-view)))
   (concatenate 'string "Edit " (string-downcase (symbol-name data-class)) "s")))




