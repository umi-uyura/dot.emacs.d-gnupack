;;; open-vscodeer.el --- Open the directory with Visual Studio Code
;;; Commentary:

;;; Code:

(defun open-vscode()
  "Open current directory with Visual Studio Code."
  (interactive)
  (process-query-on-exit-flag (start-process-shell-command "open directory with VSCode" nil "code .")))

(provide 'open-vscode)
;;; open-vscode.el ends here
