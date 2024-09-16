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

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

;;When installing a package used in the init file itself,
;;e.g. a package which adds a use-package key word,
;;use the :wait recipe keyword to block until that package is installed/configured.
;;For example:
;;(use-package general :ensure (:wait t) :demand t)

;; Expands to: (elpaca evil (use-package evil :demand t))
(use-package evil
:ensure t
:init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-vsplit-window-right t)
    (setq evil-split-window-below t)
    (evil-mode))
(use-package evil-collection
:ensure t
:after evil
:config
    (setq evil-collection-mode-list '(dashboard dired ibuffer))
    (evil-collection-init))
(use-package evil-tutor
:ensure t)

;;Turns off elpaca-use-package-mode current declaration
;;Note this will cause evaluate the declaration immediately. It is not deferred.
;;Useful for configuring built-in emacs features.
(use-package emacs :ensure nil :config (setq ring-bell-function #'ignore))

(use-package general
:ensure t
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

)

(use-package all-the-icons
:ensure t
:if (display-graphic-p))

(use-package all-the-icons-dired
:ensure t
:hook (dired-mode . (lambda () (all-the-icons-dired-mode 1))))

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

(global-display-line-numbers-mode t)
(global-visual-line-mode t)

(use-package toc-org
:ensure t
:commands toc-org-enable
:init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets
:ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(electric-indent-mode -1)

(require 'org-tempo)

(use-package catppuccin-theme :ensure t :demand t)
(load-theme 'catppuccin t)

(use-package rainbow-mode
:ensure t
:hook
((org-mode prog-mode) . rainbow-mode))

(use-package sudo-edit
:ensure t
:config
    (svs/leader-keys
        "fu" '(sudo-edit-find-file :wk "Sudo find file")
        "fU" '(sudo-edit :wk "Sudo edit file")))

(use-package which-key
:ensure t
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
