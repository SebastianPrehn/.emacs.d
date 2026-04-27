;;; org/config.el --- General settings for Org Mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; General org settings
(use-package org
  :ensure nil ; org is built-in
  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda)
         ("C-c l" . org-store-link))
  :custom
  (org-directory (expand-file-name "~/Documents/org/"))
  (org-imenu-depth 7)
  (org-ellipsis " ▼")
  (org-special-ctrl-a/e nil)
  (org-special-ctrl-k nil)
  (org-M-RET-may-split-line '((default . nil)))
  (org-hide-emphasis-markers nil)
  (org-hide-macro-markers nil)
  (org-hide-leading-stars nil)
  (org-cycle-separator-lines 0)
  (org-fold-catch-invisible-edits 'show)
  (org-return-follows-link nil)
  (org-loop-over-headlines-in-active-region 'start-level)
  (org-insert-heading-respect-content t)
  (org-read-date-prefer-future 'time)
  (org-highlight-latex-and-related nil) ; other options affect elisp regexp in src blocks
  (org-fontify-quote-and-verse-blocks t)
  (org-fontify-whole-block-delimiter-line t)
  (org-track-ordered-property-with-tag t)
  (org-structure-template-alist
   '(("s" . "src")
	 ("e" . "src emacs-lisp")
	 ("E" . "src emacs-lisp :results value code :lexical t")
	 ("t" . "src emacs-lisp :tangle FILENAME")
	 ("T" . "src emacs-lisp :tangle FILENAME :mkdirp yes")
	 ("x" . "example")
	 ("X" . "export")
	 ("q" . "quote")))

  :config
  (defvar slp/deep-work-file
    (expand-file-name "deep-work.org" org-directory)
    "Path to deep work org file.")

  (defvar slp/journal-file
    (expand-file-name "journal.org" org-directory)
    "Path to journal org file.")

  (defvar slp/contacts-file
    (expand-file-name "contacts.org" org-directory)
    "Path to contacts org file.")

  (setq org-agenda-files (list slp/deep-work-file
                               slp/contacts-file))

  (setq org-capture-templates
    `(("w" "Work Task"
       entry
       (file+headline ,slp/deep-work-file "Tasks")
       "* TODO %^{Task description}\nSCHEDULED: %^t\n:PROPERTIES:\n:WORK_TYPE: %^{Work type|deep|shallow}\n:EFFORT: %^{Effort|2:00|1:30|0:30|0:15}\n:BEST_TIME: %^{Best time|morning|afternoon|evening|anytime}\n:END:\n%U\n"
       :empty-lines 1)
      
      ;; Keep specialized ones if you want quick access to common patterns
      ("d" "Deep Work (quick)" 
       entry
       (file+headline ,slp/deep-work-file "Tasks")
       "* TODO %^{Task description}\nSCHEDULED: %^t\n:PROPERTIES:\n:WORK_TYPE: deep\n:EFFORT: 2:00\n:BEST_TIME: morning\n:END:\n%U\n"
       :empty-lines 1)
      
      ("q" "Quick Shallow (quick)"
       entry
       (file+headline ,slp/deep-work-file "Tasks")
       "* TODO %^{Task description}\n:PROPERTIES:\n:WORK_TYPE: shallow\n:EFFORT: 0:15\n:BEST_TIME: anytime\n:END:\n"
       :empty-lines 1)

      ("j" "Journal Entry"
       entry
       (file+olp+datetree ,slp/journal-file)
       "* %<%H:%M> %^{Title}\n%?\n"
       :empty-lines 1)))

  ;; Custom agenda commands
  (setq org-agenda-custom-commands
    '(("d" "Deep Work Queue"
       tags-todo "WORK_TYPE=\"deep\""
       ((org-agenda-overriding-header "🧠 Deep Work Sessions Available")
        (org-agenda-prefix-format " %i %-12:c [%e] ")
        (org-agenda-sorting-strategy '(priority-down effort-down))))
      
      ("s" "Shallow Work Queue"
       tags-todo "WORK_TYPE=\"shallow\""
       ((org-agenda-overriding-header "📋 Shallow Work Tasks")
        (org-agenda-prefix-format " %i %-12:c [%e] ")
        (org-agenda-sorting-strategy '(priority-down effort-up))))
      
      ("w" "Work Type Overview"
       ((tags-todo "WORK_TYPE=\"deep\""
                   ((org-agenda-overriding-header "🧠 Deep Work (Uninterrupted Focus)")
                    (org-agenda-prefix-format " %i %-12:c [%e] ")))
        (tags-todo "WORK_TYPE=\"shallow\""
                   ((org-agenda-overriding-header "📋 Shallow Work (Administrative)")
                    (org-agenda-prefix-format " %i %-12:c [%e] "))))
       ((org-agenda-sorting-strategy '(priority-down effort-down))))
      
      ;; Additional useful views
      ("t" "Today's Schedule"
       agenda ""
       ((org-agenda-span 'day)
        (org-agenda-overriding-header "📅 Today's Schedule")))
      
      ("n" "Next 7 Days"
       agenda ""
       ((org-agenda-span 7)
        (org-agenda-overriding-header "📆 Week Ahead"))))))

(provide 'slp-org)
;;; config.el ends here
