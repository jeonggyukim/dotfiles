;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package Setup
;; A bit old but good article on package management in emacs:
;; http://batsov.com/articles/2012/02/19/\
;; package-management-in-emacs-the-good-the-bad-and-the-ugly/
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

(package-initialize) ; initialize package.el

;; (eval-when-compile
;;   (require 'use-package))
;; (require 'diminish)                ;; if you use :diminish
;; (require 'bind-key)                ;; if you use any :bind variant

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))
