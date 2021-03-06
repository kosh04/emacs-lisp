;;; memo/keymaps.el     -*- coding: utf-8 -*-

;; 文字(キーバインド)の表現方法色々。基本はベクタ
;; `kbd' を利用するのが一番見やすくて良い
?h                                      ; 104
[?h]                                    ; [104] (ベクタ)
?\C-h                                   ; 8
"\C-h"                                  ; ""
[(f9)]                                  ; F9
(coerce "\C-h" 'vector)                 ; [8] == (vconcat "\C-h")
(lookup-key global-map [(control ?x) (control ?f)]) ; find-file
(lookup-key global-map [(control x) (control f)])   ; find-file
(lookup-key global-map [f1])                        ; help-command
(lookup-key global-map [(f1)])                      ; help-command
(kbd "<up> <up> <down> <down> <left> <right> <left> <right> B A")
;;=> [up up down down left right left right 66 65]
(kbd "C-m")                             ; ""
(kbd "<C-M-up>")                        ; [C-M-up]
(equal "\M-\C-e" "\C-\M-e")             ; t
(kbd "C-M-d")                           ; [134217732]
(kbd "C-.")                             ; [67108910]

;;; http://www.geocities.co.jp/SiliconValley-Bay/9285/ELISP-JA/elisp_325.html
;; キーを定義したり探索する関数では、ベクトルで表したキー列内のイベン
;; ト型に対して別の構文、つまり、修飾子名と1つの基本イベント（文字や
;; ファンクションキー名）から成るリストを受け付けます。たとえば、
;; (control ?a)は?\C-aに等価であり、 (hyper control left)はC-H-leftに
;; 等価です。このようなリストの利点の1つは、コンパイル済みのファイル
;; に修飾ビットの数値が現れないことです。

#b01111111111111111111111111111         ; most-positive-fixnum
#b10000000000000000000000000000         ; most-negative-fixnum

#b01000000000000000000000100101         ; ?\M-% [meta]
#b00100000000000000000000100101         ; ?\C-% [control]
#b00010000000000000000000100101         ; ?\S-% [shift]
#b00001000000000000000000100101         ; ?\H-% [hyper]
#b00000100000000000000000100101         ; ?\s-% [super]
#b00000010000000000000000100101         ; ?\A-% [alt]
#b00000000000000000000000100101         ; ?%

(list ?\C-@ ?\^@ ? )                   ; (0 0 0)

(event-modifiers ?\S-\C-@)              ; (shift control)

;; src/lisp.h
(defconst char-alt       #x0400000)
(defconst char-super-bit #x0800000)
(defconst char-hyper-bit #x1000000)
(defconst char-shift     #x2000000)
(defconst char-control-bit #x4000000)
(defconst char-meta-bit  #x8000000)

(logior char-control-bit ?%)             ; ?\C-%

;; うちの環境だと左winキーが[super] (@ubuntu)

;; フロー制御
(enable-flow-control)
(enable-flow-control-on "vt200" "vt300" "vt101" "vt131")

(mapcar #'event-convert-list
        [(control ?a)
         (control meta ?a)
         (control super ?a)
         (meta up)
         (control f1)]
        )                               ; (1 134217729 8388609 M-up C-f1)

(every #'char-valid-p (number-sequence 0 255)) ; t

;;; Ctrl-H を前1文字削除に変更
(keyboard-translate ?\^h ?\177)
(keyboard-translate ?\^h 'backspace)
(keyboard-translate ?\C-h ?\C-?)
(load-library "keyswap")

;;; C-h と BS が同じ挙動になる
(global-set-key [backspace] 'backward-delete-char)
(keyboard-translate ?\C-h 'backspace)
(global-set-key [delete] 'delete-char)

;; C-j とを RET を入れ替える
(keyboard-translate ?\C-j ?\C-m)
(keyboard-translate ?\C-m ?\C-j)

;; キーの入れ替えのヘルプ
(info "(efaq)Swapping keys")

backward-delete-char-untabify-method    ; untabify/hungry/all/nil
(define-key global-map "" 'backward-delete-char-untabify) ; == "\C-h"

;; isearch
(define-key isearch-mode-map "\C-k" 'isearch-edit-string)

;; キーの変換
(key-description "\C-x \M-y \n \t \r \f123")
;;=> "C-x SPC M-y SPC C-j SPC TAB SPC RET SPC C-l 1 2 3"
(kbd (key-description "\C-x \M-y \n \t \r \f123"))
;;=> [24 32 134217849 32 10 32 9 32 13 32 12 49 50 51]

(mapcar (lambda (x)
          (list (text-char-description x) (string x)))
        '(?\C-c ?\M-m ?\C-\M-m))
;;=> (("^C" "") ("\xed" "\355") ("\x8d" "\x8d"))

(list ?\xff ?\377 #xff #o377)           ; (255 255 255 255)

;; キーマップの lookup 順序について
;; https://emacs.g.hatena.ne.jp/kiwanami/20110606/1307385847
