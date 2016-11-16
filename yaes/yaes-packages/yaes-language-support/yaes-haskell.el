;;; yaes-haskell --- haskell support of yaes
;;;
;;; Commentary:
;;;
;;; Code:
(require 'req-package)

;; Mode for Haskell
(req-package haskell-mode
  ;; required emacs version : >= 24.3
  :require (cl-lib)
  ;; How about .lhs??
  :mode ("\\.l?hs\\'" . haskell-mode))

(req-package intero
  ;; required emacs version : >= 24.3
  :require (flycheck company haskell-mode)
  :commands (intero-mode)
  :init (add-hook-exec 'haskell-mode #'intero-mode)
  :config (progn
            (setq-default intero-repl-no-load nil)
            (setq-default intero-repl-no-build nil)))

;; ;; Plugin for flycheck with Haskell
;; (req-package flycheck-haskell
;;   ;; required emacs version : >= 24.3
;;   :require (flycheck haskell-mode dash seq let-alist)
;;   :commands (flycheck-haskell-setup)
;;   :init (add-hook-exec 'flycheck-mode #'flycheck-haskell-setup))

;; ;; Indentation support for haskell mode
;; (req-package hi2
;;   ;; required emacs version : ???
;;   :require (haskell-mode)
;;   :commands (turn-on-hi2)
;;   :init (add-hook-exec 'haskell-mode #'turn-on-hi2))

;; ;; Emacs binding for ghc-mod program
;; ;; Must install ghc-mod using "cabal install ghc-mod"
;; (req-package ghc
;;   ;; required emacs version : ???
;;   :require (haskell-mode)
;;   :commands (ghc-init ghc-debug)
;;   :init (add-hook-exec 'haskell-mode #'ghc-init))

;; ;; Plugin for flycheck using ghc-mod
;; (req-package flycheck-ghcmod
;;  ;; required emacs version : ???
;;  :require (flycheck dash haskell-mode))

;; ;; Backend plugin for company using ghc-mod
;; (req-package company-ghc
;;   ;; required emacs version : >= 24
;;   :require (cl-lib company ghc)
;;   :config (add-to-list 'company-backends #'company-ghc))

;; Plugin for yasnippet with haskell mode
(req-package haskell-snippets
  ;; required emacs version : ???
  :require (yasnippet))

(provide 'yaes-haskell)
;;; yaes-haskell.el ends here
