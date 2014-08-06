(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" .
    "http://melpa.milkbox.net/packages/") t)
  (package-initialize)

  (setq gofmt-command "goimports")

  (require 'flymake-rust)
  (add-hook 'rust-mode-hook 'flymake-rust-load)

  (require 'evil)
  (evil-mode 1)

  (add-to-list 'load-path "~/.emacs.d/racer/")
  (require 'racer)
)
