(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Comic Code" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(kept-new-versions 6)
 '(kept-old-versions 6)
 '(ring-bell-function (quote ignore))
 '(visible-bell t)
 '(show-paren-mode t)
)


;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Variables      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;; UTF-8 mode
(set-language-environment "UTF-8")
;; Start maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; Start fullscreen
;; (toggle-frame-fullscreen)
;; Disable toolbar
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
;; Split screen into two windows
(split-window-horizontally)
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;; Delete when typing after highlighting text
(delete-selection-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      System-dependent stuff      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (equal system-type "windows-nt")
	(progn
		(setq HOME "wut")
		;(message "System type \"windows-nt\". System-specific startup code in .emacs has been executed.")
	)
)
(if (equal system-type "gnu/linux")
	(progn
		(message "System type \"gnu/linux\". System-specific startup code in .emacs has been executed.")
	)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Jim's custom stuff      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Make cursor blinking maniacally fast
(setq blink-cursor-delay 0) ;;Start blinking immediately
(setq blink-cursor-blinks 0) ;;0 means infinite blinks
(setq blink-cursor-interval 0.0666) ;;Maniacally fast

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Editing behavior      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Stop auto-indenting, globally
(electric-indent-mode 0)
;;Indent with tabs only
(setq-default indent-tabs-mode t)
(setq-default tab-width 4) ;;tabs to be four spaces wide
(defvaralias 'c-basic-offset 'tab-width)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      JIM'S FUNCTIONS      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun ii () "Opens the .emacs initialization file." (interactive)
       (find-file "~/.emacs")
)
(defun cpp () "Switches to C++ mode" (interactive) c++-mode)
(defun hh () cd "~/")
;; Editing
(defun fr () "query-replace" (interactive) 'query-replace)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Other useful functions from wherever      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; duplicate current line
(defun duplicate-current-line (&optional n)
  "duplicate current line, make more than 1 copy given a numeric argument"
  (interactive "p")
  (save-excursion
    (let ((nb (or n 1))
    	  (current-line (thing-at-point 'line)))
      ;; when on last line, insert a newline first
      (when (or (= 1 (forward-line 1)) (eq (point) (point-max)))
    	(insert "\n"))
      
      ;; now insert as many time as requested
      (while (> n 0)
		(insert current-line)
    	(decf n))))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      KEY TRANSLATIONS      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Switches C-x&C-c and C-o&C-p to get Windows-like C&P behavior
;; without having to un/rebind every built-in C-o and C-c binding.
(keyboard-translate ?\C-x ?\C-o)
(keyboard-translate ?\C-o ?\C-x)
(keyboard-translate ?\C-c ?\C-p)
(keyboard-translate ?\C-p ?\C-c)
;; (There's probably an Emacs commandment
;; against this, but I don't care.)


;;;;;;;;;;;;;;;;;;;;;;
;;      UNBIND      ;;
;;;;;;;;;;;;;;;;;;;;;;
;;Not sure why I ever had scroll lock unbound, but I'll leave this here a little longer.
;;(global-unset-key (kbd "<Scroll_Lock>"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               KEY COMBINATIONS                ;;
;;      (Many inspired by Casey Muratori's)      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Editing
(global-set-key (kbd "C-o") 'kill-region) ;;CUT, TRANSLATED TO C-x
(global-set-key (kbd "C-p") 'kill-ring-save) ;;COPY, TRANSLATED C-c
(global-set-key (kbd "C-v") 'clipboard-yank) ;;PASTE
(global-set-key (kbd "C-z") 'undo) ;;UNDO
(global-set-key (kbd "C-a") 'mark-whole-buffer) ;;UNDO
(global-set-key (kbd "C-f") 'isearch-forward) ;;FIND FORWARD
(global-set-key (kbd "C-F") 'isearch-backward) ;;FIND BACKWARD
(global-set-key (kbd "C-d") 'duplicate-current-line) ;;DUPE LINE
(global-set-key (kbd "TAB") 'tab-to-tab-stop) ;;NPP-style tabbing
(define-key global-map [C-right] 'forward-word)
(define-key global-map [C-left] 'backward-word)
(define-key global-map [C-up] 'previous-blank-line)
(define-key global-map [C-down] 'next-blank-line)
(define-key global-map [home] 'beginning-of-line)
(define-key global-map [end] 'end-of-line)
(define-key global-map [pgup] 'forward-page)
(define-key global-map [pgdown] 'backward-page)
(define-key global-map [C-next] 'scroll-other-window)
(define-key global-map [C-prior] 'scroll-other-window-down)
(define-key global-map [backtab] 'indent-for-tab-command)
(define-key global-map [C-tab] 'indent-region)
(define-key global-map "\er" 'query-replace)
(global-set-key (kbd "C-r") 'rainbow-delimiters-mode) ;;Rainbow Delimiters
;; Buffers and files
(global-set-key (read-kbd-macro "\eb")  'ido-switch-buffer)
(global-set-key (read-kbd-macro "\eB")  'ido-switch-buffer-other-window)
(define-key global-map "\ek" 'kill-this-buffer)
(define-key global-map "\es" 'save-buffer)
(define-key global-map "\C-s" 'save-buffer)
;; "find-file"s
(define-key global-map "\ef" 'find-file)
(define-key global-map "\eF" 'find-file-other-window)
;; Random useful things
(define-key global-map "\ep" 'quick-calc)
(define-key global-map "\ew" 'other-window)
;; Help
(define-key global-map "\eq" 'describe-function)
;; KILL-EMACS
(define-key global-map (kbd "M-<f4>") 'save-buffers-kill-terminal)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Jim's color scheme      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun jims-theme () "Switches to Jim's color scheme." (interactive)
	(custom-set-faces
		'(default ((t (:foreground "ivory2" :background "#343036"))))
		'(custom-group-tag-face ((t (:underline t :foreground "black"))) t)
		'(custom-variable-tag-face ((t (:underline t :foreground "black"))) t)
		'(font-lock-builtin-face ((t (:foreground "wheat4"))))
		'(font-lock-comment-face ((t (:foreground "#00ff00"))))
		'(font-lock-constant-face ((t (:foreground "wheat4"))))
		'(font-lock-function-name-face ((((class color) (background dark)) (:foreground "white"))))
		'(font-lock-keyword-face ((t (:foreground "OrangeRed1" ))))
		;;'(font-lock-reference-face ((t (:foreground "black" ))))
		'(font-lock-string-face ((t (:foreground "cyan1"))))
		'(font-lock-type-face ((t (:foreground "yellow2"))))
		'(font-lock-variable-name-face ((t (:foreground "MediumOrchid1"))));;c8d4ec
		;;'(font-lock-warning-face ((t (:foreground "#695a46"))))
		'(font-lock-warning-face ((t (:foreground "red1"))))
		;;'(highlight ((t (:foreground "black" :background "darkseagreen2"))))
		'(mode-line ((t (:inverse-video t))))
		'(region ((t (:background "black"))))
		'(widget-field-face ((t (:foreground "white"))) t)
		'(widget-single-line-field-face ((t (:background "darkgray"))) t)
	)
	;;(global-font-lock-mode 1)
    (set-cursor-color "lightgreen")
    ;;(set-face-foreground 'font-lock-builtin-face "black")
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      From Casey Muratori's .emacs      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Stop Emacs from losing undo information by
;; setting very high limits for undo buffers
(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)
;; Smooth scroll
(setq scroll-step 3)
;; Clock
(display-time)
;; Startup windowing
(setq next-line-add-newlines nil)
(setq-default truncate-lines t)
(setq truncate-partial-width-windows nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Default theme fun      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(jims-theme)
