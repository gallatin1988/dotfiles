;;; vlf-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "vlf" "../../../../.emacs.d/elpa/vlf-20150101.718/vlf.el"
;;;;;;  "965d2b64bf4c51aae832e0281c40b6ed")
;;; Generated autoloads from ../../../../.emacs.d/elpa/vlf-20150101.718/vlf.el

(autoload 'vlf "vlf" "\
View Large FILE in batches.  When MINIMAL load just a few bytes.
You can customize number of bytes displayed by customizing
`vlf-batch-size'.
Return newly created buffer.

\(fn FILE &optional MINIMAL)" t nil)

;;;***

;;;### (autoloads nil "vlf-ediff" "../../../../.emacs.d/elpa/vlf-20150101.718/vlf-ediff.el"
;;;;;;  "54a9f690b19dcae18ce7a354156fbe73")
;;; Generated autoloads from ../../../../.emacs.d/elpa/vlf-20150101.718/vlf-ediff.el

(autoload 'vlf-ediff-files "vlf-ediff" "\
Run batch by batch ediff over FILE-A and FILE-B.
Files are processed with VLF with BATCH-SIZE chunks.
Requesting next or previous difference at the end or beginning
respectively of difference list, runs ediff over the adjacent chunks.

\(fn FILE-A FILE-B BATCH-SIZE)" t nil)

;;;***

;;;### (autoloads nil "vlf-occur" "../../../../.emacs.d/elpa/vlf-20150101.718/vlf-occur.el"
;;;;;;  "719b3973ea2223fbe12dcf92e711ec75")
;;; Generated autoloads from ../../../../.emacs.d/elpa/vlf-20150101.718/vlf-occur.el

(autoload 'vlf-occur-load "vlf-occur" "\
Load serialized `vlf-occur' results from current buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../.emacs.d/elpa/vlf-20150101.718/vlf-autoloads.el"
;;;;;;  "../../../../.emacs.d/elpa/vlf-20150101.718/vlf-base.el"
;;;;;;  "../../../../.emacs.d/elpa/vlf-20150101.718/vlf-ediff.el"
;;;;;;  "../../../../.emacs.d/elpa/vlf-20150101.718/vlf-follow.el"
;;;;;;  "../../../../.emacs.d/elpa/vlf-20150101.718/vlf-occur.el"
;;;;;;  "../../../../.emacs.d/elpa/vlf-20150101.718/vlf-pkg.el" "../../../../.emacs.d/elpa/vlf-20150101.718/vlf-search.el"
;;;;;;  "../../../../.emacs.d/elpa/vlf-20150101.718/vlf-setup.el"
;;;;;;  "../../../../.emacs.d/elpa/vlf-20150101.718/vlf-tune.el"
;;;;;;  "../../../../.emacs.d/elpa/vlf-20150101.718/vlf-write.el"
;;;;;;  "../../../../.emacs.d/elpa/vlf-20150101.718/vlf.el") (22504
;;;;;;  63031 393114 85000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; vlf-autoloads.el ends here
