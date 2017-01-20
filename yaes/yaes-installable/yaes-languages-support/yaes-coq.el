;;; yaes-coq --- Coq related package setting of yaes
;;;
;;; Commentary:
;;;
;;; Code:

(require 'req-package)

(req-package coq-commenter
  :require (dash s cl-lib)
  :commands (coq-commenter-mode)
  :diminish coq-commenter-mode
  :bind
  (:map coq-mode-map
        ("C-;" . coq-commenter-comment-proof-in-region)
        ("C-x C-;" . coq-commenter-comment-proof-to-cursor)
        ("C-'" . coq-commenter-uncomment-proof-in-region)
        ("C-x C-'" . coq-commenter-uncomment-proof-in-buffer))
  :config
  (add-hook 'coq-mode-hook #'coq-commenter-mode))

(req-package company-coq
  :require (company-math company yasnippet dash cl-lib)
  :commands (company-coq-mode)
  :init
  (add-hook 'coq-mode-hook #'company-coq-mode))

(provide 'yaes-coq)
;;; yaes-coq.el ends here