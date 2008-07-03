;; .emacs $Id$
;; このファイルは設定情報のsandbox的に利用する

;; environment
(set-language-environment 'japanese)
;(set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8-unix)

;; user information
; changelog
(setq user-full-name "KIMOTO Takumi")
(setq user-mail-address "peerler@gmail.com")

;; utility
; ディレクトリ内で正規表現にマッチするファイルをloadします
(defun load-regexp-match-files-in-directory (directory-path regexp)
  (mapcar
   #'(lambda (file-path)
       (if (string-match regexp file-path)
	   (load-file (concat directory-path file-path))))
   (directory-files directory-path)))
   
;; load
; load ~/.emacs.d/conf/init.*el
(setq load-path (cons "~/.emacs.d/elisp/" load-path))
(load-regexp-match-files-in-directory "~/.emacs.d/conf/" "init.*el$")
