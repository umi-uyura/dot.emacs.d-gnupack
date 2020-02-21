;; win-open-folder.el --- Open the folder in a variety of ways

;;; Explorer でフォルダを開く
(defun open-explorer()
  "cygstart CURRENT-DIRECTORY"
  (interactive)
  (process-query-on-exit-flag (start-process-shell-command "open folder in Explorer" nil "cygstart .")))

;;; Cygwin でフォルダを開く
;;; require cyghere (https://gist.github.com/umi-uyura/9fc4317518c98ce6fb5b03aaed50d141)
(defun open-cygwin()
  "cyghere CURRENT-DIRECTORY"
  (interactive)
  (process-query-on-exit-flag (start-process-shell-command "open folder in Cygwin" nil "cyghere")))

;;; コマンドプロンプト でフォルダを開く
(defun open-cmd()
  "cmd CURRENT-DIRECTORY"
  (interactive)
  (process-query-on-exit-flag (start-process-shell-command "open folder in Command prompt" nil "cmd /C 'start /D .'")))

;;; Windows Terminal でフォルダを開く
(defun open-wt()
  "cmd CURRENT-DIRECTORY"
  (interactive)
  (process-query-on-exit-flag (start-process-shell-command "open folder in Windows Termianl" nil "cmd /C 'wt -d .'")))
