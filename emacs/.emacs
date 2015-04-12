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
 '(vc-follow-symlinks t))

; add ~/.emacs.d directory
(setq load-path (nconc '("~/.emacs.d") load-path)) ;; load-path

(load "~/.emacs.d/fill-column-indicator.el")
(load "~/.emacs.d/util.el")
;https://github.com/rejeep/drag-stuff.el
(load "~/.emacs.d/drag-stuff.el")
;(load-theme 'solarized-dark t)

;; remap all key binds that point to tex-terminate-paragraph to
;; my-homemade-kill-line
(define-key (current-global-map) [remap tex-terminate-paragraph]
'newline-and-indent)

(setq ispell-program-name "/usr/local/bin/ispell")
(require 'drag-stuff)
(drag-stuff-global-mode 1)
(require 'fill-column-indicator)
(add-hook 'c-mode-hook 'turn-on-fci-mode)
(add-hook 'LaTex-mode-hook 'turn-on-fci-mode)
(setq fci-rule-width 1)
(setq fci-rule-color "darkblue")
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

(set-default-font "monaco-18")
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
