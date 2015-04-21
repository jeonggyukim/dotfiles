;;References
;;http://homepages.inf.ed.ac.uk/s0243221/emacs/
;;http://www.masteringemacs.org/article/mastering-key-bindings-emacs

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-fill-column t)
 '(column-number-mode t)
 ;; '(custom-enabled-themes (quote (solarized-dark)))
 ;; '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(delete-selection-mode t)
 '(inhibit-startup-screen t)
 '(mouse-wheel-mode t)
 '(setq transient-mark-mode t)
 '(show-paren-mode t)
 '(xterm-mouse-mode t)
 '(vc-follow-symlinks t))


; This is setting following video tutorials:
; Emacs as a C/C++ Editor/IDE (Part I): auto-complete, yasnippet, and auto-complete-c-headers
; http://youtu.be/HTUE03LnaXA
; Emacs as a C/C++ Editor/IDE (Part 2): iedit, flymake-google-cpplint, google-c-style
; http://youtu.be/r_HW0EB67eY
; Emacs as a C/C++ Editor/IDE (Part 3): cedet mode for true intellisense
; http://youtu.be/Ib914gNr0ys
;

; start package.el with emacs
(require 'package)
; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
; initialize package.el
(package-initialize)
; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)
(require 'yasnippet)
(yas-global-mode 1)
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;;latex setting
(require 'ac-math)
(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`

(defun ac-LaTeX-mode-setup () ; add ac-sources to default ac-sources
  (setq ac-sources
	(append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
		ac-sources))
  )
(add-hook 'LaTeX-mode-hook 'ac-LaTeX-mode-setup)
(global-auto-complete-mode t) 
(setq ac-math-unicode-in-math-p t)



; add ~/.emacs.d directory
(setq load-path (nconc '("~/.emacs.d") load-path)) ;; load-path

(load "~/.emacs.d/fill-column-indicator.el")
(load "~/.emacs.d/util.el")
;https://github.com/rejeep/drag-stuff.el
(load "~/.emacs.d/drag-stuff.el")


;; remap all key binds that point to tex-terminate-paragraph to
;; my-homemade-kill-line
(define-key (current-global-map) [remap tex-terminate-paragraph]
'newline-and-indent)

(setq ispell-program-name "/usr/local/bin/ispell")
(require 'drag-stuff)
(drag-stuff-global-mode 1)
(require 'fill-column-indicator)
(add-hook 'c-mode-hook 'turn-on-fci-mode)
;(add-hook 'LaTex-mode-hook 'turn-on-fci-mode)
;(setq fci-rule-width 1)
;(setq fci-rule-color "darkblue")
(setq tex-mode-hook 'turn-on-auto-fill)
(setq-default fill-column 70)
(if (display-graphic-p)
    (x-focus-frame nil))

;; (setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
;; (setq exec-path (append '("/usr/texbin") exec-path))
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)

;; ===== Make Text mode the default mode for new buffers =====
(setq default-major-mode 'text-mode)

;; <<<<<<< HEAD
;; (set-default-font "monaco-18")
;; =======

;; find aspell and hunspell automatically
(cond
 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")))
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-extra-args '("-d en_US")))
 )



;(set-default-font "monaco-18")
;;>>>>>>> 09650b26d91007f2f4a31ff02667f054991e4411
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
