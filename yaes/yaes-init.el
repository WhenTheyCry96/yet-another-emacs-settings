;;; yaes-init --- initializations of yaes
;;;
;;; Commentary:
;;;
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; Package Initializations
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)

(defvar yaes-package-archives
  '(("sunrise" . "http://joseito.republika.pl/sunrise-commander/")
    ("org" . "http://orgmode.org/elpa/")
    ("marmalade" . "https://marmalade-repo.org/packages/")
    ("melpa-stable" . "https://stable.melpa.org/packages/")
    ("melpa" . "https://melpa.org/packages/")))

(dolist (archive yaes-package-archives)
  (add-to-list 'package-archives archive))

;; ;;;; Do I really need to support emacs23?
;; (when (version< emacs-version "24")
;; 		     (add-to-list
;; 		      'package-archives
;; 		      '("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(defun yaes-install-required-package (package)
  "Install and require for new PACKAGE, and only require for old PACKAGE."
  (when (null (require package nil t))
    (progn
      (let* ((ARCHIVES (if (null package-archive-contents)
                           (progn
                             (package-refresh-contents)
                             package-archive-contents)
                         package-archive-contents))
             (AVAIL (assoc package ARCHIVES)))
        (when AVAIL
          (package-install package)))
      (require package))))

(yaes-install-required-package 'use-package)

(setq use-package-always-ensure t)
(setq use-package-always-pin ''melpa)

(use-package req-package)

(when init-file-debug
  (req-package--log-enable-debugging)
  (req-package--log-enable-messaging))

(req-package f
  :force t)

(when init-file-debug
  (print (current-time-string)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; Vanilla Emacs settings
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Language settings ( for Korean )
;;;;
(set-language-environment "Korean")
(prefer-coding-system 'utf-8)
;; For some -nix environment.
(global-set-key (kbd "S-SPC") 'toggle-korean-input-method)

;;;; Get rid of starting things
;;;;
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;;;; Default directory of windows
;;;;
(when (eq system-type 'windows-nt)
 (setq-default default-directory
               (concat (getenv "USERPROFILE") "\\Documents/"))
 (when (eq (buffer-name) "*scratch*")
   (setq default-directory
         (concat (getenv "USERPROFILE") "\\Documents/"))))

;;;; tab settings
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;;; keybinding for windows moving
(windmove-default-keybindings)

;;;; initial screen size
(set-frame-parameter nil 'fullscreen 'maximized)

;;;; remote access
(setq enable-remote-dir-locals t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; YAES directory settings
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst yaes-dir
  (f-dirname (f-this-file))
  "YAES base directory.")

;;;; Load all files in the packages directory
(req-package load-dir
  :pin gnu
  :force t
  :init (progn
          (setq load-dir-loaded '())))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; YAES external package loading
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst yaes-external-dir
  (f-join yaes-dir "yaes-external")
  "YAES external package directory.")

(load-dir-one yaes-external-dir)
;;;; yaes-external-dir is already deleted

(unintern 'yaes-external-dir nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; YAES developing package loading
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst yaes-developing-dir
  (f-join yaes-dir "yaes-developing")
  "YAES developing package directory.")

(load-dir-one yaes-developing-dir)
;;;; yaes-developing-dir is already deleted

(unintern 'yaes-developing-dir nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; YAES installable package loading
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst yaes-installable-dir
  (f-join yaes-dir "yaes-installable")
  "YAES installable package directory.
Those are installable via package manager.")

(load-dir-one yaes-installable-dir)
;;;; yaes-installable-dir is already deleted

(unintern 'yaes-installable-dir nil)

(when init-file-debug
  (print (current-time-string)))

(req-package-finish)

(when init-file-debug
  (print (current-time-string)))

(if (require 'yasnippet nil t)
    (progn
      (yas-recompile-all)
      (yas-reload-all)))

(when init-file-debug
  (print (current-time-string)))

;; Function for unbound symbols
(mapatoms (lambda (symbol)
	    (if (string-prefix-p "yaes-" (symbol-name symbol))
            (unintern symbol nil))))

(provide 'yaes-init)
;;; yaes-init.el ends here
