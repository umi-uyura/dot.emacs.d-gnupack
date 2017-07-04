;;; ssh-agent-env.el --- Load ssh-agent information from environment variable

;;; Code:

(let ((filePath "~/.ssh-agent-env"))
  (with-temp-buffer
    (insert-file-contents filePath)
    (let (ssh-auth-sock ssh-agent-pid)
      (and (progn
      (goto-char (point-min))
      (re-search-forward "SSH_AUTH_SOCK=\\([^;]*\\)" nil t))
    (setq ssh-auth-sock (match-string 1))
    (progn
      (goto-char (point-min))
      (re-search-forward "SSH_AGENT_PID=\\([^;]*\\)" nil t))
    (setq ssh-agent-pid (match-string 1))
    (setenv "SSH_AUTH_SOCK" ssh-auth-sock)
    (setenv "SSH_AGENT_PID" ssh-agent-pid)))))

;;; ssh-agent-env.el ends here
