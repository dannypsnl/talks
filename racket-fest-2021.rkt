#lang slideshow

(require slideshow/code)

(slide
  #:title "Macro as Type"
  (t "Hi"))

(slide
  #:title "Macro as Type?"
  (code (define- x : Number 1)))

(slide
  #:title "Became"
  (code (begin
          (define-for-syntax x Number)
          (define x 1))))

(slide
  #:title "How?"
  (code
    (define-syntax-parser define-
      [(_ name:id ty exp)
       (unless (equal? ty (typeof exp))
         (raise-syntax-error
           'unexpected
           (format "expect ~a, but got ~a"
                   ty
                   (typeof exp)))
           this-syntax
           #'exp)
       #'(begin
           (define-for-syntax name ty)
           (define name exp))])))

; TODO
; 1. typeof
; 2. function form
; 3. claim form
; 4. extend?