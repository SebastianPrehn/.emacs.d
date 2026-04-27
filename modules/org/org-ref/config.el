;;; org-ref/config.el --- Organize bibliography and references through Emacs -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; Bibliography and citation management
(use-package org-ref
  :after org
  :custom
  ;; Bibliography files
  (org-ref-default-bibliography 
   (list (expand-file-name "references/bibliography.bib" org-directory)))
  (org-ref-pdf-directory 
   (expand-file-name "references/pdfs/" org-directory))
  (org-ref-notes-directory 
   (expand-file-name "roam/references/" org-directory))

  ;; Use Org Roam for notes
  (org-ref-notes-function 'org-ref-notes-function-many-files)

  ;; Citation format
  (org-ref-default-citation-link "cite")

  :config
  ;; Make org-ref work with Org Roam notes
  (defun slp/org-ref-notes-function (key)
    "Open or create an Org Roam note for citation KEY."
    (let* ((title (org-ref-get-bibtex-key-and-file key))
           (node (org-roam-node-from-title-or-alias 
                  (format "@%s" key))))
      (if node
          (org-roam-node-visit node)
        (org-roam-capture-
         :node (org-roam-node-create :title (format "@%s" key))
         :templates
         '(("r" "reference" plain
            "* Source\n\nCitekey: %^{citekey}\n\n* Summary\n\n%?\n\n* Notes\n\n"
            :target (file+head "references/${citekey}.org"
                               "#+title: @${citekey}\n#+roam_key: cite:${citekey}\n#+date: %U\n\n")
            :unnarrowed t))))))
  
  (setq org-ref-notes-function 'slp/org-ref-notes-function))

(provide 'slp-org-ref)
;;; config.el ends here
