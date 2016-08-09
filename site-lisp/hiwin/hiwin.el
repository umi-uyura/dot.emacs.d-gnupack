;;; -*- Mode: Emacs-Lisp  ;  Coding: utf-8 -*-

;;; hiwin.el --- Visible active window mode.
;;
;; Copyright (C) 2009 k.sugita
;;               2010 tomoya <tomoya.ton@gmail.com>
;;               2011 k.sugita <ksugita0510@gmail.com>
;;
;; Author: k.sugita
;; Keywords: faces, editing, emulating
;; Version: 2.01
;;
;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Usage
;;
;; put followings your .emacs
;;   (require 'hiwin)
;;   (hiwin-activate)
;;   (set-face-background 'hiwin-face "gray80")
;;
;; if you invisible active window, type M-x hiwin-deactivate.

;;; Changes
;;
;; 2011-12-30 k.sugita
;; M-x hiwin-modeでモード切替できるように修正
;;
;; 2011-12-23 k.sugita
;; tails-marks.elを参考に以下の実装を見直し，修正
;; ・ウィンドウ分割したとき，あるいはウィンドウ移動したとき
;;   オーバーレイを再作成するように修正
;; ・読み込み専用バッファの背景色を変更する処理を削除
;; ・非アクティブウィンドウの配色をフェイスで設定
;; ・描画対象外バッファの設定は未実装
;;
;; 2010-08-13 k.sugita
;; *Completions*表示時にMiniBufの表示が崩れるのを修正
;; 手動で画面リフレッシュできるようhiwin-refresh-winをinteractive化
;; 個人的な設定だったため，recenterのadviceを削除
;;
;; 2010-07-04 k.sugita
;; ローカルで再スクラッチしたファイルに tomoya氏，masutaka氏の修正を反映
;; readonlyなアクティブwindowの背景色を設定できるように機能変更
;;
;; 2010-06-07 tomoya
;; マイナーモード化
;;
;; 2009-09-13 k.sugita
;; ブログで公開
;; http://ksugita.blog62.fc2.com/blog-entry-8.html

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar hiwin-mode nil)
(make-local-variable 'hiwin-mode)
(define-minor-mode hiwin-mode
  "Visible active window."
  :global t
  :lighter " hiwin"
  :group 'hiwin
  (if hiwin-mode
      (hiwin-deactivate)
    (hiwin-activate)
    ))
(defun hiwin-mode (&optional arg)
  (interactive "P")
  (setq hiwin-mode
        (if (null arg)
            (not hiwin-mode)
          (> (prefix-numeric-value arg) 0)
          ))
  (if hiwin-mode
      (hiwin-activate)
    (hiwin-deactivate)
    ))

;; hiwin-modeの実行状態．non-nilの場合，hiwin-modeは有効．
(defvar hiwin-visible-status nil)

;; 非アクティブウィンドウのオーバーレイ数．現在のウィンドウ数に等しい．
(defvar hiwin-overlay-count nil)

;; 再描画時のアクティブウィンドウ．
(defvar hiwin-active-window nil)

;; 非アクティブウィンドウに描画するオーバーレイの行数．
(defvar hiwin-overlay-lines 126)

;; 非アクティブウィンドウのオーバーレイ．
(defvar hiwin-overlays nil)

(defvar hiwin-focus-out-mode nil)
(defvar hiwin-focus-out-overlay nil)
(defvar hiwin-default-foreground-color nil)
(defvar hiwin-default-background-color nil)

;; 非アクティブウィンドウのオーバーレイ描画用のフェイス．
(defvar hiwin-face nil)
(make-face 'hiwin-face)
(set-face-attribute 'hiwin-face nil :background "gray60")

(defvar hiwin-focus-out-face nil)
(make-face 'hiwin-focus-out-face)
(set-face-attribute 'hiwin-focus-out-face nil :foreground "#B3B3B3" :background "gray60")

(defun hiwin-create-ol ()
  (let (
        (hw-buf nil) ;; 作業用バッファ
        (hw-cnt 0)   ;; ループカウンタ
        )
    ;; オーバーレイ作成済みの場合はスキップ
    (unless hiwin-overlays
      (progn
        ;; 現在のウィンドウ数から作成するオーバーレイ数を決定
        (setq hiwin-overlay-count (count-windows))
        ;; 作業用バッファを作成
        (setq hw-buf (get-buffer-create " *hiwin-temp*"))
        ;; 指定個数のオーバーレイを作成
        (while (< hw-cnt hiwin-overlay-count)
          ;; オーバーレイを作成
          (setq hiwin-overlays (cons (make-overlay 1 1 hw-buf nil t) hiwin-overlays))
          ;; 作成したオーバレイにフェイスを設定
          (overlay-put (nth 0 hiwin-overlays) 'face 'hiwin-face)
          ;; 作成したオーバレイの EOFのフェイスを設定
          (overlay-put (nth 0 hiwin-overlays) 'after-string
                       (propertize (make-string hiwin-overlay-lines ?\n)
                                   'face 'hiwin-face) )
          ;; カウンタアップ
          (setq hw-cnt (1+ hw-cnt))
          )
        ;; 作業用バッファを削除
        (kill-buffer hw-buf)
        ))
      ))

(defun hiwin-delete-ol ()
  (let (
        (hw-cnt 0) ;; ループカウンタ
        )
    ;; オーバーレイ未作成の場合はスキップ
    (if hiwin-overlays
        (progn
          ;; 指定個数のオーバーレイを削除
          (while (< hw-cnt hiwin-overlay-count)
            ;; オーバーレイを削除
            (delete-overlay (nth hw-cnt hiwin-overlays))
            ;; カウンタアップ
            (setq hw-cnt (1+ hw-cnt))
            )
          ;; 念のため初期化
          (setq hiwin-overlays nil)
          ))
    ))

(defun hiwin-draw-ol ()
  (interactive)
  ;; すべてのオーバーレイを削除
  (hiwin-delete-ol)
  ;; その後，新たにオーバーレイを作成
  (hiwin-create-ol)
  ;; 描画時にアクティブなウィンドウを記憶
  (setq hiwin-active-window (selected-window))
  (let (
        (hw-act-buf (current-buffer))  ;; アクティブ バッファ
        (hw-tgt-win nil)               ;; 処理対象ウィンドウ
        (hw-win-lst (window-list))     ;; ウィンドウリスト
        (hw-cnt 0)                     ;; ループカウンタ
        )
    (while hw-win-lst
      ;; 処理対象ウィンドウを取得
      (setq hw-tgt-win (car hw-win-lst))
      ;; 取得したウィンドウをウィンドウリストから削除
      (setq hw-win-lst (cdr hw-win-lst))
      ;; ミニバッファとアクティブ ウィンドウ以外を処理
      (unless (or (eq hw-tgt-win (minibuffer-window))
                  (eq hw-tgt-win hiwin-active-window))
          (progn
            ;; 処理対象ウィンドウを選択
            (select-window hw-tgt-win)
            ;; バッファ末尾の場合，ポイントを一文字戻す
            (if (and (eq (point) (point-max))
                     (> (point-max) 1))
                (backward-char 1))
            ;; 処理対象ウィンドウにオーバーレイを設定
            (move-overlay (nth hw-cnt hiwin-overlays)
                          (point-min) (point-max) (current-buffer))
            (overlay-put (nth hw-cnt hiwin-overlays) 'window hw-tgt-win)
            ;; カウンタアップ
            (setq hw-cnt (1+ hw-cnt))
            )
          ))
    ;; 元のアクティブウィンドウを選択
    (select-window hiwin-active-window)
    ))

(defun hiwin-activate ()
  (interactive)
  (add-hook 'post-command-hook 'hiwin-command-hook)
  )

(defun hiwin-deactivate ()
  (interactive)
  (remove-hook 'post-command-hook 'hiwin-command-hook)
  (hiwin-delete-ol)
  )

(defun hiwin-focus-out-action ()
  (setq hiwin-default-foreground-color (face-attribute 'default :foreground))
  (setq hiwin-default-background-color (face-attribute 'default :background))
  (set-face-attribute 'default nil
                      :foreground (face-attribute 'hiwin-focus-out-face :foreground)
                      :background (face-attribute 'hiwin-focus-out-face :background))
  (if (null hiwin-focus-out-overlay)
      (setq hiwin-focus-out-overlay (make-overlay 1 1 (current-buffer) nil t))
    )
  (overlay-put hiwin-focus-out-overlay 'priority 1000)
  (overlay-put hiwin-focus-out-overlay 'window (selected-window))
  (overlay-put hiwin-focus-out-overlay 'face 'hiwin-face)
  (overlay-put hiwin-focus-out-overlay 'after-string
               (propertize (make-string (window-total-size) ?\n) 'face 'hiwin-face))
  (move-overlay hiwin-focus-out-overlay (point-min) (point-max) (current-buffer))
  )

(defun hiwin-focus-in-action ()
  (unless (null hiwin-default-foreground-color)
    (set-face-attribute 'default nil :foreground hiwin-default-foreground-color
                        :background hiwin-default-background-color)
    )
  (unless (null hiwin-focus-out-overlay)
    (delete-overlay hiwin-focus-out-overlay)
    )
  )

(defun hiwin-focus-out-enable()
  (interactive)
  (if (null hiwin-focus-out-mode)
      (progn
        (setq hiwin-focus-out-mode t)
        (add-hook 'focus-out-hook 'hiwin-focus-out-action)
        (add-hook 'focus-in-hook  'hiwin-focus-in-action)
        )
    )
  )

(defun hiwin-focus-out-disable()
  (interactive)
  (if hiwin-focus-out-mode
      (progn
        (setq hiwin-focus-out-mode nil)
        (remove-hook 'focus-out-hook 'hiwin-focus-out-action)
        (remove-hook 'focus-in-hook  'hiwin-focus-in-action)
        )
      )
  )

(defun hiwin-command-hook ()
  ;; 前回の処理からウィンドウ数か，アクティブ ウィンドウが
  ;; 変更されている場合にオーバーレイを再描画
  (unless (and (eq hiwin-overlay-count (count-windows))
               (eq hiwin-active-window (selected-window)))
    (if executing-kbd-macro
        (input-pending-p)
      (condition-case hiwin-error
          (hiwin-draw-ol)
        (error
         (if (not (window-minibuffer-p (selected-window)))
             (message "[%s] hiwin-mode catched error: %s"
                      (format-time-string "%H:%M:%S" (current-time))
                      hiwin-error) )
         )))))
(provide 'hiwin)

