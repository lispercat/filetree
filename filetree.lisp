
(defpackage #:filetree
  (:use :cl :weblocks :cl-who :f-underscore :anaphora)
  (:import-from :hunchentoot #:header-in
		#:set-cookie #:set-cookie* #:cookie-in
		#:user-agent #:referer)
  (:documentation
   "A web application based on Weblocks."))

(in-package :filetree)

(export '(start-filetree stop-filetree))

;; A macro that generates a class or this webapp

(defwebapp filetree
    :prefix "/filetree"
    :description "filetree: A new application"
    :init-user-session 'filetree::init-user-session
    :autostart nil                   ;; have to start the app manually
    :ignore-default-dependencies nil ;; accept the defaults
    :debug t
    )

;; Top level start & stop scripts

(defun start-filetree (&rest args)
  "Starts the application by calling 'start-weblocks' with appropriate
arguments."
  (apply #'start-weblocks args)
  (start-webapp 'filetree))

(defun stop-filetree ()
  "Stops the application by calling 'stop-weblocks'."
  (stop-webapp 'filetree)
  (stop-weblocks))

