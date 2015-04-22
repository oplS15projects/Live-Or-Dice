#lang racket

(require racket/gui)

;roll function
(define b 0)
(define (dice) (+ 1 (random 6)))
(define sum  (lambda ()  (set! b (+ b (dice)))))

(define (conf n) (if (= (dice) 1)
                 (set! b 0)
                 b)b)


(define (roll) (sum) (conf b))
;Frame Main Window
; Make a frame by instantiating the frame% class
(define frame (new frame%
                   [label "Example"]
                   [width 300]
                   [height 300]))
 
; Make a static text message in the frame
(define msg (new message% [parent frame]
                          [label "No events so far..."]))
 
; Make a button in the frame
;(new button% [parent frame]
;             [label "Click Me"]
             ; Callback procedure for a button click:
;             [callback (lambda (button event)
;                         (send msg set-label "Button click"))])
 
; Show the frame by calling its show method
(send frame show #t)

;Canvas for Main Window
(new canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (send dc set-scale 3 3)
                (send dc set-text-foreground "blue")
                (send dc draw-text "ROLL IT!" 0 0))])

(send frame show #t)

(define panel (new horizontal-panel% [parent frame]
                   [alignment '(center center)]))
(new button% [parent panel]
             [label "Roll"]
             [callback (lambda (button event)
                         (send msg set-label (number->string (roll))))])
