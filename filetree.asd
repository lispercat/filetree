;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-
(defpackage #:filetree-asd
  (:use :cl :asdf))

(in-package :filetree-asd)

(defsystem filetree
    :description "File tree builder"
    :name "filetree"
    :version "0.0.1"
    :maintainer ""
    :author "Andrei Stebakov"
    :licence "LLGPL"
    :description "filetree"
    :depends-on (:weblocks)
    :components ((:file "filetree")
                 (:module conf
                          :components ((:file "stores"))
                          :depends-on ("filetree"))
                 (:module src
                          :depends-on ("filetree" conf)
                          :components
                          ((:file "utils")
                           (:file "init-session" :depends-on ("layout"))
                           (:file "presentations" :depends-on ("model"))
                           (:file "views" :depends-on ("model" "presentations"))
                           (:file "layout" :depends-on ("model"))
                           (:module model
                                    :components
                                    ((:file "common-classes")
                                     (:file "drive" :depends-on ("common-classes"))
                                     (:file "file" :depends-on ("common-classes"))
                                     (:file "folder" :depends-on ("common-classes"))))
                           (:module widgets
                                    :components
                                    ((:file "common-widgets")
                                     (:file "filetree-widget"))
                                    :depends-on ("model"))))))

