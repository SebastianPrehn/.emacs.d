;;; init.el --- Sebastian's personal GNU Emacs config -*- lexical-binding: t -*-
;; Author: Sebastian Larsen Prehn

;; First written in April 2026.

;;; Commentary:

;; Bootstrap Emacs configuration.
;; The setup is split across files for clarity and modularity.

;;; Code:

;; Produce backtraces when errors occur; helpful to diagnose startup issues
(defun slp/toggle-debug-on-error ()
  "Toggle whether Emacs show backtraces when errors occur."
  (interactive)
  (setq debug-on-error (not debug-on-error))
  (message "Debug on error: %s" debug-on-error))
(global-set-key (kbd "C-c d") #'slp/toggle-debug-on-error)



;;; Setup package manager (Elpaca)
(defvar elpaca-installer-version 0.12)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca-activate)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-sources-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

(elpaca-wait)

(setq use-package-always-defer t
      use-package-always-ensure t
      ;; Testing for package timing
      ;; use-package-compute-statistics t
      use-package-expand-minimally t)

;; no-littering must run before anything writes files
(setq custom-file (expand-file-name "etc/custom.el" user-emacs-directory))

(use-package no-littering
  :demand t
  :init
  (setq no-littering-etc-directory (expand-file-name "etc/" user-emacs-directory)
        no-littering-var-directory  "~/.local/share/emacs/")
  :config
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

(elpaca-wait)

;;; Defaults
(when (file-exists-p custom-file)
  (load custom-file))

(setq-default indent-tabs-mode nil)

(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(set-language-environment "English")

(setq column-number-mode 1)
(setq use-dialog-box nil)
(setq frame-resize-pixelwise t)
(setq default-frame-alist
    (if (eq system-type 'darwin)
        '((ns-transparent-titlebar . t)       ; Make title bar blend with buffer
          (ns-appearance . dark)              ; Use dark title bar (or 'light)
          (alpha-background . 95))            ; Slight transparency (0-100)
      '((undecorated . t))))                  ; Remove decorations on Linux

(delete-selection-mode 1) ; Delete selection when typing
(global-auto-revert-mode t) ; Auto update buffer when file changes outside of Emacs (vc etc.)
(setq vc-follow-symlinks t) ; Follow symlinks without prompting
(setq-default tab-width 4) ; Reasonable default tab width most languages will override
(setq yes-or-no-p #'y-or-n-p) ; Use y/n instead of yes/no

(use-package exec-path-from-shell
  :ensure t
  :config
  ((dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO"))
  (add-to-list 'exec-path-from-shell-variables var))))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setq backup-directory-alist '(("." . "~/.emacs-backups")))
(setq backup-by-copying t)       ; Don't clobber symlinks
(setq version-control t)         ; Use version numbers on backups
(setq delete-old-versions t)     ; Silently delete old backup versions
(setq kept-new-versions 6)       ; Keep 6 newest versions
(setq kept-old-versions 2)       ; Keep 2 oldest versions

;;; Modules setup
(add-to-list 'load-path (expand-file-name "lisp/" user-emacs-directory))
(require 'slp-modules)

;; Declare modules
(slp/modules!
 :editor meow
 :ui theme
 :ui modeline
 :completion vertico
 :completion marginalia
 :completion orderless
 :completion consult
 :completion embark
 :completion corfu
 :completion cape
 :completion which-key
 :completion ibuffer
 :completion tempel
 :programming eglot
 :programming markdown
 :programming latex
 :programming rust
 :programming typescript
 :programming zig
 :programming futhark
 :programming nix
 :org org
 :org org-roam
 :org org-ref
 :tools dired
 :tools elfeed
 :tools flycheck
 :spellcheck jinx
 :vc diff-hl
 :vc magit
 :social erc)

(provide 'init)
;;; init.el ends here
