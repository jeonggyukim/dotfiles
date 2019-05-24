;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package Setup
;; you can update all of the installed packages
;; by using the “U” key in the packages list view
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'diminish)     ;; if you use :diminish
(require 'bind-key)     ;; if you use any :bind variant
;(setq use-package-verbose t)
(setq use-package-always-ensure t)

(setq custom-file "~/.emacs.d/custom.el")
(setq vc-follow-symlinks t)
(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))
(put 'upcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
