;;; Directory Local Variables for Emacs
;;; See Info node `(emacs) Directory Variables' for more information.

((nil
  (bug-reference-bug-regexp . "#\\(?2:[0-9]+\\)")
  (bug-reference-url-format . "https://github.com/tidyverse/lubridate/issues/%s")
  (require-final-newline . t)
  ;; not tabs in code
  (indent-tabs-mode)
  ;; remove trailing whitespace
  (eval . (add-hook 'before-save-hook 'delete-trailing-whitespace nil t)))
 (ess-mode
  (ess-style . RStudio)))
