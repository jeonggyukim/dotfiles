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
 '(vc-follow-symlinks t)
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000)
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => ")
)


;; helpful references
;; https://gitlab.com/buildfunthings/emacs-config/blob/master/loader.org

(setq user-full-name "Jeong-Gyu Kim")
(setq user-mail-address "jgkim@astro.snu.ac.kr")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package Setup
;; A bit old but good article on package management in emacs:
;; http://batsov.com/articles/2012/02/19/\
;; package-management-in-emacs-the-good-the-bad-and-the-ugly/
;; you can update all of the installed packages
;; by using the “U” key in the packages list view
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Because the default setting for package-archives is to use the HTTP access to
;; the GNU archive, I set the variable to `nil` before adding the HTTPS
;; variants.
(require 'package) ;; start package.el with emacs
(defvar gnu '("gnu" . "https://elpa.gnu.org/packages/"))
(defvar melpa '("melpa" . "https://melpa.org/packages/"))
(defvar melpa-stable '("melpa-stable" . "https://stable.melpa.org/packages/"))
(setq package-archives nil)
(add-to-list 'package-archives melpa-stable t)
(add-to-list 'package-archives melpa t)
(add-to-list 'package-archives gnu t)
(package-initialize) ; initialize package.el

(defvar local-packages
  '(auto-complete yasnippet 
    projectile epc jedi ein highlight-indentation python-mode
    xcscope anzu neotree smex
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

;; be sure to just ask for y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;don’t kill-buffer, kill-this-buffer instead
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; anzu configuration
;; https://github.com/syohex/emacs-anzu
(require 'anzu)
(global-anzu-mode +1)
(set-face-attribute 'anzu-mode-line nil
		    :foreground "yellow" :weight 'bold)
(define-key isearch-mode-map [remap isearch-query-replace]  #'anzu-isearch-query-replace)
(define-key isearch-mode-map [remap isearch-query-replace-regexp] #'anzu-isearch-query-replace-regexp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; c-mode settings following video tutorials:
;; Emacs as a C/C++ Editor/IDE (Part I): auto-complete, yasnippet, and
;; auto-complete-c-headers: http://youtu.be/HTUE03LnaXA
;; Emacs as a C/C++ Editor/IDE (Part 2): iedit, flymake-google-cpplint,
;; google-c-style: http://youtu.be/r_HW0EB67eY
;; Emacs as a C/C++ Editor/IDE (Part 3): cedet mode for true intellisense:
;; http://youtu.be/Ib914gNr0ys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;yasnippet
(require 'yasnippet)
(yas-global-mode 1) ; yasnippet is always on

;; start auto-complete with emacs
(require 'auto-complete)
(require 'auto-complete-config) ;; do default config for auto-complete
(ac-config-default)
(setq ac-auto-show-menu    1.0)
(setq ac-delay             1.0)

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
(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
					comment-end   "")))

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

;; http://tkf.github.io/emacs-jedi/latest/
;; (jedi:goto-definition &optional other-window deftype use-cache index)
(setq jedi:goto-definition-config
      '((t   nil        t)        ; C-.
        (t   nil        nil)        ; C-u C-.
        (nil definition nil)        ; C-u C-u C-.
        (t   definition nil)        ; C-u C-u C-u C-.
        ...))

;; (require 'ein)
;; (setq ein:use-auto-complete t)
;; (add-hook 'ein:connect-mode-hook 'ein:jedi-setup)
;(add-hook 'ein:connect-mode-hook (load-theme 'hc-zenburn t))


(require 'python-mode)
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "--simple-prompt -i")


;;switch to the interpreter after executing code
;(setq py-shell-switch-buffers-on-execute-p nil)
;(setq py-switch-buffers-on-execute-p nil)
(setq py-split-windows-on-execute-p t)

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

(defun aj-toggle-fold ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)
      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1))))))
(global-set-key [(M C c)] 'aj-toggle-fold)

;; Python Hook
(add-hook 'python-mode-hook '(lambda () 
 (setq python-indent 4)))

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

;; (setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
;; (setq exec-path (append '("/usr/texbin") exec-path))
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)

;; reftex
;; Just type C-c = and Emacs displays it
;; If you use AUCTeX (you probably do; if you don't, you probably should):
;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;(setq reftex-plug-into-AUCTeX t)

;; If you do not:
(add-hook 'latex-mode-hook 'turn-on-reftex)

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

;;; macros
(fset 'latexeq ;; type Equation~\eqref{f:}
   [?E ?q ?u ?a ?t ?i ?o ?n ?~ ?\\ ?e ?q ?r ?e ?f ?\{ ?e ?: ?\} left])
(add-hook 'LaTeX-mode-hook
          (lambda () (local-set-key (kbd "C-c e") #'run-latexmk)))
(fset 'latexfig ;; type Figure~\ref{f:}
   [?F ?i ?g ?u ?r ?e ?~ ?\\ ?r ?e ?f ?\{ ?f ?: ?\} left])
(add-hook 'LaTeX-mode-hook
          (lambda () (local-set-key (kbd "C-c f") #'run-latexmk)))
;(global-set-key (kbd "C-c e") 'latexeq)
;(global-set-key (kbd "C-c f") 'latexfig)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;; neotree color
(custom-set-faces
 '(col-highlight ((t (:background "color-233"))))
 '(hl-line ((t (:background "color-233"))))
 '(lazy-highlight ((t (:background "black" :foreground "white" :underline t))))
 '(neo-dir-link-face ((t (:foreground "cyan"))))
 '(neo-file-link-face ((t (:foreground "white")))))
(custom-set-variables)
(global-set-key [f8] 'neotree-toggle)

;; Make Text mode the default mode for new buffers
(setq default-major-mode 'text-mode)

;; set default fonts for macosx
(if (eq system-type 'darwin)
    (set-default-font "Monaco 18"))

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))
(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

(setq x-alt-keysym 'meta)

(if (string= system-name "gmunu.snu.ac.kr")
    (custom-set-faces
     '(default ((t (:family "Courier 10 Pitch"
			    :foundry "bitstream"
			    :slant normal :weight normal
			    :height 120 :width normal))))))

;;; not used
;How to turn off color-theme on terminal frame?
;(when (not (display-graphic-p)) (load-theme 'wombat))
;;(load-theme 'wombat)


;;(add-to-list 'package-archives
;;	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'package-archives
;;           '("marmalade" . "http://marmalade-repo.org/packages/") t)
