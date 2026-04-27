;;; diff-hl/config.el --- Highlights uncommitted changes on the side of the window -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package diff-hl
  :after magit
  :ensure t
  :hook ((magit-pre-refresh . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (global-diff-hl-mode))

(provide 'slp-diff-hl)
;;; config.el ends here
