(in-package :filetree)

(defwidget main-selector (on-demand-selector)
  ((menu-widget :accessor menu-widget :initarg :menu-widget :documentation "Shows main menu"))
  (:default-initargs :lookup-function #'main-selector-lookup-function)
  (:documentation "A toplevel dispatcher"))

(defun make-filetrees-page ()
  (make-instance 'filetree-widget))


(defmethod main-selector-lookup-function (selector tokens)
  (cond
    ((equal (first tokens) "tree")
     (values (make-filetrees-page) tokens nil))
    ((equal (first tokens) "test")
     (values (lambda (&rest args)
               (with-html (:div "This is a test page")))
             tokens nil))
    ((equal (first tokens) "admin")
     (values (make-admin-page) tokens nil))
    (t ;; Handle anything else
     (make-instance 
      'funcall-widget 
      :fun-designator 
      (lambda (&rest args)
        (render-widget (make-filetrees-page)))))))


(defun make-admin-page()
  (make-instance 
   'gridedit
   :name 'drives-grid
   ;;:class-store *filetree-memory-store*
   :data-class 'drive
   :widget-prefix-fn 
   (lambda (&rest args)
     (declare (ignore args))
     (with-html 
       (:div (:hr :style "margin: 2em;")
             (:a :href (webapp-prefix (weblocks::find-app "filetree")) "Go to home page"))
       (:div
        (:h1 "Add or delete drives"))))
   :on-add-item 
   (lambda (&rest args)
     (refresh-drives))
   :on-delete-item 
   (lambda (&rest args)
     (refresh-drives))
   :view 'drive-table-view
   :item-form-view 'drive-form-view
   ))
