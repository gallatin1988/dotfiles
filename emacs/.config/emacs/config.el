(defvar elpaca-installer-version 0.7)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
			      :ref nil :depth 1
			      :files (:defaults "elpaca-test.el" (:exclude "extensions"))
			      :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
	(if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
		 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
						 ,@(when-let ((depth (plist-get order :depth)))
						     (list (format "--depth=%d" depth) "--no-single-branch"))
						 ,(plist-get order :repo) ,repo))))
		 ((zerop (call-process "git" nil buffer t "checkout"
				       (or (plist-get order :ref) "--"))))
		 (emacs (concat invocation-directory invocation-name))
		 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
				       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
		 ((require 'elpaca))
		 ((elpaca-generate-autoloads "elpaca" repo)))
	    (progn (message "%s" (buffer-string)) (kill-buffer buffer))
	  (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support and :ensure packages by default
(elpaca elpaca-use-package
  (elpaca-use-package-mode))
(setq use-package-always-ensure t)

;; Expands to: (elpaca evil (use-package evil :demand t))
(use-package evil
:init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-vsplit-window-right t)
    (setq evil-split-window-below t)
    (evil-mode))
(use-package evil-collection
:after evil
:config
    (setq evil-collection-mode-list '(dashboard dired ibuffer))
    (evil-collection-init))
(use-package evil-tutor)

;;Turns off elpaca-use-package-mode current declaration
;;Note this will cause evaluate the declaration immediately. It is not deferred.
;;Useful for configuring built-in emacs features.
(use-package emacs :ensure nil :config (setq ring-bell-function #'ignore))

(use-package general
:config
    (general-evil-setup)
    ;; set up 'SPC' as global leader key
    (general-create-definer svs/leader-keys
       :states '(normal insert visual emacs)
       :keymaps 'override
       :prefix "SPC"
       :global-prefix "M-SPC")

    (svs/leader-keys
       "." '(find-file :wk "Find file")
       "fc" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit emacs config")
       "TAB TAB" '(comment-line :wk "Comment lines"))

    (svs/leader-keys
       "b" '(:ignore t :wk "Buffer")
       "bb" '(switch-to-buffer :wk "Switch buffer")
       "bi" '(ibuffer :wk "ibuffer")
       "bk" '(kill-this-buffer :wk "Kill this buffer")
       "bn" '(next-buffer :wk "Next buffer")
       "bp" '(previous-buffer :wk "Previous buffer")
       "br" '(revert-buffer :wk "Reload buffer"))

    (svs/leader-keys
       "e" '(:ignore t :wk "Evaluate")
       "eb" '(eval-buffer :wk "Evaluate elisp in buffer")
       "ed" '(eval-defun :wk "Evaluate defun containing or after point")
       "ee" '(elav-expression :wk "Evaluate an elisp expression")
       "el" '(eval-last-sexp :wk "Evaluate elisp expression before point")
       "er" '(eval-region :wk "Evaluate elisp in region"))

    (svs/leader-keys
       "h" '(:ignore t :wk "Help")
       "hf" '(describe-function :wk "Describe function")
       "hv" '(describe-variable :wk "Describe variable")
       "hrr" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "Reload emacs config"))

    (svs/leader-keys
       "t" '(:ignore t :wk "Toggle")
       "tl" '(display-line-numbers-mode :wk "Toggle line numbers")
       "tt" '(visual-line mode :wk "Toggle truncated lines"))
    
    (svs/leader-keys
       "w" '(:ignore t :wk "Windows")
       ;; Window splits
       "wc" '(evil-window-delete :wk "Close window")
       "wn" '(evil-window-new :wk "New window")
       "ws" '(evil-window-split :wk "Horizontal split window")
       "wv" '(evil-window-vsplit :wk "Vertical split window")
       ;; Window motions
       "wh" '(evil-window-left :wk "Window left")
       "wj" '(evil-window-down :wk "Window down")
       "wk" '(evil-window-up :wk "Window up")
       "wl" '(evil-window-right :wk "Window right")
       "ww" '(evil-window-next :wk "Goto next window")
       ;; Move Windows
       "wH" '(buf-move-left :wk "Buffer move left")
       "wJ" '(buf-move-down :wk "Buffer move down")
       "wK" '(buf-move-up :wk "Buffer move up")
       "wL" '(buf-move-right :wk "Buffer move right"))

)

(save-place-mode 1) ;;Rmemebers your place in a file
(fset 'yes-or-no-p 'y-or-n-p) ;; Replaces yes/no with y/n 

;;Save what you enter into minibuffer prompt
(setq history-length 50)
(savehist-mode 1)

;;Move customizations variables to seperate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(setq use-dialog-box nil) ;;Supresses pop-up UI dialog boxes when prompting
(global-auto-revert-mode 1) ;;Revert buffers when underlying file has changed
(recentf-mode 1) ;;Recalls most recently deleted files
(pixel-scroll-precision-mode 1) ;;Enables smooth scrollilng
(setq custom-safe-themes t)
(push '(fullscreen . maximized) default-frame-alist) ;; Forces Emacs to start in fullscreen
(setq scroll-preserve-screen-postition 1)
(set-language-environment "UTF-8")
(setq-default indent-tabs-mode nil)
(setq sentence-end-double-space nil)

(use-package all-the-icons
:if (display-graphic-p))

(use-package all-the-icons-dired
:hook (dired-mode . (lambda () (all-the-icons-dired-mode 1))))

(use-package xclip
:config
(setq xclip-program "wl-copy")
(setq xclip-select-enable-clipboard t)
(setq xclip-mode t)
(setq xclip-method (quote wl-copy)))

(require 'windmove)

;;;###autoload
(defun buf-move-up ()
"Swap the current buffer and the buffer above the split.
If there is no split, ie now window above the current one, an
error is signaled."
   ;; "Switches between the current buffer, and the buffer above the
   ;; split, if possible."
   (interactive)
   (let* ((other-win (windmove-find-other-window 'up))
         (buf-this-buf (window-buffer (selected-window))))
      (if (null other-win)
          (error "No window above this one")
        ;; swap top with this one
        (set-window-buffer (selected-window) (window-buffer other-win))
        ;; move this one to top
        (set-window-buffer other-win buf-this-buf)
        (select-window other-win))))

;;;###autoload
(defun buf-move-down ()
"Swap the current buffer and the buffer under the split.
If there is no split, ie now window under the current one, an
error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'down))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (or (null other-win) 
            (string-match "^ \\*Minibuf" (buffer-name (window-buffer other-win))))
        (error "No window under this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-left ()
"Swap the current buffer and the buffer on the left of the split.
If there is no split, ie now window on the left of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'left))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No left split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-right ()
"Swap the current buffer and the buffer on the right of the split.
If there is no split, ie now window on the right of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'right))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No right split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

(set-face-attribute 'default nil
    :font "JetBrains Mono"
    :height 110
    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
    :font "JetBrains Mono"
    :height 110
    :weight 'medium)
(set-face-attribute 'font-lock-comment-face nil
    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
    :slant 'italic)
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))
(setq-default line-spacing 0.12)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)

(setq inhibit-splash-screen t
      ;;inhibit-startup-message t
      ;;inhibit-startup-screen t
      initial-scratch-message nil 
      use-file-dialog nil
      tab-bar-new-button-show nil
      tab-bar-close-button-show nil
      tab-line-closebutton-show nil)

(global-display-line-numbers-mode t)
(global-visual-line-mode t)
(column-number-mode t)

(use-package vertico
  :config
  (setq vertico-cycle t)
  (setq vertico-resize nil)
  (vertico-mode 1))

(use-package marginalia
  :config
  (marginalia-mode 1))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)))

(use-package consult
  :bind (;; A recursive grep
         ("M-s M-g" . consult-grep)
         ;; Search for files names recursively
         ("M-s M-f" . consult-find)
         ;; Search through the outline (headings) of the file
         ("M-s M-o" . consult-outline)
         ;; Search the current buffer
         ("M-s M-l" . consult-line)
         ;; Switch to another buffer, or bookmarked file, or recently
         ;; opened file.
         ("M-s M-b" . consult-buffer)))

(use-package embark
  :bind (("C-." . embark-act)
         :map minibuffer-local-map
         ("C-c C-c" . embark-collect)
         ("C-c C-e" . embark-export)))

(use-package embark-consult)

(use-package wgrep
  :bind ( :map grep-mode-map
          ("e" . wgrep-change-to-wgrep-mode)
          ("C-x C-q" . wgrep-change-to-wgrep-mode)
          ("C-c C-c" . wgrep-finish-edit)))

(use-package toc-org
:commands toc-org-enable
:init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(electric-indent-mode -1)

(require 'org-tempo)

(use-package rainbow-mode
:hook
((org-mode prog-mode) . rainbow-mode))

(use-package sudo-edit
:config
    (svs/leader-keys
        "fu" '(sudo-edit-find-file :wk "Sudo find file")
        "fU" '(sudo-edit :wk "Sudo edit file")))

(use-package modus-themes
:init
(setq modus-themes-mode-line '(accented borderless)
      modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-fringes 'subtle
      modus-themes-tabs-accented t
      modus-themes-paren-match '(bold intense)
      modus-themes-completions '((t . (extrabold intense)))
      modus-themes-org-blocks 'tinted-background
      modus-themes-scale-headings t
      modus-themes-region '(bg-only)
      modus-themes-headings
      '((1 . (rainbow overline background 1.4))
        (2 . (rainbow background 1.3))
        (3 . (rainbow background 1.2))
        (t . (semilight 1.1))))
:config
  (load-theme 'modus-vivendi :no-confirm))
;;(use-package catppuccin-theme)
;;(load-theme 'catppuccin :no-confirm)
;;(catppuccin-reload)

(use-package which-key
:init
    (which-key-mode 1)
:config
    (setq which-key-side-location 'bottom
          which-key-sort-order #'which-key-key-order-alpha
	    which-key-sort-uppercase-first nil
	    whick-key-add-column-padding 1
	    which-key-max-display-columns nil
	    which-key-min-display-lines 6
	    which-key-side-window-slot -10
	    which-key-side-window-max-height 0.25
	    which-key-idle-delay 0.8
	    which-key-max-description-length 25
	    which-key-allow-imprecise-window-fit t
	    which-key-separator " -> " ))
