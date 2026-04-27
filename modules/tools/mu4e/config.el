;;; mu4e/config.el --- E-mail in E-macs -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(load "~/.emacs.d/private.el" t)

(use-package mu4e
  :config
  (setq user-mail-address (or (bound-and-true-p my-email-address) "user@example.org")
        mu4e-user-mail-address-list (or (bound-and-true-p my-email-address-list)
                                (list (or (bound-and-true-p my-email-address) "user@example.org")))
        mu4e-change-filenames-when-moving t
        mu4e-get-mail-command "mbsync -a"
        mu4e-attachment-dir "~/Downloads"
        mu4e-drafts-folder "/Drafts"
        mu4e-sent-folder "/Sent"
        mu4e-refile-folder "/Archive"
        mu4e-trash-folder "/Trash"
        mu4e-maildir-shortcuts '((:maildir "/Inbox" :key ?i)
                                 (:maildir "/Sent" :key ?s)
                                 (:maildir "/Trash" :key ?t)
                                 (:maildir "/Drafts" :key ?d)
                                 (:maildir "/Junk" :key ?j)
                                 (:maildir "/Archive" :key ?a))
        smtpmail-smtp-user (or (bound-and-true-p my-email-address) "user@example.org")
        smtpmail-smtp-server (or (bound-and-true-p my-smtp-server) "smtp.example.org")
        smtpmail-smtp-service (or (bound-and-true-p my-smtp-port) 587)
        smtpmail-stream-type 'ssl
        send-mail-function 'smtpmail-send-it)
        ;; Auto-update mail every 5 minutes
  mu4e-update-interval 300)

;; Org-mode integration
(require 'org-mu4e nil t)

;; mu4e-alert for notifications
(use-package mu4e-alert
  :ensure t
  :after mu4e
  :config
  (mu4e-alert-set-default-style 'libnotify)  ; or 'notifier on macOS
  (mu4e-alert-enable-mode-line-display)
  (mu4e-alert-enable-notifications))

(use-package org-contacts
  :ensure t
  :after (mu4e org)
  :custom
  (org-contacts-files (list slp/contacts-file))
  :config
  ;; Auto-complete from contacts when composing
  (add-to-list 'mu4e-headers-actions
               '("add to contacts" . mu4e-action-add-org-contact) t))

(provide 'slp-mu4e)
;;; config.el ends here
