;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Note: Don't need to run `doom sync` after editing
(setq shell-file-name (executable-find "bash")) ;; Fixes garbage in child proccesses
(setq-default vterm-shell (executable-find "fish")) ;; Set fish back to the vterm shell
(setq-default explicit-shell-file-name (executable-find "fish"))

(setq user-full-name "skiletro"
      user-mail-address "19377854+skiletro@users.noreply.github.com")

(setq doom-font (font-spec :family "Iosevka Comfy" :size 14)
      doom-symbol-font (font-spec :family "Symbols Nerd Font" :size 14)
      doom-serif-font (font-spec :family "Urbanist" :size 14)
      doom-variable-pitch-font (font-spec :family "Urbanist" :size 14))

(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")
(setq org-roam-directory "~/org/roam/")

(setq org-startup-with-inline-images t)
(setq org-startup-with-latex-preview t)

(setq fancy-splash-image (expand-file-name "splash.svg" doom-user-dir))

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'org-mode-hook 'org-fragtog-mode)

(setq org-hide-emphasis-markers t) ;; hide stuff like the *s around *bold text*

;; Bit of a hacky fix, idk if its a bug with emacs pgtk but when scaling, emacs renders weird
(if (string= (system-name) 'themis) ;; If the hostname matches my laptop (using 1.5x scaling)...
    (after! org
      (plist-put org-format-latex-options :scale 0.75))) ;; ...adjust the scaling of the latex preview

;; Custom template (mainly just to remove the timestamp from file name)
(setq org-roam-capture-templates
      '(("d" "default" plain "%?"
         :target (file+head "${slug}.org"
                            "#+title: ${title}\n#+filetags:")
         :unnarrowed t)))

;; More pretty org-mode icons
(setq org-ellipsis "▸")
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
                  ("deadline:" . "")
                  (":toc:" . "󰠶"))))
  (prettify-symbols-mode 1))
(add-hook 'org-mode-hook 'org-icons)
