;;; from MrJay
;; Ensure Emacs loads the most recent byte-compiled files.
(setq load-prefer-newer t)

;; ;; Ensure JIT compilation is enabled for improved performance by
;; ;; native-compiling loaded .elc files asynchronously
;; (setq native-comp-jit-compilation t)
;; (setq native-comp-deferred-compilation t) ; Deprecated in Emacs > 29.1


;; Temporarily increase the garbage collection threshold.  These
;; changes help shave off about half a second of startup time.  The
;; `most-positive-fixnum' is DANGEROUS AS A PERMANENT VALUE.  See the
;; `emacs-startup-hook' a few lines below for what I actually use.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.5)

;; Same idea as above for the `file-name-handler-alist' and the
;; `vc-handled-backends' with regard to startup speed optimisation.
;; Here I am storing the default value with the intent of restoring it
;; via the `emacs-startup-hook'.
(defvar prot-emacs--file-name-handler-alist file-name-handler-alist)
(defvar prot-emacs--vc-handled-backends vc-handled-backends)



(setq file-name-handler-alist nil
      vc-handled-backends nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 1024 1024 100)
                  gc-cons-percentage 0.5
                  file-name-handler-alist prot-emacs--file-name-handler-alist
                  vc-handled-backends prot-emacs--vc-handled-backends)))

;;; my stuff
(if window-system
  (tool-bar-mode -1)
  (menu-bar-mode -1)
)

(set-face-attribute 'default nil :font "FiraCode Nerd Font Mono" :height 110)
(setq frame-inhibit-implied-resize t)

;;; auto reopen
(save-place-mode 1)
(savehist-mode 1)
(recentf-mode 1)

(setq desktop-restore-eager 5)
(setq desktop-restore-frames nil)
(desktop-save-mode 1)
