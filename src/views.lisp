(in-package :filetree)

(defview drive-table-view (:type table :inherit-from '(:scaffold drive))
  (id :hidep t)
  (folders :present-as (list :data-slot-accessor 'drive-folders :label-key 'data-name))
  (files :present-as (list :data-slot-accessor 'drive-files :label-key 'data-name)))


(defview drive-data-view (:type data :inherit-from '(:scaffold drive))
  (id :hidep t)
  (folders :hidep t))

(defview drive-form-view
  (:type form
         :inherit-from '(:scaffold drive)
         :default-fields-suffix-fn
         (lambda (view drive &rest args)))

  (id :hidep t)
  (folders :hidep t)
  (files :hidep t)
  (name :present-as input :requiredp t)
  (description :present-as (textarea :cols 60 :rows 3))
  (folders :present-as (one-to-many-field
                         :data-class 'folder
                         :data-slot-accessor 'drive-folders
                         :form-view 'folder-form-view))
  (files :present-as (one-to-many-field
                         :data-class 'file
                         :data-slot-accessor 'drive-files
                         :form-view 'file-form-view)))

(defview folder-form-view (:type form :inherit-from '(:scaffold folder))
  (id :hidep t)
  (folders :present-as (one-to-many-field
                         :data-class 'folder
                         :data-slot-accessor 'folder-folders
                         :form-view 'folder-form-view))
  (files :present-as (one-to-many-field
                         :data-class 'file
                         :data-slot-accessor 'folder-files
                         :form-view 'file-form-view)))

(defview file-form-view (:type form :inherit-from '(:scaffold file))
  (id :hidep t)
  (type :present-as (radio :choices '(:text :binary))
        :parse-as keyword))
