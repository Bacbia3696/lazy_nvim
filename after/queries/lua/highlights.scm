;󰄠; extends
;; Keywords
(("function" @keyword) (#set! conceal ""))  ;;  "ﬦ"))
(("for"      @keyword) (#set! conceal ""))
(("end"      @keyword) (#set! conceal "⏹"))
(("return"   @keyword) (#set! conceal "⎋"))

;; Function names
; ((function_call name: (identifier) @TSFuncMacro (#eq? @TSFuncMacro "require")) (#set! conceal ""))
((function_call name: (identifier) @TSFuncMacro (#eq? @TSFuncMacro "require")) (#set! conceal "󰄠"))

;; vim.*
(((identifier) @field (#eq? @field "vim"      )) (#set! conceal ""))
