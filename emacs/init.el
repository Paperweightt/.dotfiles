;;; init
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))



;;; visuals
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(set-face-attribute 'default nil :font "FiraCode Nerd Font Mono" :height 110)

(use-package gruvbox-theme
  :config 
  (load-theme 'gruvbox-dark-medium t)
)



;;; nvim packages
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-set-leader 'normal (kbd "SPC"))

  (define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)
  (define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)

  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(use-package grease
  :after evil
  :load-path "~/.dotfiles/emacs/site-lisp/grease.el"
  :commands (grease-open grease-toggle grease-here)
  :config
  (setq grease-show-hidden t)          ; Set to t to show dotfiles by default
  (setq grease-preview-window-width 0.4) ; Preview takes 40% of frame width
  (setq grease-preview-writable nil))     ; Set to t to make file previews editable
  (define-key evil-normal-state-map (kbd "-") 'grease-here)



;;; search
(use-package vertico
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "C-n") #'vertico-next)
  (define-key evil-normal-state-map (kbd "C-p") #'vertico-previous)
  (vertico-mode))

(use-package emacs
  :custom
  (context-menu-mode t)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

;; Example configuration for Consult
(use-package consult
  :ensure t
  :after evil
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (define-key evil-normal-state-map (kbd "<leader>sg") #'consult-ripgrep)
  (define-key evil-normal-state-map (kbd "<leader>sf") #'consult-find)
  (define-key evil-normal-state-map (kbd "<leader>sh") #'consult-history)
  (define-key evil-normal-state-map (kbd "<leader>SPC") #'consult-buffer)
)



;;; generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5a0ddbd75929d24f5ef34944d78789c6c3421aa943c15218bac791c199fc897d"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
