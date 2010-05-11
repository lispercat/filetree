(in-package :filetree)

;; Define callback function to initialize new sessions
(defun init-user-session (comp)
  "callback function to initialize new sessions"
  (save-in-session 'filetree-widget (make-instance 'filetree-widget))
  (setf (composite-widgets comp)
        (make-instance 'main-selector)))

(defun restart-filetree ()
  (weblocks:reset-sessions)
  ;;(clean-store *filetree-memory-store*)
  ;;(cl-prevalence::totally-destroy *filetree-memory-store*)
  (filetree::stop-filetree)
  (filetree::start-filetree :port 3006))


;;(restart-filetree)
