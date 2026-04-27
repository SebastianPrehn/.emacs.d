;;; org-roam/config.el --- Org Roam setup -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package org-roam
  :custom
  (org-roam-directory (expand-file-name "roam/" org-directory))
  (org-roam-completion-anywhere t)
  (org-roam-dailies-directory "daily/")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today)
         ("C-c n d" . org-roam-dailies-goto-today)
         ("C-c n y" . org-roam-dailies-goto-yesterday)
         ("C-c n t" . org-roam-dailies-goto-tomorrow)
         ("C-c n g" . org-roam-graph))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (org-roam-db-autosync-mode) ; Initialize database
  ;; Daily node templates
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %<%H:%M> %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d %A>\n\n"))))
  ;; Node capture templates
  (setq org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+date: %U\n\n")
           :unnarrowed t)
          
          ("p" "project" plain
           "* Goals\n\n%?\n\n* Tasks\n\n** TODO \n\n* Dates\n\n* Notes\n\n"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+category: project\n#+date: %U\n\n")
           :unnarrowed t)
          
          ("r" "reference/paper" plain
           "* Source\n\n%^{citekey}p\n\n* Summary\n\n%?\n\n* Key Points\n\n* Notes\n\n* Related\n\n"
           :target (file+head "references/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+roam_key: cite:${citekey}\n#+category: reference\n#+date: %U\n\n")
           :unnarrowed t)
          
          ("b" "bibliography note" plain
           "* Bibliographic Information\n\n%^{citekey}p\n\n* Summary\n\n%?\n\n* Key Arguments\n\n* Methodology\n\n* Conclusions\n\n* Personal Notes\n\n* Related Papers\n\n"
           :target (file+head "references/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+roam_key: cite:${citekey}\n#+date: %U\n\n")
           :unnarrowed t))))

(provide 'slp-org-roam)
;;; config.el ends here
