(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-fill-column t)
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(inhibit-startup-screen t)
 '(mouse-wheel-mode t)
 '(setq transient-mark-mode t)
 '(show-paren-mode t)
 '(vc-follow-symlinks t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package Setup
;; A bit old but good article on package management in emacs:
;; http://batsov.com/articles/2012/02/19/\
;; package-management-in-emacs-the-good-the-bad-and-the-ugly/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; you can update all of the installed packages
;; by using the “U” key in the packages list view

(require 'package) ;; start package.el with emacs
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
;(add-to-list 'package-archives
;             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize) ; initialize package.el

(defvar local-packages
  '(auto-complete yasnippet 
    projectile epc jedi ein highlight-indentation python-mode
    xcscope
    ac-math)
  "A list of packages to ensure installed at launch")

(defun uninstalled-packages (packages)
  (delq nil
	(mapcar (lambda (p) (if (package-installed-p p nil) nil p)) packages)))

(let ((need-to-install (uninstalled-packages local-packages)))
  (when need-to-install
    (progn
      (package-refresh-contents)
      (dolist (p need-to-install)
	(package-install p)))))


;; load-path
;; add ~/.emacs.d directory
;;(setq load-path (nconc '("~/.emacs.d") load-path))
(load "~/.emacs.d/util.el")

;; drag-stuff
;; https://github.com/rejeep/drag-stuff.el
(load "~/.emacs.d/drag-stuff.el")
(require 'drag-stuff)
(drag-stuff-global-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; c-mode settings following video tutorials:
;; Emacs as a C/C++ Editor/IDE (Part I): auto-complete, yasnippet, and
;; auto-complete-c-headers: http://youtu.be/HTUE03LnaXA
;; Emacs as a C/C++ Editor/IDE (Part 2): iedit, flymake-google-cpplint,
;; google-c-style: http://youtu.be/r_HW0EB67eY
;; Emacs as a C/C++ Editor/IDE (Part 3): cedet mode for true intellisense:
;; http://youtu.be/Ib914gNr0ys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; yasnippet
;(require 'yasnippet)
;(yas-global-mode 1) ; yasnippet is always on

;; start auto-complete with emacs
(require 'auto-complete)
(require 'auto-complete-config) ;; do default config for auto-complete
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
;(setq ac-source-yasnippet nil)

;(define-key yas-minor-mode-map (kbd "<tab>") nil)
;(define-key yas-minor-mode-map (kbd "TAB") nil)
;(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)
; modify some keys
;(ac-set-trigger-key "TAB")
;(ac-set-trigger-key "<tab>")

;; cscope
;;(add-to-list 'load-path "~/.emacs.d/xcscope-20140510.1437")
(require 'xcscope)
(cscope-setup)
(setq cscope-do-not-update-database t)

;; iedit has a bug (in Mac)
(define-key global-map (kbd "C-c ;") 'iedit-mode) 

(which-function-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; you should additionally install jedi, epc modules
;; shell$ pip install jedi epc

(add-hook 'python-mode-hook 'jedi:ac-setup) ; if ac is all you need
;;Note that you must set jedi:setup-keys before loading jedi.el.
(setq jedi:setup-keys t)                      ; optional
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional

;; ;; http://tkf.github.io/emacs-jedi/latest/
;; ;; (jedi:goto-definition &optional other-window deftype use-cache index)
(setq jedi:goto-definition-config
      '((t   nil        t)        ; C-.
        (t   nil        nil)        ; C-u C-.
        (nil definition nil)        ; C-u C-u C-.
        (t   definition nil)        ; C-u C-u C-u C-.
        ...))

(require 'ein)
(setq ein:use-auto-complete t)
(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)
;;(add-hook 'ein:connect-mode-hook (load-theme 'hc-zenburn t))


;; (require 'python-mode)
;; (setq-default py-shell-name "ipython")
;; (setq-default py-which-bufname "IPython")
;;switch to the interpreter after executing code
;(setq py-shell-switch-buffers-on-execute-p nil)
;(setq py-switch-buffers-on-execute-p nil)
;; (setq py-split-windows-on-execute-p t)

;; ;; trying ipython tab completion: that works :)
;; (setq
;;  python-shell-interpreter "ipython"
;;  python-shell-interpreter-args ""
;;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;  python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
;;   python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
;;   python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
;;      )

(require 'highlight-indentation)
;(add-hook 'python-mode-hook 'highlight-indentation-mode)

;; Python Hook
(add-hook 'python-mode-hook '(lambda () 
 (setq python-indent 2)))

;;;;;;;;;;;;;;;;;;;;
;;;; latex settings
;;;;;;;;;;;;;;;;;;;;

;;ac-math latex setting
(require 'ac-math) ;; Auto-complete sources for input of mathematical symbols and latex tags
(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`
(defun ac-LaTeX-mode-setup () ; add ac-sources to default ac-sources
  (setq ac-sources
	(append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
		ac-sources))
  )
(add-hook 'LaTeX-mode-hook 'ac-LaTeX-mode-setup)
(global-auto-complete-mode t) 
(setq ac-math-unicode-in-math-p t)

;; remap all key binds that point to tex-terminate-paragraph to
;; my-homemade-kill-line
(define-key (current-global-map) [remap tex-terminate-paragraph]
'newline-and-indent)

;;; Set auto-fill and abbreviation for Text Mode
(setq tex-mode-hook 
      '(lambda nil 
         (setq fill-column 70)
         (auto-fill-mode 1)
         (abbrev-mode 1)))
(if (display-graphic-p)
    (x-focus-frame nil))

;; (setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
;; (setq exec-path (append '("/usr/texbin") exec-path))
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)

;;fill-column indicator
;;for some unknown reason, add-hook c-mode-hook turn-on-fci-mode does not work
;;if it appears before c-mode settings
(setq-default fill-column 80)
(load "~/.emacs.d/fill-column-indicator.el")
(require 'fill-column-indicator)
(setq fci-rule-color "darkblue")
(setq fci-rule-width 1)
(add-hook 'c-mode-hook 'turn-on-fci-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-fci-mode)
(add-hook 'LaTex-mode-hook 'turn-on-fci-mode)

;;find aspell and hunspell automatically
;;http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html
(cond
 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")))
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-extra-args '("-d en_US")))
 )


;; Make Text mode the default mode for new buffers
(setq default-major-mode 'text-mode)

;; set default fonts for macosx
(if (eq system-type 'darwin)
    (set-default-font "Monaco 18"))

(setq x-alt-keysym 'meta)

(if (string= system-name "gmunu.snu.ac.kr")
    (custom-set-faces
     '(default ((t (:family "Courier 10 Pitch"
			    :foundry "bitstream"
			    :slant normal :weight normal
			    :height 120 :width normal))))))


;How to turn off color-theme on terminal frame?
;(when (not (display-graphic-p)) (load-theme 'hc-zenburn t))
