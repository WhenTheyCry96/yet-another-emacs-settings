;;; yaes-multiple-cursor --- multiple-cursor related package setting of yaes
;;;
;;; Commentary:
;;;
;;; Code:

(require 'req-package)

(req-package phi-search
  :demand
  :bind
  (("C-s" . phi-search)
   ("C-r" . phi-search-backward)))

(req-package multiple-cursors
  :require (cl-lib phi-search)
  :init
  (eval-after-load "multiple-cursors-core"
    '(progn
       (define-key mc/keymap (kbd "<return>") nil)
       (define-key mc/keymap (kbd "C-j") 'multiple-cursors-mode)))
  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-*" . mc/mark-all-like-this)))

(provide 'yaes-multiple-cursor)
;;; yaes-multiple-cursor.el ends here
