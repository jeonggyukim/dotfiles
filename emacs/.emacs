;;References
;;http://homepages.inf.ed.ac.uk/s0243221/emacs/

(custom-set-variables
 '(auto-fill-column t)
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(inhibit-startup-screen t)
 '(mouse-wheel-mode t)
 '(setq transient-mark-mode t)
 '(show-paren-mode t))

; add ~/.emacs.d directory
(setq load-path (nconc '("~/.emacs.d") load-path)) ;; load-path
(load "~/.emacs.d/fill-column-indicator.el")
(load "~/.emacs.d/util.el")

(add-hook 'latex-mode-hook '(lambda ()
  (local-set-key (kbd "\C-j") 'newline-and-indent)))

(setq ispell-program-name "/usr/local/bin/ispell")

(require 'fill-column-indicator)
(add-hook 'c-mode-hook 'fci-mode)
(add-hook 'LaTex-mode-hook 'fci-mode)
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

(define-key input-decode-map "\e[1;2D" [S-left])
(define-key input-decode-map "\e[1;2C" [S-right])
(define-key input-decode-map "\e[1;2B" [S-down])
(define-key input-decode-map "\e[1;2A" [S-up])
(define-key input-decode-map "\e[1;2F" [S-end])
(define-key input-decode-map "\e[1;2H" [S-home])

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

(set-default-font "monaco-18")
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
