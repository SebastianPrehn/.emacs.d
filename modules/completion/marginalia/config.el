;;; marginalia/config.el --- Contextual annotations to minibuffer completion candidates -*- lexical-binding: t -*-

;;; Commentary:

;; The marginalia package adds contextual annotations to minibuffer completion candidates. These annotations adapt to the type of candidate being displayed, such as files, buffers, or commands, and provide useful metadata alongside the main completion text.

;;; code:

(use-package marginalia
  :config
  (marginalia-mode 1))

(provide 'slp-marginalia)
;;; config.el ends here
