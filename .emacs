;; -*-Emacs-Lisp-*-
(set-background-color "black")
(set-foreground-color "white")

;;append Emacs Load Path
(setq load-path (cons "~/.emacs.d" load-path))

;;load PHP library
(load-library "php-mode")
(load-library "coffee-mode")
;; disable loading of "default.el" at startup
(setq inhibit-default-init t)

;; prevent auto saving and backup files
(setq-default auto-save-mode nil)
(setq-default make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)


;; custom macros
(fset 'html-to-php
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([101 99 104 111 32 34 5 34 left 92 110 right 59 down 1 tab] 0 "%d")) arg)))


;; set emacs to use the system clipboard
(setq x-select-enable-clipboard t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

;; change default font size
(set-face-attribute 'default nil :height 120)


;; Only scroll one line when moving
(setq scroll-step 1)
(setq scroll-conservatively 1)

;; Treat 'y' or <CR> as yes, 'n' as no.
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)
(define-key query-replace-map [?\C-m] 'act)

;; Misc
(setq transient-mark-mode t) ;; enable visual feedback on selections
(setq require-final-newline nil) ;; don't end a file with a newline

;; Meta key customizations
(global-set-key "\M-r" 'query-replace)
(global-set-key "\M-h" 'help-command)
(global-set-key "\M-r" '(lambda () (interactive) (load-file "~/.emacs"))) ;; reload .emacs

;; Key bindings
(global-set-key "\C-g" 'goto-line)
;; (global-set-key "\C-z" 'shell)
(global-set-key "\C-\M-u" 'nice)
(global-set-key "\M-y" 'emacs-clipboard-yank)
(global-set-key "\C-x w" 'replace-string)
(global-set-key [f1] 'manual-entry)
(global-set-key [f2] 'grep)
(global-set-key [f3] 'mark-whole-buffer)
(global-set-key [f4] 'indent-region)
(global-set-key [f5] 'split-window-horizontally)
(global-set-key [f6] 'split-window-vertically)
(global-set-key [f7] 'replace-string)
(global-set-key [f8] 'html-to-php)
(global-set-key [f12] 'save-buffer)

(global-set-key [home] `beginning-of-buffer)
(global-set-key [end] `end-of-buffer)

(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; Force tabs to be 4 spaces
;;(setq indent-tabs-mode t)
;;(setq default-tab-width 4)
;;(setq tab-width 4)
;;(setq c-basic-offset 4)

(setq c-backspace-function 'backward-delete-char)
;; Force php-mode to be default
;(setq default-major-mode 'php-mode)

(add-to-list 'auto-mode-alist '("\\.iva\\'" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.class\\'" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.tmpl\\'" . smarty-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . smarty-mode))
(add-to-list 'auto-mode-alist '("\\.xml\\'" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))
;;(require 'generic-x)
(when (locate-library "javascript")
  (autoload 'javascript-mode "javascript" nil t)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode)))
(when (locate-library "smarty")
  (autoload 'smarty-mode "smarty" nil t)
  (add-to-list 'auto-mode-alist '("\\.tmpl\\'" . smarty-mode)))

;; Set up indentation of php-mode
;;(defun my-php-indent ()
;;  (c-set-style "java")
;;  (setq tab-width 2)            ; tabs are 2 spaces
;;  (setq c-basic-offset 2)       ; basic offset 2 spaces
;;  (setq indent-tabs-mode t)) ; use spaces for indentation
;;(add-hook 'php-mode-hook 'my-php-indent)

(defun drupal-mode ()
  "Drupal php-mode."
  (interactive)
  (php-mode)
  (message "Drupal mode activated.")
  (c-set-offset 'case-label '+)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-close nil)
  (c-set-offset 'arglist-cont-nonempty 'c-lineup-math)

  ; More Drupal-specific customizations here
)

;; better xterm support
(defun xterm-setup-hook ()
  (define-key function-key-map "\e[1~" [home])
  (define-key function-key-map "\e[4~" [end]))
(setq term-setup-hook 'xterm-setup-hook)

;; add to php-mode hook
;(add-hook 'php-mode-hook 
;	  '(lambda ()
;	     (c-set-style "java")
;	     (setq tab-width 4)
;	     (setq c-basic-offset 4)
;	     (c-set-offset 'arglist-intro '+)
;	     (indent-tabs-mode nil)))


;(add-hook 'c-mode-common-hook (lambda ()
;                                (c-set-style "java")
;                                (setq tab-width 4)
;  (c-set-offset 'arglist-intro '+) ; arguments start indented by 1
;                                (indent-tabs-mode nil)))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;Replace all freakin' ^M chars in the current buffer
(fset 'replace-ctrlms
   [escape ?< escape ?% ?\C-q ?\C-m return ?\C-q ?\C-j return ?!])
(global-set-key "\C-cm" 'replace-ctrlms)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
