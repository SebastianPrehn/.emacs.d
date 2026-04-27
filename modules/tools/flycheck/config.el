;;; flycheck/config.el --- Flycheck setup -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package flycheck
  :hook ((text-mode org-mode markdown-mode emacs-lisp-mode) . flycheck-mode)
  :config
  ;; Custom Vale checker instead of flycheck-vale package
  (flycheck-define-checker vale
    "A checker for prose using Vale"
    :command ("vale" "--output" "line" source)
    :standard-input nil
    :error-patterns
    ((error line-start (file-name) ":" line ":" column ":" (id (one-or-more (not (any ":")))) ":" (message) line-end))
    :modes (markdown-mode org-mode text-mode))
  (add-to-list 'flycheck-checkers 'vale 'append))

(provide 'slp-flycheck)
;;; config.el ends here
