;;; init
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))



;;; visuals
(if window-system
  (menu-bar-mode -1)
)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(set-face-attribute 'default nil :font "FiraCode Nerd Font Mono" :height 110)

(use-package gruvbox-theme
  :config 
  (load-theme 'gruvbox-dark-medium t)
)



;;; misc packages
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)
  (define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package grease
  :load-path "~/.emacs.d/lisp/grease.el"
  :commands (grease-open grease-toggle grease-here)
  :init
  (setq grease-use-icons t)              ; Set to nil to disable icons
  (setq grease-sort-method 'type)        ; Default sort method
  ;;   'type      - Directories first, then files (default)
  ;;   'name      - Alphabetical by name
  ;;   'size      - By file size (smallest first)
  ;;   'size-desc - By file size (largest first)
  ;;   'date      - By modification date (oldest first)
  ;;   'date-desc - By modification date (newest first)
  ;;   'extension - By file extension
  (setq grease-sort-directories-first t) ; Always show dirs first (for non-type sorts)
  (setq grease-show-hidden t)          ; Set to t to show dotfiles by default
  (setq grease-preview-window-width 0.4) ; Preview takes 40% of frame width
  (setq grease-preview-writable nil))     ; Set to t to make file previews editable



;;; generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5a0ddbd75929d24f5ef34944d78789c6c3421aa943c15218bac791c199fc897d"
     default))
 '(package-selected-packages '(evil-collection gruvbox-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
