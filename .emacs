;; Include melpa
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )

;; List of packages
(setq package-list '(ledger-mode gnuplot-mode auto-complete yasnippet yasnippet-snippets auto-complete-c-headers flymake-google-cpplint flymake-cursor google-c-style))

;; Activate all the packages (in particular autoloads)
(package-initialize)

;; Fetch the list of packages available
(unless package-archive-contents
  (or (file-exists-p package-user-dir)
      (package-refresh-contents)))

;; Install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
        (package-install package)))

;; ledger-mode
(require 'ledger-mode)
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

;; gnuplot-mode
(require 'gnuplot-mode)
  (setq auto-mode-alist (append '(("\\.gnuplot$" . gnuplot-mode)) auto-mode-alist))

;; auto-complete
(require 'auto-complete)
;; default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; yasnippet
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20180621.50/")
(require 'yasnippet)
(require 'yasnippet-snippets)
(yas-global-mode 1)

;; function which initializes auto-complete-c-hedears (gets called for c/c++ hooks)
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu/c++/5"))
;; call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
;; Find out where system header files are using gcc -xc++ -E -v -

;; Fix iedit bug in Mac
;; (define-key global-map (kbd "C-c ;") 'iedit-mode)

;; flymake-google-cpplint
;; (you need to install cpplint with pip)
(defun my:flymake-google-initializer ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "cpplint"))
  (flymake-google-cpplint-load)
  )
(add-hook 'c-mode-hook 'my:flymake-google-initializer)
(add-hook 'c++-mode-hook 'my:flymake-google-initializer)
;; start flymake-cursor with emacs
(require 'flymake-cursor)

;; start google-c-style with emacs
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; semantic
(semantic-mode 1)
;; function that adds semantic as suggestion backend for auto-complete
;; and hook it to c-mode-common-hook
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
;; Turn on auto reparsing of open buffers for semantic
(global-semantic-idle-scheduler-mode 1)

;; launch c++-mode for CUDA code
(add-to-list 'auto-mode-alist '("\\.cu$" . c++-mode))
