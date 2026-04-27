;;; futhark/config.el --- Futhark programming language setup -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package futhark-mode
  :hook ((futhark-mode . eglot-ensure)
         (futhark-mode . futhark-fmt-on-save-mode)))

(provide 'slp-futhark)
;;; config.el ends here
