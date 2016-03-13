;;; Directory Local Variables for Emacs
;;; See Info node `(emacs) Directory Variables' for more information.

((nil
  (require-final-newline . t)
  ;; not tabs in code
  (indent-tabs-mode)
  ;; remove trailing whitespace
  (eval . (add-hook 'before-save-hook 'delete-trailing-whitespace nil t)))
 (ess-mode
  (ess-indent-level . 2)))

