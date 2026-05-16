;;; snacktheme-theme.el --- A warm, cozy retro TTY theme with organic greens and ambers.

;; Title: Snacktheme
;; Version: 1.3.0
;; Author: Generative AI Collab
;; Description: Calm, warm, plenty of green/amber transitions, matching line numbers and cursor.

(deftheme snacktheme
  "Cozy TTY-inspired dark theme with organic greens, ambers, and warm transitions.")

;; ------------------------------------------------------------
;; Palette (Variables for easy tweaking)
;; ------------------------------------------------------------
(let ((bg      "#121014") ; Глубокий мягкий черный
      (fg      "#D6D6E1") ; Светло-кремовый
      (grey    "#4A4A59") ; Цвет комментариев, нумерации И курсора
      
      ;; Тёплая палитра для синтаксиса
      (purple  "#B185DB") ; Фиолетовый (для ключевых слов / built-in)
      (orange  "#E07A5F") ; Терракотовый/мягкий оранжевый (для типов данных)
	  (amber   "#DE9E52") ; Приглушенный охристо-песочный (для функций)
	  (yellow  "#DDBB77") ; Мягкий соломенно-кремовый (для констант)
      
      ;; Зелёные переходные тона (Earth tones)
      (warm-green "#81B29A") ; Мягкий фисташковый/шалфейный (для переменных)
      (sage-green "#95D5B2") ; Спокойный травяной (для строк)
      
      (cyan    "#2A9D8F") ; Бирюзовый (только для UI и ссылок)
      (cursor  "#4A4A59")) ; Курсор цвета нумерации строк

  ;; ------------------------------------------------------------
  ;; Base faces
  ;; ------------------------------------------------------------
  (custom-theme-set-faces
   'snacktheme

   ;; Core and Font
   `(default ((t (:background ,bg :foreground ,fg :font "JetBrains Mono"))))
   `(cursor  ((t (:background ,cursor)))) 
   `(region  ((t (:background "#2F313D"))))
   `(highlight ((t (:background "#1F212A"))))
   `(error ((t (:foreground "#E63946" :weight bold))))
   `(warning ((t (:foreground ,yellow))))
   `(success ((t (:foreground ,sage-green))))

   ;; Line Numbers (Нумерация строк — серая)
   `(line-number ((t (:foreground ,grey :background ,bg))))
   `(line-number-current-line ((t (:foreground ,fg :background "#1F212A" :weight bold))))

   ;; Font lock (Тёплый синтаксис с зелёными мостиками)
   `(font-lock-builtin-face       ((t (:foreground ,purple))))
   `(font-lock-comment-face       ((t (:foreground ,grey :slant italic))))
   `(font-lock-constant-face      ((t (:foreground ,yellow))))
   `(font-lock-function-name-face ((t (:foreground ,amber :weight bold)))) ; Тёплый янтарный
   `(font-lock-keyword-face       ((t (:foreground ,purple))))
   `(font-lock-string-face        ((t (:foreground ,sage-green))))        ; Тёплый зелёный строк
   `(font-lock-type-face          ((t (:foreground ,orange))))           ; Терракотовые типы
   `(font-lock-variable-name-face ((t (:foreground ,warm-green))))       ; Фисташковые переменные
   `(font-lock-warning-face       ((t (:foreground ,yellow :weight bold))))

   ;; UI
   `(mode-line
     ((t (:background ,grey :foreground ,bg :box nil))))
   `(mode-line-inactive
     ((t (:background ,bg :foreground ,grey :box nil))))
   `(minibuffer-prompt ((t (:foreground ,amber :weight bold))))
   `(link ((t (:foreground ,cyan :underline t))))
   `(link-visited ((t (:foreground ,purple :underline t))))

   ;; Org Mode
   `(org-document-title ((t (:foreground ,amber :weight bold :height 1.2))))
   `(org-level-1 ((t (:foreground ,purple :weight bold))))
   `(org-level-2 ((t (:foreground ,amber))))
   `(org-level-3 ((t (:foreground ,warm-green)))) ; Уровень Org Mode теперь зелёный
   `(org-level-4 ((t (:foreground ,yellow))))

   ;; Tab bar — Linux TTY style
   `(tab-bar
     ((t (:background ,bg :foreground ,fg :inherit default :box nil))))
   `(tab-bar-tab
     ((t (:background ,amber :foreground ,bg :weight bold :box nil))))
   `(tab-bar-tab-inactive
     ((t (:background ,bg :foreground ,grey :box nil))))
   ))

;; ------------------------------------------------------------
;; ANSI Palette for term/vterm
;; ------------------------------------------------------------
(setq ansi-color-names-vector
      ["#0D0D11" ; black
       "#E63946" ; red
       "#81B29A" ; green (warm-green)
       "#F4A261" ; yellow (amber)
       "#B185DB" ; blue (purple)
       "#E07A5F" ; magenta (orange)
       "#2A9D8F" ; cyan
       "#D6D6E1"]) ; white

(setq ansi-color-bright-colors
      ["#4A4A59" ; bright black
       "#E07A5F" ; bright red
       "#95D5B2" ; bright green (sage-green)
       "#E9C46A" ; bright yellow
       "#C77DFF" ; bright blue
       "#FFB703" ; bright magenta
       "#48CAE4" ; bright cyan
       "#FFFFFF"]) ; bright white

(setq ansi-color-context nil)

(setq term-default-bg-color "#0D0D11")
(setq term-default-fg-color "#D6D6E1")

(with-eval-after-load 'ansi-color
  (add-hook 'compilation-filter-hook #'ansi-color-compilation-filter))

(provide-theme 'snacktheme)
