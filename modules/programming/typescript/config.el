;;; typescript/config.el --- Typescript extends JavaScript with static typing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package typescript-mode
  :ensure t
  :hook ((typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)))

(provide 'slp-typescript)
;;; config.el ends here
