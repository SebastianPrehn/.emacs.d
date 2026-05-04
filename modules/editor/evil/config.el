;;; evil/config.el --- Yay, Evil! -*- lexical-binding: t -*-
;;; Commentary:

;; VI, VI, VI is the mark of the beast, but the dark side has its temptations in
;; nice keymappings.

;;; Code:

(use-package evil
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(provide 'slp-evil)
;;; config.el ends here
