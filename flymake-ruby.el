;;; flymake-ruby.el --- A flymake handler for ruby-mode files
;;
;;; Author: Steve Purcell <steve@sanityinc.com>
;;; URL: https://github.com/purcell/flymake-ruby
;;; Version: DEV
;;;
;;; Commentary:
;; Usage:
;;   (require 'flymake-ruby)
;;   (add-hook 'ruby-mode-hook 'flymake-ruby-load)
(require 'flymake)

;;; Code:

(defconst flymake-ruby-err-line-patterns '(("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)))

(defvar flymake-ruby-executable "ruby"
  "The ruby executable to use for syntax checking.")

;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  "Construct a command that flymake can use to check ruby source."
  (list flymake-ruby-executable
        (list "-c" (flymake-init-create-temp-buffer-copy
                    'flymake-create-temp-inplace))))

;;;###autoload
(defun flymake-ruby-load ()
  "Configure flymake mode to check the current buffer's ruby syntax.

This function is designed to be called in `ruby-mode-hook'; it
does not alter flymake's global configuration, so function
`flymake-mode' alone will not suffice."
  (interactive)
  (set (make-local-variable 'flymake-allowed-file-name-masks) '(("." flymake-ruby-init)))
  (set (make-local-variable 'flymake-err-line-patterns) flymake-ruby-err-line-patterns)
  (if (executable-find flymake-ruby-executable)
      (flymake-mode t)
    (message "Not enabling flymake: '%' command not found" flymake-ruby-executable)))


(provide 'flymake-ruby)
;;; flymake-ruby.el ends here
