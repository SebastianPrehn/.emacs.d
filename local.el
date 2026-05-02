;;; local.el --- Modules declared locally. -*- lexical-binding: t -*-
;;; Commentary:

;; Run the below command to not see this file appear in git changes once the template has been pulled.
;; git update-index --skip-worktree local.el

;; Run the following to track it again if you want to change the template and push it up.
;; git update-index --no-skip-worktree local.el

;;; Code:

;; Declare modules
(slp/modules!
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
 :editor meow
 :org org
 :org org-roam
 :org org-ref
 :os macos
 :programming eglot
 :programming markdown
 :programming latex
 :programming rust
 :programming typescript
 :programming zig
 :programming futhark
 :programming nix
 :social erc
 :spellcheck jinx
 :tools dired
 :tools elfeed
 :tools flycheck
 :ui theme
 :ui modeline
 :vc diff-hl
 :vc magit
 )

(provide 'slp-local)
;;; local.el ends here
