;; ---- Aliases ----
;;Why in the name of all that is holy did they not just do this by default?
(defalias 'hscroll-mode 'toggle-truncate-lines)
;;Alias query functions so all the replace functions start with "replace"!
(defalias 'replace-query 'query-replace)
(defalias 'replace-query-regexp 'query-replace-regexp)
(defalias 'replace-query-regexp-eval 'query-replace-regexp-eval)

(define-key input-decode-map "\e[1;2D" [S-left])
(define-key input-decode-map "\e[1;2C" [S-right])
(define-key input-decode-map "\e[1;2B" [S-down])
(define-key input-decode-map "\e[1;2A" [S-up])
(define-key input-decode-map "\e[1;2F" [S-end])
(define-key input-decode-map "\e[1;2H" [S-home])

(define-key input-decode-map "\e[1;9A" [M-up])
(define-key input-decode-map "\e[1;9B" [M-down])
(define-key input-decode-map "\e[1;9C" [M-right])
(define-key input-decode-map "\e[1;9D" [M-left])

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

(global-set-key "\M-n" "\C-u1\C-v")
(global-set-key "\M-p" "\C-u1\M-v")

;(global-set-key (kbd "<M-down>")  'forward-paragraph)
;(global-set-key (kbd "<M-up>")  'backward-paragraph)


;; latex macros
;; type Figure~\ref{f:}
(fset 'latexeq
   [?E ?q ?u ?a ?t ?i ?o ?n ?~ ?\\ ?e ?q ?r ?e ?f ?\{ ?e ?: ?\} left])
;; type Equation~\eqref{f:}
(fset 'latexfig
   [?F ?i ?g ?u ?r ?e ?~ ?\\ ?r ?e ?f ?\{ ?f ?: ?\} left])

(global-set-key (kbd "C-c e") 'latexeq)
(global-set-key (kbd "C-c f") 'latexfig)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; custom functions

;; eem - Edit the .emacs file
(defun eem ()
(interactive)
(find-file "~/.emacs"))

;; lem - Load the .emacs file (to apply changes)
(defun lem ()
(interactive)
(load-file "~/.emacs"))

;; ebash - Edit the .bashrc, .bash_aliases file
(defun ebash ()
(interactive)
(find-file "~/.bashrc"))

(defun ealias ()
(interactive)
(find-file "~/.bash_aliases"))

;; ===== Function to delete a line =====

;; First define a variable which will store the previous column position
(defvar previous-column nil "Save the column position")

;; Define the nuke-line function. The line is killed, then the newline
;; character is deleted. The column which the cursor was positioned at is then
;; restored. Because the kill-line function is used, the contents deleted can
;; be later restored by usibackward-delete-char-untabifyng the yank commands.
(defun nuke-line()
  "Kill an entire line, including the trailing newline character"
  (interactive)

  ;; Store the current column position, so it can later be restored for a more
  ;; natural feel to the deletion
  (setq previous-column (current-column))

  ;; Now move to the end of the current line
  (end-of-line)

  ;; Test the length of the line. If it is 0, there is no need for a
  ;; kill-line. All that happens in this case is that the new-line character
  ;; is deleted.
  (if (= (current-column) 0)
    (delete-char 1)

    ;; This is the 'else' clause. The current line being deleted is not zero
    ;; in length. First remove the line by moving to its start and then
    ;; killing, followed by deletion of the newline character, and then
    ;; finally restoration of the column position.
    (progn
      (beginning-of-line)
      (kill-line)
      (delete-char 1)
      (move-to-column previous-column))))

;; Now bind the delete line function to the C-M-k key
(global-set-key (kbd "C-M-k") 'nuke-line)
;(global-set-key [f8] 'nuke-line)

(defun quick-copy-line ()
  "Copy the whole line that point is on and move to the beginning of the next line.
    Consecutive calls to this command append each line to the
    kill-ring."
  (interactive)
  (let ((beg (line-beginning-position 1))
	(end (line-beginning-position 2)))
    (if (eq last-command 'quick-copy-line)
	(kill-append (buffer-substring beg end) (< end beg))
      (kill-new (buffer-substring beg end))))
  (beginning-of-line 2))

(global-set-key (kbd "C-M-j") 'quick-copy-line)


(defun quick-cut-line ()
  "Cut the whole line that point is on.  Consecutive calls to this command append each line to the kill-ring."
  (interactive)
  (let ((beg (line-beginning-position 1))
	(end (line-beginning-position 2)))
    (if (eq last-command 'quick-cut-line)
	(kill-append (buffer-substring beg end) (< end beg))
      (kill-new (buffer-substring beg end)))
    (delete-region beg end))
  (beginning-of-line 1)
  (setq this-command 'quick-cut-line))

;(global-set-key [f6] 'quick-cut-line)

(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg)
          (when (and (eval-when-compile
                       '(and (>= emacs-major-version 24)
                             (>= emacs-minor-version 3)))
                     (< arg 0))
            (forward-line -1)))
        (forward-line -1))
      (move-to-column column t)))))

;; macro for latex make
;; see
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Save-Keyboard-Macro.html#Save-Keyboard-Macro
(fset 'mk
   (lambda (&optional arg) "Keyboard
   macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217761
   109 97 107 101 return 24 49] 0 "%d")) arg)))

;; (fset 'make
;;    (lambda (&optional arg) "Keyboard
;;    macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217761
;;    109 97 107 101 return 24 49] 0 "%d")) arg)))


;; http://www.emacswiki.org/emacs/ShowParenMode
;; When the matching paren is offscreen, show-paren-mode highlights
;; only the paren at point. It is more useful to show the line of
;; matching paren in the minibuffer. Execute the following to get this
;; behavior:
(defadvice show-paren-function
  (after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the
        echo area. Has no effect if the character before point is not of
        the syntax class ')'."
  (interactive)
  (let* ((cb (char-before (point)))
	 (matching-text (and cb
			     (char-equal (char-syntax cb) ?\) )
			     (blink-matching-open))))
    (when matching-text (message matching-text))))
