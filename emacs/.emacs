(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-fill-column t)
 '(delete-selection-mode t)
 '(inhibit-startup-screen t)
 '(mouse-wheel-mode t)
 '(setq transient-mark-mode t)
 '(vc-follow-symlinks t)
 '(column-number-mode t)
 '(show-paren-mode t)
; '(xterm-mouse-mode t)
)

;; Make Text mode the default mode for new buffers
(setq default-major-mode 'text-mode)

;; load-path
;; add ~/.emacs.d directory
(setq load-path (nconc '("~/.emacs.d") load-path)) 
(load "~/.emacs.d/util.el")

;; drag-stuff
;; https://github.com/rejeep/drag-stuff.el
;; (load "~/.emacs.d/drag-stuff.el")
(require 'drag-stuff)
(drag-stuff-global-mode 1)

;; fill-column indicator
(setq-default fill-column 80)
;(load "~/.emacs.d/fill-column-indicator.el")
(require 'fill-column-indicator)
(setq fci-rule-color "darkblue")
(setq fci-rule-width 1)
(add-hook 'c-mode-hook 'turn-on-fci-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-fci-mode)
(add-hook 'LaTex-mode-hook 'turn-on-fci-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; c-mode Settings following video tutorials:
;; Emacs as a C/C++ Editor/IDE (Part I): auto-complete, yasnippet, and
;; auto-complete-c-headers: http://youtu.be/HTUE03LnaXA
;; Emacs as a C/C++ Editor/IDE (Part 2): iedit, flymake-google-cpplint,
;; google-c-style: http://youtu.be/r_HW0EB67eY
;; Emacs as a C/C++ Editor/IDE (Part 3): cedet mode for true intellisense:
;; http://youtu.be/Ib914gNr0ys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; start package.el with emacs
(require 'package)
;; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; initialize package.el
(package-initialize)

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1) ; yasnippet is always on

;; start auto-complete with emacs
(require 'auto-complete)
;; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

;;let's define a function which initializes auto-complete-c-headers and gets
;;called for c/c++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-sources-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include:/usr/local/include")
  )
;;now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:acc-c-header-init)
(add-hook 'c-mode-hook 'my:acc-c-header-init)

;; to deal with complexity between yasnippet and auto-complete
;; see http://emacs.stackexchange.com/questions/2767/auto-complete-stops-working-with-c-files
(setq ac-source-yasnippet nil)

(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)
; modify some keys
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; cscope
(add-to-list 'load-path "~/.emacs.d/xcscope-20140510.1437")
(require 'xcscope)
(cscope-setup)
(setq cscope-do-not-update-database t)

;; iedit has a bug
(define-key global-map (kbd "C-c ;") 'iedit-mode) 

(which-function-mode 1)

;;;;;;;;;;;;;;;;;;;;
;;;; latex settings
;;;;;;;;;;;;;;;;;;;;

;; ;;ac-math latex setting
;; (require 'ac-math) ;; Auto-complete sources for input of mathematical symbols and latex tags
;; (add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`
;; (defun ac-LaTeX-mode-setup () ; add ac-sources to default ac-sources
;;   (setq ac-sources
;; 	(append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
;; 		ac-sources))
;;   )
;; (add-hook 'LaTeX-mode-hook 'ac-LaTeX-mode-setup)
;; (global-auto-complete-mode t) 
;; (setq ac-math-unicode-in-math-p t)


;; remap all key binds that point to tex-terminate-paragraph to
;; my-homemade-kill-line
(define-key (current-global-map) [remap tex-terminate-paragraph]
'newline-and-indent)

(setq ispell-program-name "/usr/local/bin/ispell")

(setq tex-mode-hook 'turn-on-auto-fill)
(if (display-graphic-p)
    (x-focus-frame nil))

;; (setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
;; (setq exec-path (append '("/usr/texbin") exec-path))
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)

;; find aspell and hunspell automatically
(cond
 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")))
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-extra-args '("-d en_US")))
 )

(if (eq system-type 'darwin)
    (set-default-font "Monaco 18"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
