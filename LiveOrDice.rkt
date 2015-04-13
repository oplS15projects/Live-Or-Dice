#lang racket
(require racket/gui/base)


(define mainframe (new frame% [label "Live or Dice"]
                              [alignment '(center bottom)]
                              [width 300]
                              [height 300]
                              ))

(define tpanel (new horizontal-panel% [parent mainframe]
                    [alignment '(center center)]
                    [spacing 144]
                   ;; [style '(border)]
                    ))
(define tsubpanel1 (new horizontal-panel% [parent tpanel]
                    [alignment '(center center)]
                    [style '(border)]
                    ))
(define tsubpanel2 (new horizontal-panel% [parent tpanel]
                    [alignment '(center center)]
                    [style '(border)]
                    ))


(define mpanel (new horizontal-panel% [parent mainframe]
                    [alignment '(center center)]
                    ))

(define msubpanel1 (new horizontal-panel% [parent mpanel]
                    [alignment '(center center)]
                    [style '(border)]
                    ))

(define msubpanel2 (new horizontal-panel% [parent mpanel]
                    [alignment '(center center)]
                    [style '(border)]
                    ))
(define msubpanel3 (new horizontal-panel% [parent mpanel]
                    [alignment '(center center)]
                    [style '(border)]
                    ))

                         
                    
(define bpanel (new horizontal-panel% [parent mainframe]
                       [alignment '(center center)]
                     ;; [style '(border)]
                      [spacing 15]
                      ))

(define mess1 (new message% [parent tsubpanel1]
                   [label "Player 1"]
                   ))

(define mess2 (new message% [parent tsubpanel2]
                   [label "Player 2"]
                   ))

(define mess3 (new message% [parent msubpanel1]
                   [label "3"]
                   ))

(define mess4 (new message% [parent msubpanel2]
                   [label "player one wins"]
                   ))

(define mess5 (new message% [parent msubpanel3]
                   [label "1"]
                   ))

(new button% [parent bpanel] [label "Roll"])
(new button% [parent bpanel] [label "Pass"])















(send mainframe show #t)