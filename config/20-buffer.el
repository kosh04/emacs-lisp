;;; config/buffer.el

;; Buffer List
(global-set-key (kbd "C-x C-b") 'bs-show)
(add-hook 'bs-mode-hook 'hl-line-mode)
(add-hook 'buffer-menu-mode-hook 'hl-line-mode)