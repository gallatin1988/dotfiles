;;; flycheck-tip-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "eclim-tip" "../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/eclim-tip.el"
;;;;;;  "959f8c377a0f3db19f626efca39b10df")
;;; Generated autoloads from ../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/eclim-tip.el

(autoload 'eclim-tip-cycle "eclim-tip" "\


\(fn &optional REVERSE)" t nil)

(autoload 'eclim-tip-cycle-reverse "eclim-tip" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "error-tip" "../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/error-tip.el"
;;;;;;  "aa7fc517f02a6ed471b3a797ed19bbdf")
;;; Generated autoloads from ../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/error-tip.el

(autoload 'error-tip-error-p "error-tip" "\
Return non-nil if error is occurred in current buffer.
This function can catch error against flycheck, flymake and emcas-eclim.

\(fn)" nil nil)

(autoload 'error-tip-cycle-dwim "error-tip" "\
Showing error function.
This function switches proper error showing function by context.
 (whether flycheck or flymake) The REVERSE option jumps by inverse if
the value is non-nil.

\(fn &optional REVERSE)" t nil)

(autoload 'error-tip-cycle-dwim-reverse "error-tip" "\
Same as ‘error-tip-cycle-dwim’, but it jumps to inverse direction.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "flycheck-tip" "../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/flycheck-tip.el"
;;;;;;  "4c62b43c3777f80bcba1f7100013be65")
;;; Generated autoloads from ../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/flycheck-tip.el

(autoload 'flycheck-tip-cycle "flycheck-tip" "\
Move to next error if it's exists.
If it wasn't exists then move to previous error.
Move to previous error if REVERSE is non-nil.

\(fn &optional REVERSE)" t nil)

(autoload 'flycheck-tip-cycle-reverse "flycheck-tip" "\
Do `flycheck-tip-cycle by reverse order.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "flymake-tip" "../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/flymake-tip.el"
;;;;;;  "045838a1d15a4cf83d20a6f26d85ecd9")
;;; Generated autoloads from ../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/flymake-tip.el

(autoload 'flymake-tip-cycle "flymake-tip" "\


\(fn REVERSE)" t nil)

(autoload 'flymake-tip-cycle-reverse "flymake-tip" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/eclim-tip.el"
;;;;;;  "../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/error-tip.el"
;;;;;;  "../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/flycheck-tip-autoloads.el"
;;;;;;  "../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/flycheck-tip-pkg.el"
;;;;;;  "../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/flycheck-tip.el"
;;;;;;  "../../../../.emacs.d/elpa/flycheck-tip-20160908.1953/flymake-tip.el")
;;;;;;  (22505 16696 127568 36000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; flycheck-tip-autoloads.el ends here
