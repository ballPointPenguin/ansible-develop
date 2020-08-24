;;; init.el --- Initialization file for Emacs

;;; Commentary:
;;; Emacs Startup File --- initialization for Emacs

;;; https://www.sandeepnambiar.com/my-minimal-emacs-setup/
;;; Code:
(setq user-full-name "Benjamin Rosas"
      user-mail-address "ben@aliencyb.org")

(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(menu-bar-mode -1)
;(toggle-scroll-bar -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)

(global-hl-line-mode +1)
(line-number-mode +1)
(global-display-line-numbers-mode 1)
(column-number-mode t)
(size-indication-mode t)

(setq inhibit-startup-screen t)

(setq frame-title-format
      '((:eval (if (buffer-file-name)
       (abbreviate-file-name (buffer-file-name))
     "%b"))))

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(set-frame-font "Hack 12" nil t)

(use-package doom-themes
       :ensure t
       :config
       (load-theme 'doom-one t)
       (doom-themes-visual-bell-config))

(use-package smart-mode-line-powerline-theme
       :ensure t)

(use-package smart-mode-line
       :ensure t
       :config
       (setq sml/theme 'powerline)
       (add-hook 'after-init-hook 'sml/setup))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(fset 'yes-or-no-p 'y-or-n-p)

(global-auto-revert-mode t)

(setq-default tab-width 2
        indent-tabs-mode nil)

(global-set-key (kbd "C-x k") 'kill-this-buffer)

(add-hook 'before-save-hook 'whitespace-cleanup)

(use-package diminish
       :ensure t)

(use-package smartparens
       :ensure t
       :diminish smartparens-mode
       :config
       (progn
         (require 'smartparens-config)
         (smartparens-global-mode 1)
         (show-paren-mode t)))

(use-package expand-region
       :ensure t
       :bind ("M-m" . er/expand-region))

(use-package crux
       :ensure t
       :bind
       ("C-k" . crux-smart-kill-line)
       ("C-c n" . crux-cleanup-buffer-or-region)
       ("C-c f" . crux-recentf-find-file)
       ("C-a" . crux-move-beginning-of-line))

(use-package which-key
       :ensure t
       :diminish which-key-mode
       :config
       (which-key-mode +1))

(use-package avy
       :ensure t
       :bind
       ("C-=" . avy-goto-char)
       :config
       (setq avy-background t))

(use-package company
       :ensure t
       :diminish company-mode
       :config
       (add-hook 'after-init-hook #'global-company-mode))

(use-package flycheck
       :ensure t
       :diminish flycheck-mode
       :config
       (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package magit
  :bind (("C-M-g" . magit-status)))


(use-package projectile
       :ensure t
       :diminish projectile-mode
       :bind
       (("C-c p f" . helm-projectile-find-file)
        ("C-c p p" . helm-projectile-switch-project)
        ("C-c p s" . projectile-save-project-buffers))
       :config
       (projectile-mode +1)
       )

(require 'helm)
(use-package helm
       :ensure t
       :defer 2
       :bind
       ("M-x" . helm-M-x)
       ("C-x C-f" . helm-find-files)
       ("M-y" . helm-show-kill-ring)
       ("C-x b" . helm-mini)
       :config
       (require 'helm-config)
       (helm-mode 1)
       (setq helm-split-window-inside-p t
       helm-move-to-line-cycle-in-source t)
       (setq helm-autoresize-max-height 0)
       (setq helm-autoresize-min-height 20)
       (helm-autoresize-mode 1)
       (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind TAB to run persistent action
       (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
       (define-key helm-map (kbd "C-z") 'helm-select-action) ; list actions using C-z
       )

(use-package helm-projectile
       :ensure t
       :config
       (helm-projectile-on))

(require 'server)
(if (not (server-running-p)) (server-start))

(provide 'init)
;;; init.el ends here


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
