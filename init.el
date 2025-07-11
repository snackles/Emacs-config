(setq debug-on-error  t)

(eval-when-compile
  (require 'use-package))
 
(setq redisplay-dont-pause t
  scroll-margin 5
  scroll-step 1
  scroll-conservatively 10000
	scroll-preserve-screen-position 1)
 
(global-set-key "\C-x\ \C-g" 'recentf-open-files)

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                          ("melpa" . "http://melpa.org/packages/")))

;; Example configuration for Consult
(use-package consult
  :ensure t
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element
  )
 
(use-package lsp-haskell
  :ensure t)
 
(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))
 
(use-package company
  :ensure t
  :hook (c++-mode c-mode rust-mode haskell-mode glsl-mode js2-mode)
;;  :hook (after-init global-company-mode)
  :config
  (setq company-minimum-prefix-length 1
		company-idle-delay 0.01)
  (define-key company-active-map (kbd "C-n") nil)
  (define-key company-active-map (kbd "C-p") nil)
  (define-key company-active-map (kbd "<tab>") #'company-select-next)
  (define-key company-active-map (kbd "<backtab>") #'company-select-previous))
 
(use-package lsp-ui
  :ensure t)
 
(use-package lsp-mode
  :ensure t
  :hook (c++-mode c-mode rust-mode haskell-mode haskell-literate-mode js2-mode)
  :config
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024))
  (setq lsp-idle-delay 0.100)
  (setq lsp-log-io nil)
  (setq lsp-ui-doc-show-with-cursor t))
 
(use-package vertico
  :ensure t
  :init
  (vertico-mode))
 
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
 
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-center-content t)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t))
 
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))
 
(use-package visual-regexp
  :ensure t
  :config
  (define-key global-map (kbd "C-c r") 'vr/replace)
  (define-key global-map (kbd "C-c q") 'vr/query-replace))
 
(use-package ace-jump-mode
  :ensure t
  :config
  (autoload
	'ace-jump-mode
	"ace-jump-mode"
	"Emacs quick move minor mode"
	t)
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode))
 
(use-package rust-mode
  :ensure t
  :mode ("\\.rs\\'" . rust-mode)
  :interpreter ("rust-mode" . rust-mode))
 
(use-package haskell-mode
  :ensure t
  :mode ("\\.hs\\'" . haskell-mode)
  :interpreter ("haskell-mode" . haskell-mode))
 
(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode)
  :interpreter ("js2-mode" . js2-mode))
 
(use-package glsl-mode
  :ensure t)
 
(use-package slime
  :ensure t
  :custom
  (slime-setup '(slime-asdf
				 slime-fancy
				 slime-indentation)))
 
(use-package ac-slime
  :ensure t
  :hook (((slime-mode slime-repl-mode) . set-up-slime-ac)
		 ((slime-mode slime-repl-mode) . auto-complete-mode))
  :custom
  (eval-after-load "auto-complete"
	'(add-to-list 'ac-modes 'slime-repl-mode)))
 
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(glsl-mode . "glsl"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("glslls" "--stdin"))
                    :activation-fn (lsp-activate-on "glsl")
                    :server-id 'glslls)))
 
(use-package tree-sitter
  :ensure t
  :hook ((c++-mode c-mode rust-mode haskell-mode glsl-mode) . tree-sitter-hl-mode)
  :config
  (global-tree-sitter-mode))
 
(use-package tree-sitter-langs
  :ensure t)
 
(use-package hl-todo
  :ensure t)
 
(use-package magit-todos
  :ensure t
  :config
  (magit-todos-mode))
 
(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))
 
(use-package dap-mode
  :ensure t
  :config
  (global-hl-todo-mode))
 
(require 'dap-lldb)
;;(require 'dap-gdb-lldb)
;;(require 'dap-cpptools)
 
(dap-register-debug-template
  "LLDB::Run My Run"
  (list :type "lldb-vscode"
        :request "launch"
        :name "LLDB::Run"
        :MIMode "lldb"))
 
;; (dap-register-debug-template
;;   "GDB::Run!"
;;   (list :type "gdb"
;;         :request "launch"
;;         :name "GDB::Run"
;;         :target "/home/cyberdemon/cyberDemonCode/C++/algorythms/binarySearch/bin"
;;         :cwd "/home/cyberdemon/cyberDemonCode/C++/algorythms/binarySearch/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(c-default-style
   '((c-mode . "cc-mode")
	 (c++-mode . "cc-mode")
	 (java-mode . "java")
	 (awk-mode . "awk")
	 (other . "gnu")))
 '(compile-command
   "make -f MakefileLin clean && bear -- make -j20 -f MakefileLin")
 '(custom-safe-themes
   '("d5fd482fcb0fe42e849caba275a01d4925e422963d1cd165565b31d3f4189c87" default))
 '(display-line-numbers nil)
 '(display-line-numbers-type t)
 '(global-display-line-numbers-mode t)
 '(inferior-lisp-program "sbcl" t)
 '(lsp-haskell-server-path "haskell-language-server-wrapper")
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(lsp-jedi ipython-shell-send ac-js2 js2-mode gruvbox-theme multiple-cursors magit-todos atom-one-dark-theme monokai-theme idea-darkula-theme darcula-theme foggy-night-theme glsl-mode dap-mode ac-slime slime haskell-mode lsp-haskell tree-sitter-langs tree-sitter rust-mode ace-jump-mode visual-regexp all-the-icons dashboard orderless vertico flycheck lsp-ui eglot company lsp-mode consult use-package))
 '(recentf-mode t)
 '(scroll-bar-mode nil)
 '(tab-bar-select-tab-modifiers nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(warning-suppress-log-types
   '((el-get)
	 (el-get)
	 (el-get)
	 (el-get)
	 (comp)
	 (comp)
	 (comp)
	 (comp)
	 (comp)
	 (comp)
	 (comp)
	 (comp)))
 '(warning-suppress-types
   '((el-get)
	 (el-get)
	 (comp)
	 (comp)
	 (comp)
	 (comp)
	 (comp)
	 (comp)
	 (comp)
	 (comp)
	 (comp)
	 (comp))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :family "Jet Brains Mono Nerd Font"))))
 '(font-lock-keyword-face ((t (:foreground "rosy brown" :weight bold))))
 '(link ((t (:foreground "SlateGray3" :underline t)))))
(load-theme 'gruvbox)
 

