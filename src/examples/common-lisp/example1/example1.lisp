
;;; TODO: Get rid of parent and id here

(cffi:defcallback ui-callback ((parent :pointer) (user-data: pointer))
  (when (imcocoa-button 1 parent "test" 10 20 20 20)
    (format t "yah!")))

(defun start-imcocoa-app ()
	(imcocoa-app-create)
	(imcocoa-window-create "foo" (cffi:callback ui-callback) 0)
	(imcocoa-app-run)
	(imcocoa-app-destroy))
