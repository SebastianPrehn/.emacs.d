;;; cape/config.el --- Completion At Point Extensions -*- lexical-binding: t -*-

;;; Commentary:

;; Used in combination with Corfu, and can utilize Company as well.

;;; Code:

(use-package cape
  ;; Bind prefix keymap providing all Cape commands under one key. Press `C-c p ?' for help
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-dict)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

;; Use Company backends as Capfs

(when (require 'cape nil 'noerror)
  (setq-local completion-at-point-functions
              (mapcar #'cape-company-to-capf
                      (list #'company-files #'company-keywords #'company-dabbrev))))


(provide 'slp-cape)
;;; config.el ends here
