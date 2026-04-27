;;; jinx/config.el --- General-purpose spellchecker by Mendel -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package jinx
  :ensure t
  :hook (emacs-startup . global-jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jing-languages)))

(provide 'slp-jinx)
;;; config.el ends here
