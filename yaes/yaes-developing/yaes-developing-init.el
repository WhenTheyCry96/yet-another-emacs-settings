;;; yaes-developing-init --- initializations of under-developing packages of yaes
;;;
;;; Commentary:
;;;
;;; Code:

(require 'f)
(require 'load-dir)

(defconst yaes-developing-dir
  (f-dirname (f-this-file))
  "YAES developing package directory.")

(defconst yaes-developing-packages
  (f-directories yaes-developing-dir)
  "YAES developing packages list.")

(mapc 'load-dir-one yaes-developing-packages)

(unintern 'yaes-developing-dir nil)
(unintern 'yaes-developing-packages nil)

(provide 'yaes-developing-init)
;;; yaes-developing-init.el ends here
