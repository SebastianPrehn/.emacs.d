;;; zig/config.el --- Zig setup -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package zig-mode
  :hook (zig-ts-mode . eglot-ensure))

(provide 'slp-zig)
;;; config.el ends here
