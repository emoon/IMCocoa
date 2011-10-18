;;; TODO: Fix Some ugly hard-coded paths here for testing

(cffi:define-foreign-library imcocoa-lib 
  (:darwin (:or "~/code/IMCocoa/tundra-output/macosx-gcc-debug-defalut/libIMCocoa.dylib"
                "libIMCocoa.dylib")))

(cffi:use-foreign-library imcocoa-lib)

;; App

(cffi:defcfun ("IMCocoa_appCreate" imcocoa-app-create) :void ())
(cffi:defcfun ("IMCocoa_appRun" imcocoa-app-run) :void ())
(cffi:defcfun ("IMCocoa_appDestroy" imcocoa-app-destroy) :void ())

;; Windows

(cffi:defcfun ("IMCocoa_windowCreate" imcocoa-window-create) :pointer
	(name :string)
	(callback :pointer)
	(user-data :pointer))

(cffi:defcfun ("IMCocoa_windowDestroy" imcocoa-window-destroy) :void
	(handle :pointer))

;;; Controls

(cffi:defcfun ("IMCocoa_buttonCall" imcocoa-button) :int
	(id :int)
	(name :string) 
	(x :int) 
	(y :int) 
	(w :int) 
	(h :int))

