;;; init.el — Emacs configuration (packages managed by Nix, not package.el)

;; ── Package system ────────────────────────────────────────────────────────
;; Nix populates the load-path via extraPackages; package.el is not needed.
(setq package-enable-at-startup nil)

;; ── Custom file ───────────────────────────────────────────────────────────
;; Redirect Emacs-written customizations to a mutable file so that
;; init.el (a read-only Nix store symlink) is never written to.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; ── use-package ───────────────────────────────────────────────────────────
;; use-package is provided by Nix; :ensure is not needed — never use it.
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure nil)   ; packages come from Nix, not ELPA

;; ── Languages ─────────────────────────────────────────────────────────────
(use-package nix-mode
  :mode "\\.nix\\'")

(use-package cmake-mode)

;; ── UI ────────────────────────────────────────────────────────────────────
(use-package all-the-icons
  :if (display-graphic-p))

;; Load wombat theme (built-in)
(load-theme 'wombat t)

;; ── Built-in settings ─────────────────────────────────────────────────────
(cua-mode t)             ; familiar cut/copy/paste keys
(show-paren-mode t)      ; highlight matching parentheses

;; ── Backups & auto-save ───────────────────────────────────────────────────
;; Keep backups out of working directories, inside ~/.cache/emacs/
(let ((backup-dir   (expand-file-name "backups"   "~/.cache/emacs"))
      (auto-save-dir (expand-file-name "auto-saves" "~/.cache/emacs")))
  (dolist (dir (list backup-dir auto-save-dir))
    (unless (file-directory-p dir)
      (make-directory dir t)))
  (setq backup-directory-alist         `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-save-dir t))
        auto-save-list-file-prefix     (concat auto-save-dir "/.saves-")
        tramp-backup-directory-alist   `((".*" . ,backup-dir))
        tramp-auto-save-directory      auto-save-dir))

(setq backup-by-copying t   ; don't delink hardlinks
      delete-old-versions t ; clean up old backups
      version-control t     ; use version numbers on backups
      kept-new-versions 5
      kept-old-versions 2)
