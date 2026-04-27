;;; ibuffer/config.el --- Group buffers and display them neatly -*- lexical-binding: t -*-

;;; Commentary:

;; This configuration is heavily inspired by, and adapted from, the setup described by https://olddeuteronomy.github.io/post/emacs-ibuffer-config/

;;; Code:

(use-package ibuffer
  :ensure nil
  :bind
  ("C-x C-b" . ibuffer)
  :custom
  (ibuffer-expert nil) ; set to t once I've gotten used to IBuffer
  (ibuffer-display-summary nil)
  (ibuffer-use-other-window nil)
  (ibuffer-show-empty-filter-groups nil)
  (ibuffer-default-sorting-mode 'filename/process)
  (ibuffer-title-face 'font-lock-doc-face)
  (ibuffer-use-header-line t)
  (ibuffer-default-hrink-to-minimum-size nil)
  ;; IBuffer formats
  (ibuffer-formats
   '((mark modified read-only locked " "
           (name 30 30 :left :elide)
           " "
           (size 9 -1 :right)
           " "
           (mode 16 16 :left :elide)
           " " filename-and-process)
     (mark " "
           (name 16 -1)
           " " filename)))
  ;; Saved filter groups
  (ibuffer-saved-filter-groups
   '(("Main"
      ("Directories" (mode . dired-mode))
      ("Python" (or
                 (mode . python-ts-mode)
                 (mode . python-mode)))
      ("Build" (or
                (mode . make-mode)
                (mode . makefile-gmake-mode)
                (name . "^Makefile$")
                (mode . change-log-mode)))
      ("Scripts" (or
                  (mode . shell-script-mode)
                  (mode . shell-mode)
                  (mode . sh-mode)
                  (mode . lua-mode)
                  (mode . bat-mode)))
      ("Config" (or
                 (mode . conf-mode)
                 (mode . conf-toml-mode)
                 (mode . toml-ts-mode)
                 (mode . conf-windows-mode)
                 (name . "^\\.clangd$")
                 (name . "^config\\.toml$")
                 (mode . yaml-mode)))
      ("Web" (or
              (mode . mhtml-mode)
              (mode . html-mode)
              (mode . web-mode)
              (mode . nxml-mode)))
      ("CSS" (or
              (mode . css-mode)
              (mode . sass-mode)))
      ("JS" (or
             (mode . js-mode)
             (mode . rjsx-mode)))
      ("Markup" (or
                 (mode . markdown-mode)
                 (mode . adoc-mode)))
      ("Org" (mode . org-mode))
      ("LaTeX" (name . "\\.tex$"))
      ("Magit" (or
              (mode . magit-blame-mode)
              (mode . magit-cherry-mode)
              (mode . magit-diff-mode)
              (mode . magit-log-mode)
              (mode . magit-process-mode)
              (mode . magit-status-mode)))
    ("Apps" (or
             (mode . elfeed-search-mode)
             (mode . elfeed-show-mode)))
    ("Fundamental" (or
                    (mode . fundamental-mode)
                    (mode . text-mode)))
    ("Emacs" (or
              (mode . emacs-lisp-mode)
              (name . "^\\*Help\\*$")
              (name . "^\\*Custom.*")
              (name . "^\\*Org Agenda\\*$")
              (name . "^\\*info\\*$")
              (name . "^\\*scratch\\*$")
              (name . "^\\*Backtrace\\*$")
              (name . "^\\*Messages\\*$"))))))
:hook
(ibuffer-mode . (lambda ()
                  (ibuffer-switch-to-saved-filter-groups "Main"))))

(provide 'slp-ibuffer)
;;; config.el ends here
