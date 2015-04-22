#lang racket
(require racket/gui/base)


(define mainframe (new frame% [label "Live or Dice"]
                              [alignment '(center bottom)]
                              ))

(define mess3 (new message% [parent mainframe]
                   [label "0          "]
                   ))                

(define bpanel (new horizontal-panel% [parent mainframe]
                       [alignment '(center center)]
                      [spacing 15]
                      ))

(define b 0)
(define (dice) (+ 1 (random 6)))
(define sum  (lambda ()  (set! b (+ b (dice)))))

(define (conf n) (if (= (dice) 1)
                 (set! b 0)
                 b)b)


(define (roll) (sum) (conf b))


(new button% [parent bpanel]
     [label "Roll"]
  [callback (lambda (button event) (send mess3 set-label (number->string  (roll))))]
      )


(new button% [parent bpanel] [label "Pass"]

)



(send mainframe show #t)
