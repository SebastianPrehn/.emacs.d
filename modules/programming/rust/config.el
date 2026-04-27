;;; rust/config.el --- Rust setup -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package rust-ts-mode
  :ensure nil ; built-in
  :hook ((rust-ts-mode . eglot-ensure)))

(defun slp/rust-format-on-save ()
  "Enable formatting on save once Eglot is managing the buffer."
  (when (eglot-managed-p)
    (add-hook 'before-save-hook #'eglot-format-buffer nil t)))

(add-hook 'eglot-managed-mode-hook #'slp/rust-format-on-save)
(add-hook 'eglot-managed-mode-hook #'eglot-inlay-hints-mode)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(rust-ts-mode . ("rust-analyzer"))))

(setq eglot-workspace-configuration
      '((:rust-analyzer
         (:check (:command "clippy")))))

(setq project-vc-extra-root-markers '("Cargo.toml"))

(provide 'slp-rust)
;;; config.el ends here
