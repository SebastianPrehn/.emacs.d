;;; eglot/config.el --- Built-in lightweight, standards-compliant Language Server Protocol client -*- lexical-binding: t -*-

;;; Commentary:
;;; Code:

(use-package eglot
  :ensure nil) ;; built-in

(setq treesit-language-source-alist
      '((rust "https://github.com/tree-sitter/tree-sitter-rust")
        (zig "https://github.com/tree-sitter/zig-tree-sitter")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx")
        (markdown "https://github.com/tree-sitter-grammars/tree-sitter-markdown")))

;;; Prefer tree-sitter modes when available
(setq major-mode-remap-alist
      '((rust-mode . rust-ts-mode)
        (zig-mode . zig-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (js-mode . js-ts-mode)
        (markdown-mode . markdown-ts-mode)))

(provide 'slp-eglot)
;;; config.el ends here
