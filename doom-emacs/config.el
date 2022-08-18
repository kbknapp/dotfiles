;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Kevin K."
      user-mail-address "kbknapp@gmail.com")

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
(setq doom-font (font-spec :family "Fantasque Sans Mono Nerd Font" :size 14 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "Fantasque Sans Mono Nerd Font" :size 15)
      doom-big-font (font-spec :family "Fantasque Sans Mono Nerd Font" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

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

(after! projectile
 (setq projectile-project-search-path '("~/Projects/")))

(setq tab-stop-list (number-sequence 4 200 4))
(setq-default tab-width 4)

(setq shell-file-name "/usr/bin/zsh"
      eshell-aliases-file "~/.doom.d/aliases"
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "zsh")
      vterm-max-scrollback 5000)
(map! :leader
      (:prefix-map ("e" . "eshell")
       :leader
       :desc "Counsel eshell history" "h" #'counsel-esh-history))

(map! :leader
      :desc "Open org-mode" "o o" #'org-mode
      :leader
      :desc "Deadgrep" "/" #'deadgrep
      :leader
      :desc "List bookmarks" "b L" #'list-bookmarks
      :leader
      :desc "Save current bookmarks to bookmark file" "b w" #'bookmark-save
      (:prefix-map ("g m" . "smerge")
        :leader
        :desc "Keep Upper" "u" #'smerge-keep-upper
        :leader
        :desc "Keep Lower" "l" #'smerge-keep-lower
        :leader
        :desc "Keep Base" "b" #'smerge-keep-base
        :leader
        :desc "Keep All" "a" #'smerge-keep-all))

;; | COMMAND                                   | DESCRIPTION                                | KEYBINDING |
;; |-------------------------------------------+--------------------------------------------+------------|
;; | dired                                     | /Open dired file manager/                    | SPC d d    |
;; | dired-jump                                | /Jump to current directory in dired/         | SPC d j    |
;; | (in dired) peep-dired                     | /Toggle image previews within dired/         | SPC d p    |
;; | (in dired) dired-view-file                | /View file in dired/                         | SPC d v    |
;; | (in peep-dired-mode) peep-dired-next-file | /Move to next file in peep-dired-mode/       | j          |
;; | (in peep-dired-mode) peep-dired-prev-file | /Move to previous file in peep-dired-mode/   | k          |
(map! :leader
      (:prefix-map ("d" . "dired")
       :leader
       :desc "Dired" "d" #'dired
       :leader
       :desc "Dired jump to current" "j" #'dired-jump
       :leader
       :desc "Peep-dired image previews" "p" #'peep-dired
       :leader
       :desc "Dired view file" "v" #'dired-view-file))
(evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file
                                             (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(map! :leader
      :desc "Toggle truncate lines"
      "t t" #'toggle-truncate-lines)

(after! org
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)
  (require 'org-bullets)  ; Nicer bullets in org-mode
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-directory "~/Org/"
        org-agenda-files '("~/Org/agenda.org")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-log-done 'time
        org-journal-dir "~/Org/journal/"
        org-journal-date-format "%B %d, %Y (%A)"
        org-journal-file-format "%Y-%m-%d.org"
        org-hide-emphasis-markers t
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("google" . "http://www.google.com/search?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
            ("ddg" . "https://duckduckgo.com/?q=")
            ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "BLOG(b)"           ; Blog writing assignments
             "GYM(g)"            ; Things to accomplish at the gym
             "PROJ(p)"           ; A project that contains other tasks
             "VIDEO(v)"          ; Video assignments
             "WAIT(w)"           ; Something is holding up this task
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" )))) ; Task has been cancelled


;; | COMMAND                          | DESCRIPTION                      | KEYBINDING |
;; |----------------------------------+----------------------------------+------------|
;; | copy-to-register                 | /Copy to register/                 | SPC r c    |
;; | frameset-to-register             | /Frameset to register/             | SPC r f    |
;; | insert-register                  | /Insert contents of register/      | SPC r i    |
;; | jump-to-register                 | /Jump to register/                 | SPC r j    |
;; | list-registers                   | /List registers/                   | SPC r l    |
;; | number-to-register               | /Number to register/               | SPC r n    |
;; | counsel-register                 | /Interactively choose a register/  | SPC r r    |
;; | view-register                    | /View a register/                  | SPC r v    |
;; | window-configuration-to-register | /Window configuration to register/ | SPC r w    |
;; | increment-register               | /Increment register/               | SPC r +    |
;; | point-to-register                | /Point to register/                | SPC r SPC  |

(map! :leader
      (:prefix-map ("r" . "register")
       :leader
       :desc "Copy to register" "c" #'copy-to-register
       :leader
       :desc "Frameset to register" "f" #'frameset-to-register
       :leader
       :desc "Insert contents of register" "i" #'insert-register
       :leader
       :desc "Jump to register" "j" #'jump-to-register
       :leader
       :desc "List registers" "l" #'list-registers
       :leader
       :desc "Number to register" "n" #'number-to-register
       :leader
       :desc "Interactively choose a register" "r" #'counsel-register
       :leader
       :desc "View a register" "v" #'view-register
       :leader
       :desc "Window configuration to register" "w" #'window-configuration-to-register
       :leader
       :desc "Increment register" "+" #'increment-register
       :leader
       :desc "Point to register" "SPC" #'point-to-register))


(after! avy
  (map! :leader
        (:prefix-map ("s" . "search")
        :leader
        :desc "Avy-Goto-Char" "a" #'avy-goto-char)))

(after! rustic
        (setq rustic-lsp-server 'rust-analyzer))

(add-hook 'before-save-hook (lambda () (when (eq 'rust-mode major-mode)
                                           (lsp-format-buffer))))


; ;; Deadgrep
; ;; https://github.com/Wilfred/deadgrep
;
(after! deadgrep
;  :ensure t
;  :defer t
;  :init
;  (progn
;    (bind-to-modi-map "r" #'deadgrep))
;  :config
;  (progn
    (setq-default deadgrep--search-type 'regexp) ;Default is 'string

    (defconst modi/deadgrep--rg-extra-args
      `("--no-ignore-vcs"       ;Ignore files/dirs ONLY from `.ignore'
        "--follow"              ;Follow symlinks
        "--hidden"              ;Search hidden files
        "--ignore-file" ,(expand-file-name ".ignore" (getenv "HOME")))
      "Extra rg arguments to be added to `deadgrep--format-command' output.")

    ;; Thu Aug 23 15:51:37 EDT 2018 - kmodi
    ;; Adding extra arguments to the ones
    ;; already in `deadgrep--format-command' --
    ;; https://github.com/Wilfred/deadgrep/issues/24
    (defun modi/deadgrep--format-command-advice (orig-ret-val)
      "Add arguments from `modi/deadgrep--rg-extra-args' to ORIG-RET-VAL."
      (let ((new-ret (replace-regexp-in-string
                      (format "\\`\\(%s \\)\\(.*\\)\\'" (regexp-quote deadgrep-executable))
                      (concat "\\1"
                              (mapconcat #'identity modi/deadgrep--rg-extra-args " ")
                              " \\2")
                      orig-ret-val)))
        (message "[Deadgrep] %s" new-ret)
        new-ret))
    (advice-add 'deadgrep--format-command :filter-return #'modi/deadgrep--format-command-advice)

    (defun modi/deadgrep--jump-to-and-execute (re)
      "Execute the button that matches RE and push it."
      (goto-char (point-min))
      (re-search-forward re)
      (backward-char 3)
      (push-button))

    (defun modi/deadgrep-change-search-term ()
      "Change the search term."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Search term: .*change$"))

    (defun modi/deadgrep-change-search-type-to-string ()
      "Change the search type to 'string'."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Search type: .*string"))

    (defun modi/deadgrep-change-search-type-to-words ()
      "Change the search type to 'words'."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Search type: .*words"))

    (defun modi/deadgrep-change-search-type-to-regexp ()
      "Change the search type to 'regexp'."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Search type: .*regexp"))

    (defun modi/deadgrep-change-case-to-smart ()
      "Change the case sensitivity to 'smart'."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Case: .*smart"))

    (defun modi/deadgrep-change-case-to-sensitive ()
      "Change the case sensitivity to 'sensitive'."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Case: .*sensitive"))

    (defun modi/deadgrep-change-case-to-ignore ()
      "Change the case sensitivity to 'ignore'."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Case: .*ignore"))

    (defun modi/deadgrep-change-context-to-none ()
      "Don't show ny context around the search results."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Context: .*none"))

    (defun modi/deadgrep-change-context-to-before ()
      "Set 'before' context for the search results."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Context: .*before"))

    (defun modi/deadgrep-change-context-to-after ()
      "Set 'after' context for the search results."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Context: .*after"))

    (defun modi/deadgrep-change-directory ()
      "Change the root directory for searches."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Directory: .*$"))

    (defun modi/deadgrep-search-all-files ()
      "Change file search scope to 'all'."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Files: .*all"))

    (defun modi/deadgrep-search-files-by-type ()
      "Search only in the specified file types."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Files: .*type"))

    (defun modi/deadgrep-search-files-by-glob ()
      "Search in files names that match the specified glob."
      (interactive)
      (modi/deadgrep--jump-to-and-execute "^Files: .*glob")))

(after! deadgrep
    (map! :map deadgrep-mode
      :leader
      (:prefix-map ("s g" . "ripgrep")
      :leader
      :desc "Restart" "r" #'deadgrep-restart
      :leader
      :desc "Change Term" "s" #'modi/deadgrep-change-search-term
      :leader
      :desc "Change Directory" "d" #'modi/deadgrep-change-directory
      :leader
      (:prefix-map ("c" . "Case")
        :leader
        :desc "Ignore" "i" #'modi/deadgrep-change-case-to-ignore
        :leader
        :desc "Smart" "s" #'modi/deadgrep-change-case-to-smart
        :leader
        :desc "Smart" "S" #'modi/deadgrep-change-case-to-sensitive)
      :leader
      (:prefix-map ("t" . "Type")
        :leader
        :desc "String" "s" #'modi/deadgrep-change-search-type-to-string
        :leader
        :desc "Words" "w" #'modi/deadgrep-change-search-type-to-words
        :leader
        :desc "Regex" "r" #'modi/deadgrep-change-search-type-to-regexp)
      :leader
      (:prefix-map ("f" . "Files")
        :leader
        :desc "All" "a" #'modi/deadgrep-search-all-files
        :leader
        :desc "Type" "t" #'modi/deadgrep-search-files-by-type
        :leader
        :desc "Glob" "g" #'modi/deadgrep-search-files-by-glob)
      :leader
      (:prefix-map ("C" . "Context")
        :leader
        :desc "Before" "b" #'modi/deadgrep-change-context-to-before
        :leader
        :desc "After" "a" #'modi/deadgrep-change-context-to-after
        :leader
        :desc "None" "n" #'modi/deadgrep-change-context-to-none))))
