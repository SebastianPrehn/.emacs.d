;;; latex/config.el --- Typesetting system useful in an academic setting -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package auctex
  :hook (LaTeX-mode . (lambda ()
                        (turn-on-reftex)
                        (LaTeX-math-mode)))
  :config
  (setq TeX-PDF-mode t) ; Use PDF mode by default
  ;; Automatically save style information
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)

  ;; Make AUCTeX aware of multi-file documents
  (setq-default TeX-master nil)

  ;; Enable synctex for correlation between source and PDF
  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-start-server t)
  (setq TeX-source-correlate-method 'synctex)

  ;; Set up viewers
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
        TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view)))

  ;; Update PDF buffers after successful LaTeX runs
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer))

;; Configure PDF Tools for better integration
(use-package pdf-tools
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-annot-activate-created-annotations t))

;; RefTeX for references, labels, and citations
(use-package reftex
  :ensure nil
  :config
  (setq reftex-plug-into-AUCTeX t)
  ;; Automatically insert labels for sections, equations, etc.
  (setq reftex-insert-label-flags '("s" "sfte"))
  ;; Use separate selection buffers for different reference types
  (setq reftex-ref-style-default-list '("Default" "Hyperref"))
  ;; Better label prefixes
  (setq reftex-label-alist
        '((nil ?s nil nil nil ("Section" "Sec."))
          ("equation" ?e nil nil nil ("Equation" "Eq."))
          ("figure" ?f nil nil nil ("Figure" "Fig."))
          ("table" ?t nil nil nil ("Table" "Tab.")))))

(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(tex-chktex)))

(provide 'slp-latex)
;;; config.el ends here
