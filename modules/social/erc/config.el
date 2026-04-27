;;; erc/config.el --- Chatting like it's the 90s -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package erc
  :ensure nil
  :config
  (setopt erc-modules
          (seq-union '(nicks bufbar nickbar scrolltobottom)
                      erc-modules))
  :custom
  ;; Avoid sending excess lines
  (erc-inhibit-multiline-input t)
  (erc-send-whitespace-lines t)
  (erc-ask-about-multiline-input t)
  ;; Scroll all windows to prompt when submitting input.
  (erc-scrolltobottom-all t)
  ;;  Reconnect automatically
  (erc-server-reconnect-function #'erc-server-delayed-check-reconnect)
  (erc-server-reconnect-timeout 30)

  (erc-nick (or (bound-and-true-p my-irc-nick) "user"))
  (erc-user-full-name (or (bound-and-true-p my-irc-full-name) "User"))
  ;; Show new buffers in the current window instead of a split.
  (erc-interactive-display 'buffer)

  (erc-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
  ;; Emphasize buttonized text in notices.
  :custom-face (erc-notice-face ((t (:slant italic :weight unspecified)))))

(use-package erc-join
  :ensure nil
  :custom 
  (erc-autojoin-channels-alist
   (or (bound-and-true-p my-irc-channels)
       '())))

(use-package erc-fill
  :ensure nil
  :custom
  ;; Prefer one message per line without continuation indicators.
  (erc-fill-function #'erc-fill-wrap)
  (erc-fill-static-center 18))

(defun slp/connect-libera ()
     (interactive)
     (erc-tls :server "irc.libera.chat" :port 6697
              :client-certificate t))

(provide 'slp-erc)
;;; config.el ends here
