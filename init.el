(require 'subr-x)
;;=========================org mode=====================================

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                     ("marmalade" . "http://marmalade-repo.org/packages/")
                     ("melpa" . "http://melpa.org/packages/")))
(setq package-check-signature nil)
(package-initialize)
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))
(setq org-todo-keywords
  '((type "工作(w!)" "学习(s!)" "休闲(l!)" "|")
    (sequence "PENDING(p!)" "TODO(t!)"  "|" "DONE(d!)" "ABORT(a@/!)")
))
(setq org-todo-keyword-faces
  '(("工作" .      (:background "red" :foreground "white" :weight bold))
    ("学习" .      (:background "white" :foreground "red" :weight bold))
    ("休闲" .      (:foreground "MediumBlue" :weight bold)) 
    ("PENDING" .   (:background "LightGreen" :foreground "gray" :weight bold))
    ("TODO" .      (:background "DarkOrange" :foreground "black" :weight bold))
    ("DONE" .      (:background "azure" :foreground "Darkgreen" :weight bold)) 
    ("ABORT" .     (:background "gray" :foreground "black"))
    ))
;; 优先级范围和默认任务的优先级
(setq org-highest-priority ?A)
(setq org-lowest-priority  ?E)
(setq org-default-priority ?E)
;; 优先级醒目外观
(setq org-priority-faces
  '((?A . (:background "red" :foreground "white" :weight bold))
    (?B . (:background "DarkOrange" :foreground "white" :weight bold))
    (?C . (:background "yellow" :foreground "DarkGreen" :weight bold))
    (?D . (:background "DodgerBlue" :foreground "black" :weight bold))
    (?E . (:background "SkyBlue" :foreground "black" :weight bold))
    ))
;;calendar
(setq mark-holidays-in-calendar t)
(setq my-holidays
    '(;;公历节日
      (holiday-fixed 2 14 "情人节")
      (holiday-fixed 9 10 "教师节")
      (holiday-float 6 0 3 "父亲节")
      ;; 农历节日
      (holiday-lunar 1 1 "春节" 0)
      (holiday-lunar 1 15 "元宵节" 0)
      (holiday-solar-term "清明" "清明节")
      (holiday-lunar 5 5 "端午节" 0)
      (holiday-lunar 7 7 "七夕情人节" 0)
      (holiday-lunar 8 15 "中秋节" 0)
      ;;纪念日
      (holiday-fixed 3 25 "儿子生日")
      (holiday-lunar 10 16 "老婆生日"  0)
      (holiday-lunar 3 20 "我的生日" 0)
      ))

(setq calendar-holidays my-holidays)  ;只显示我定制的节假日
(setq org-log-done 'note)
;;日程表文件
(setq org-agenda-files (list "/Users/sunyang/Work/agenda/"))
(global-set-key "\C-ca" 'org-agenda)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eww-search-prefix "https://www.baidu.com/s?wd=")
 '(org-agenda-files
   (quote
    ("~/Work/agenda/life_agenda.txt" "~/Work/agenda/work_agenda.txt")) t)
 '(package-selected-packages
   (quote
    (ac-slime slime ps-ccrypt go-guru go-complete go-fill-struct cider w3 ivy company ggtags))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;ggtags
(add-to-list 'load-path "/Users/sunyang/.emacs.d/elpa/ggtags") 
(require  'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))
(provide 'init-ggtags)
;;color-theme
(add-to-list 'load-path "/Users/sunyang/.emacs.d/elpa/color-theme/color-theme-6.6.0") 
(add-to-list 'load-path "/Users/sunyang/.emacs.d/elpa/color-theme/color-theme-6.6.0/themes") 
(require 'color-theme)
(color-theme-initialize)
;;(require 'color-theme-library)
;;(require 'color-theme-example.el)
(color-theme-gray30)
;;ivy
(add-to-list 'load-path "/Users/sunyang/.emacs.d/elpa/ivy/swiper/targets")
(add-to-list 'load-path "/Users/sunyang/.emacs.d/elpa/ivy/swiper")
(require 'ivy)
(require 'swiper)
(require 'counsel)
;;(require 'plain)
(ivy-mode)
(counsel-mode)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-c s") 'isearch-forward-regexp)

;;eacl
(add-to-list 'load-path "/Users/sunyang/.emacs.d/elpa/eacl")
(require 'eacl)
(setq eacl-grep-program "grep")
;;dict
;; merriam-webster dictionary
(defvar webster-url "http://www.m-w.com/cgi-bin/dictionary?book=Dictionary&va=")

(defun merriam (word)
  (interactive "slook up a word in merriam-webster: ")
  (let (start (point))
    ;; 
    (cond ((string= (format "%s" (current-buffer)) "*eww*")
           (eww-browse-url (concat webster-url word)))
          ;; 
          ((bufferp (get-buffer "*eww*"))
           (progn (view-buffer-other-window (get-buffer "*eww*"))
                  (eww-browse-url (concat webster-url word))))
          ;; 
          (t
           (progn (view-buffer-other-window (get-buffer "*scratch*"))
                  (eww-browse-url (concat webster-url word)))))))
(global-set-key "\M-]" 'merriam)
;;; 调用w3m库 
;;(autoload 'w3m "w3m" "interface for w3m on emacs" t) 
;;(add-to-list 'load-path "/Users/sunyang/.emacs.d/elpa/w3m-20180405.520/")
(add-to-list 'load-path "/Users/sunyang/.emacs.d/elpa/w3m_github/w3m")
;;(require 'mime-w3m)
;;(require 'w3m-image)
;;(require 'w3m-session)
;;(require 'w3m-search)
;;(require 'w3m-cookie)
;; 设置w3m主页
(setq w3m-home-page "http://www.baidu.com")
;; 默认显示图片
(setq w3m-default-display-inline-images t)
(setq w3m-default-toggle-inline-images t)
;; 使用cookies
(setq w3m-command-arguments '("-cookie" "-F"))
(setq w3m-use-cookies t)
(setq browse-url-browser-function 'w3m-browse-url)                
(setq w3m-view-this-url-new-session-in-background t)
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
 (global-set-key "\C-xm" 'browse-url-at-point)
;;eww
(with-eval-after-load 'eww
  (custom-set-variables
   '(eww-search-prefix "https://www.baidu.com/s?wd="))

  (define-key eww-mode-map (kbd "h") 'backward-char)
  (define-key eww-mode-map (kbd "n") 'next-line)
  (define-key eww-mode-map (kbd "s") 'forward-char)
  (define-key eww-mode-map (kbd "t") 'previous-line)

  (define-key eww-mode-map (kbd "H") 'eww-back-url)
  (define-key eww-mode-map (kbd "S") 'eww-forward-url)

  (define-key eww-mode-map (kbd "b") 'eww-history-browse)
  (define-key eww-mode-map (kbd "c") 'eww-browse-with-external-browser)
  (define-key eww-mode-map (kbd "i") 'eww)
  (define-key eww-mode-map (kbd "m") 'eww-lnum-follow)
  (define-key eww-mode-map (kbd "z") 'eww-lnum-universal)

  (define-key eww-mode-map (kbd "M-n") 'nil)
  (define-key eww-mode-map (kbd "M-p") 'nil)

  (define-key eww-mode-map (kbd "<C-S-iso-lefttab>") 'eww-previous-buffer)
  (define-key eww-mode-map (kbd "<C-tab>")           'eww-next-buffer)
  )
;;gdb
(add-to-list 'load-path "/Users/sunyang/.emacs.d/lisp")
(require 'gdb-mi)
;;exec-path
(setq exec-path (append exec-path '("/usr/local/Cellar/gdb/8.0.1/bin/")))
;;go
(add-to-list 'load-path "/Users/sunyang/.emacs.d/elpa/go-guru-20180628.1010")
(require 'go-guru)
(add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)
(add-to-list 'load-path "/Users/sunyang/.emacs.d/elpa/go-mode-20180327.1530")
(require 'go-mode)
(put 'upcase-region 'disabled nil)
;;ccrypt

(add-to-list 'load-path "/Users/sunyang/./.emacs.d/elpa/ps-ccrypt-1.10/")
(require 'ps-ccrypt)
;;auto load bash_profile
;;(defun load-bash-profile ()  
;;  (interactive)  
;;  (shell-command "source ~/.bash_profile")  ;;  (shell-command "source ~/.bash_profile")
;;)
(start-process "process-name"
	       (get-buffer-create "*rsync-buffer*")
               "/bin/cat"
               "/Users/sunyang/.bash_profile"
)
;;(load-bash-profile)
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(add-hook 'slime-mode-hook
(lambda ()
(unless (slime-connected-p)
(save-excursion (slime)))))
