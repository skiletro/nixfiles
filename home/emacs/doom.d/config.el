;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "skiletro"
      user-mail-address "19377854+skiletro@users.noreply.github.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "Iosevka Comfy" :size 21)
      doom-unicode-font (font-spec :family "Symbols Nerd Font" :size 21)
      doom-serif-font (font-spec :family "Urbanist" :size 21)
      doom-variable-pitch-font (font-spec :family "Urbanist" :size 21))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Fancy splash screen
(setq fancy-splash-image (expand-file-name "splash.svg" doom-user-dir))

;; Auto launch rainbow delimiters when in programming mode
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Org mode
(setq org-roam-directory (concat (getenv "HOME") "/OneDrive/RoamNotes"))
(setq org-hide-emphasis-markers t)

;; Automatically toggle org mode LaTeX fragment previews (requires ~org-fragtop~)
(add-hook 'org-mode-hook 'org-fragtog-mode)

(defun org-icons ()
  (interactive)
  (setq prettify-symbols-alist
        (mapcan (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
                '(("TODO" . "󰣪")
                  ("WAIT" . "")
                  ("NOPE" . "")
                  ("DONE" . "")
                  ("[ ]" . "")
                  ("[X]" . "")
                  ("[-]" . "")
                  ("#+begin_src" . "")
                  ("#+end_src" . "―")
                  ("#+begin_quote" . "")
                  ("#+end_quote" . "")
                  (":properties:" . "")
                  (":end:" . "―")
                  ("#+startup:" . "")
                  ("#+title: " . "")
                  ("#+results:" . "")
                  ("#+name:" . "")
                  ("#+filetags:" . "")
                  ("#+html_head:" . "")
                  ("#+subtitle:" . "")
                  ("#+author:" . "")
                  (":Effort:" . "")
                  ("schedule:" . "")
                  ("deadline:" . ""))))
        (prettify-symbols-mode 1))
(add-hook 'org-mode-hook 'org-icons)
