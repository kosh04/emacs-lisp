;;; config/newLISP

(use-package newlisp-mode
  ;; 開発版
  :load-path "~/Downloads/gitrepo/newlisp-mode"
  :mode "\\.lsp\\'"
  :bind (:map newlisp-mode-map
              ("C-c h" . newlisp-lookup-manual))
  :config
  ;;(add-hook 'newlisp-mode-hook 'eldoc-mode)
  (setq newlisp-manual-text "~/Dropbox/Documents/newlisp/newlisp_manual.txt"))

;; `c-set-style' (C-c .)
(dir-locals-set-class-variables
 'user/newlisp-c-source
 '((c-mode . ((c-file-style . "whitesmith")))))

(dir-locals-set-directory-class
 "~/Documents/GitHub/newlisp/"
 'user/newlisp-c-source)
