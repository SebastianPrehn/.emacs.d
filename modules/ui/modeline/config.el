;;; modeline/config.el --- Modeline -*- lexical-binding: t -*-

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-project-detection 'auto)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-buffer-modification-icon t)
  (doom-modeline-lsp-icon t)
  (doom-modeline-time-icon t))

(provide 'slp-modeline)
;;; config.el ends here
