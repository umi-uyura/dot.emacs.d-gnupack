;;; gnupack-dark-theme.el --- gnupack dark theme for Emacs

;; Copyright (C) 2013 k.sugita All rights reserved.
;; Time-stamp: 2013-08-24 11:04:48.

;; Author: Katsuhiko Sugita <ksugita@users.sourceforge.jp>
;; Keywords: emacs, face

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(deftheme gnupack-dark "gnupack dark color theme")

(dolist (face '(cursor-ime-on cursor-ime-off))
  (unless (facep face) (make-face face)) )
(let (
      (red-pale      "#FFF2F2") (red-light     "#CC6666") (red-basic     "#A65353") (red-dark      "#663333") (red-deep      "#332B2B")
      (orange-pale   "#FFF7F2") (orange-light  "#CC9166") (orange-basic  "#A67653") (orange-dark   "#664833") (orange-deep   "#332E2B")
      (yellow-pale   "#FDFFF2") (yellow-light  "#BBCC66") (yellow-basic  "#98A653") (yellow-dark   "#5D6633") (yellow-deep   "#32332B")
      (green-pale    "#F2FFF2") (green-light   "#66CC66") (green-basic   "#53A653") (green-dark    "#336633") (green-deep    "#2B332B")
      (cyan-pale     "#F2FBFF") (cyan-light    "#66AACC") (cyan-basic    "#538AA6") (cyan-dark     "#335566") (cyan-deep     "#2B3033")
      (blue-pale     "#F2F2FF") (blue-light    "#6666CC") (blue-basic    "#5353A6") (blue-dark     "#333366") (blue-deep     "#2B2B33")
      (violet-pale   "#F7F2FF") (violet-light  "#9166CC") (violet-basic  "#7653A6") (violet-dark   "#483366") (violet-deep   "#2E2B33")
      (magenta-pale  "#FFF2FF") (magenta-light "#CC66CC") (magenta-basic "#A653A6") (magenta-dark  "#663366") (magenta-deep  "#332B33")
      (gray-05       "#0D0D0D") (gray-10       "#1A1A1A") (gray-15       "#262626") (gray-20       "#333333") (gray-25       "#404040")
      (gray-30       "#4D4D4D") (gray-35       "#595959") (gray-40       "#666666") (gray-45       "#737373") (gray-50       "#808080")
      (gray-55       "#8C8C8C") (gray-60       "#999999") (gray-65       "#A6A6A6") (gray-70       "#B3B3B3") (gray-75       "#BFBFBF")
      (gray-80       "#CCCCCC") (gray-85       "#D9D9D9") (gray-90       "#E6E6E6") (gray-95       "#F2F2F2") 
      )

  (custom-theme-set-faces
   'gnupack-dark

   `(default     ((t (:foreground ,gray-80 :background ,gray-15)))) 
   `(bold        ((t (:bold t   :italic nil :underline nil ))))
   `(bold-italic ((t (:bold t   :italic t   :underline nil ))))
   `(italic      ((t (:bold nil :italic t   :underline nil ))))
   `(underline   ((t (:bold nil :italic nil :underline t   ))))

   `(font-lock-type-face                  ((t (:foreground ,red-basic    :bold t           ))))
   `(font-lock-variable-name-face         ((t (:foreground ,orange-light                   ))))
   `(font-lock-comment-delimiter-face     ((t (:foreground ,yellow-basic         :italic t ))))
   `(font-lock-comment-face               ((t (:foreground ,yellow-light         :italic t ))))
   `(font-lock-string-face                ((t (:foreground ,green-basic                    ))))
   `(font-lock-keyword-face               ((t (:foreground ,cyan-basic                     ))))
   `(font-lock-constant-face              ((t (:foreground ,blue-light                     ))))
   `(font-lock-function-name-face         ((t (:foreground ,violet-basic :bold t           ))))
   `(font-lock-builtin-face               ((t (:foreground ,gray-50                        ))))
   `(font-lock-preprocessor-face          ((t (:foreground ,gray-50                        ))))
   
   `(cursor         ((t (:foreground ,gray-90 :background ,red-dark   :bold nil))))
   `(cursor-ime-off ((t (:foreground ,gray-90 :background ,red-dark   :bold nil))))
   `(cursor-ime-on  ((t (:foreground ,gray-90 :background ,green-dark :bold nil))))

   `(mode-line           ((t (:foreground ,gray-85 :background ,gray-45          ))))
   `(mode-line-inactive  ((t (:foreground ,gray-65 :background ,gray-45          ))))
   `(mode-line-buffer-id ((t (                     :background ,gray-45  :bold t ))))
   `(mode-line-emphasis  ((t (                     :background ,red-dark         ))))
   `(mode-line-highlight ((t (                                                   ))))

   `(isearch      ((t (:foreground ,red-dark :background ,red-light ))))
   `(isearch-fail ((t (:foreground ,gray-80  :background ,red-dark  ))))

   `(success    ((t (:foreground ,green-dark   :weight normal ))))
   `(warning    ((t (:foreground ,yellow-dark  :weight normal ))))
   `(error      ((t (:foreground ,magenta-dark :weight normal ))))

   `(region            ((t (:foreground ,cyan-light :background ,blue-basic))))
   `(highlight         ((t (                        :background ,gray-30))))
   `(shadow            ((t (:foreground ,gray-35))))
   `(fringe            ((t (:foreground ,gray-45 :background ,gray-30))))
   `(minibuffer-prompt ((t (:foreground ,cyan-light))))
   `(tooltip           ((t (:foreground ,gray-80 :background ,gray-15)))) 
   `(link              ((t (:foreground ,cyan-light))))
   `(link-visited      ((t (:foreground ,magenta-light))))
   `(escape-glyph      ((t (:foreground ,cyan-light))))
   `(vertical-border   ((t (:foreground ,gray-30))))

   `(compilation-column-number      ((t (:foreground ,green-basic                          ))))
   `(compilation-error              ((t (:foreground ,violet-dark                          ))))
   `(compilation-info               ((t (:foreground ,green-basic                          ))))
   `(compilation-line-number        ((t (:foreground ,cyan-basic                           ))))
   `(compilation-mode-line-exit     ((t (:foreground ,green-basic :bold nil                ))))
   `(compilation-mode-line-fail     ((t (:foreground ,red-basic   :bold nil                ))))
   `(compilation-mode-line-run      ((t (:foreground ,yellow-dark                          ))))
   `(compilation-warning            ((t (:foreground ,yellow-dark                          ))))
   `(completions-annotations        ((t (                                   :underline nil ))))
   `(completions-common-part        ((t (:foreground ,gray-40               :underline nil )))) 
   `(completions-first-difference   ((t (:foreground ,red-light             :underline nil )))) 

   `(hl-line ((t (:foreground nil :background ,yellow-deep))))

   `(show-paren-match    ((t (:background ,cyan-basic :weight bold))))
   `(show-paren-mismatch ((t (:background ,magenta-dark :weight bold))))

   `(comint-highlight-prompt ((t (:foreground ,red-basic))))
   `(comint-highlight-input  ((t (:foreground ,gray-50 :bold nil))))

   `(sh-heredoc              ((t (:foreground ,gray-50 :bold nil))))

   `(diff-added       ((t (:foreground ,green-basic))))
   `(diff-removed     ((t (:foreground ,red-basic))))
   `(diff-context     ((t (:foreground ,gray-50))))
   `(diff-header      ((t (:foreground ,orange-basic))))
   `(diff-file-header ((t (:foreground ,orange-basic :underline t :bold nil))))

   `(mcomplete-prefix-method-alternative-part-face ((t (:foreground ,blue-light  ))))
   `(mcomplete-prefix-method-fixed-part-face       ((t (:foreground ,blue-light  ))))
   `(mcomplete-substr-method-alternative-part-face ((t (:foreground ,green-light ))))
   `(mcomplete-substr-method-fixed-part-face       ((t (:foreground ,green-light ))))

   `(hiwin-face ((t (:background ,gray-25))))
   `(hiwin-focus-out-face ((t (:foreground ,gray-65 :background ,gray-25))))

   `(rowin-face ((t (:background ,green-deep))))

   `(tabbar-default          ((t (                      :background ,gray-35 :box nil ))))
   `(tabbar-selected         ((t (:foreground ,gray-85  :background ,gray-35 :box nil ))))
   `(tabbar-unselected       ((t (:foreground ,gray-65  :background ,gray-35 :box nil ))))
   `(tabbar-separator        ((t (                      :background ,gray-35 :box nil ))))
   `(tabbar-button           ((t (                      :background ,gray-35 :box nil ))))
   `(tabbar-button-highlight ((t (                      :background ,gray-35 :box nil ))))
   `(tabbar-highlight        ((t (:foreground ,gray-95  :background ,gray-35 :box nil ))))

   `(vbnet-funcall-face ((t (:foreground ,gray-50))))

   `(whitespace-space   ((t (:foreground nil :background nil :inherit shadow))))
   `(whitespace-tab     ((t (:foreground nil :background nil :inherit shadow :strike-through t))))
   `(whitespace-newline ((t (:foreground nil :background nil :inherit shadow))))

   `(which-func ((t (:foreground nil))))

   `(linum-highlight-face  ((t (:inherit linum :foreground ,gray-80 :background ,red-dark))))

   `(ace-jump-face-foreground ((t (:foreground ,gray-95      :background ,red-basic :underline t))))
   `(ace-jump-face-background ((t (:foreground nil           :background ,red-deep))))

   `(cperl-array-face          ((t (:foreground ,orange-basic :background nil :underline t :bold nil))))
   `(cperl-hash-face           ((t (:foreground ,orange-basic :background nil :underline t :bold nil))))
   `(cperl-nonoverridable-face ((t (:foreground ,violet-light))))

   `(flymake-errline  ((t (:inherit nil :underline (:color ,red-basic :style wave) :bold t))))
   `(flymake-warnline ((t (:inherit nil :underline (:color ,red-basic :style line) :bold t))))

   `(yas/field-debug-face    ((t (:foreground nil :background ,green-dark))))
   `(yas/field-highlight-fac ((t (:foreground nil :background ,red-dark))))

   `(ac-candidate-face           ((t (:foreground ,gray-10 :background ,gray-40 :underline (:color ,gray-30 :style line)))))
   `(ac-selection-face           ((t (:foreground ,gray-70 :background ,gray-40 :underline (:color ,gray-30 :style line)))))

   `(popup-isearch-match              ((t (:foreground ,red-dark :background ,red-light))))
   `(popup-scroll-bar-background-face ((t (:background ,gray-20))))
   `(popup-scroll-bar-foreground-face ((t (:background ,gray-50))))
   `(popup-tip-face                   ((t (:foreground ,gray-15 :background ,gray-80))))

   `(cperl-nonoverridable-face ((t (:foreground ,blue-light))))
   `(cperl-array-face          ((t (:foreground ,orange-light :background nil :underline t :weight normal))))
   `(cperl-hash-face           ((t (:foreground ,orange-light :background nil :underline t :weight normal))))

   `(hicol-line-face       ((t (:foreground nil :background ,red-dark))))
   `(hicol-line-frame-face ((t (:foreground nil :background ,gray-15))))
   )
  )
(provide-theme 'gnupack-dark)

;; --------------------------------------------------------------------
;; Local Variables:
;; coding: utf-8
;; mode: emacs-lisp
;; End:

;;; ends here
