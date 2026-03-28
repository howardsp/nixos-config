(require 'package)
(setq package-enable-at-startup nil)
(setq package-check-signature nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/"))

;; boostrap 'use-package'
;;(unless (package-installed-p 'use-package)
(package-initialize)
(package-refresh-contents)
(package-install 'use-package)

(setq package-selected-packages
  '(use-package
    nix-mode))

(use-package nix-mode :mode "\\.nix\\'")
(use-package cmake-mode)
(use-package all-the-icons :if (display-graphic-p))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes '(wombat))
 '(ispell-dictionary nil)
 '(package-selected-packages '(use-package ## nix-mode cmake-mode))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Put backup files neatly away
(let ((backup-dir "~/.dotfiles/emacs-tmp/emacs/backups")
      (auto-saves-dir "~/.dotfiles/emacs-tmp/emacs/auto-saves/"))
  (dolist (dir (list backup-dir auto-saves-dir))
    (when (not (file-directory-p dir))
      (make-directory dir t)))
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
        auto-save-list-file-prefix (concat auto-saves-dir ".saves-")
        tramp-backup-directory-alist `((".*" . ,backup-dir))
        tramp-auto-save-directory auto-saves-dir))

(setq backup-by-copying t    ; Don't delink hardlinks
      delete-old-versions t  ; Clean up the backups
      version-control t      ; Use version numbers on backups,
      kept-new-versions 5    ; keep some new versions
      kept-old-versions 2)   ; and some old ones, too
