;;; macos/config.el --- MacOS-specific settings -*- lexical-binding: t -*-

;;; Commentary:

;; MacOS has a different keyboard layout, with its `control', `option' and
;; `command' keys, and these require different keypresses than I'm used to.

;;; Code:

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta
        mac-option-modifier nil
        mac-control-modifier 'control
        mac-right-command-modifier 'super
        mac-right-control-modifier 'hyper))

;; Technically does not need system-type check due to module nature.
;; Not sure whether I will keep for future-proofing or remove it.

(provide 'slp-macos)
;;; config.el ends here
