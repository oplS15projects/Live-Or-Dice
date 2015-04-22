#lang racket
(require racket/gui/base)

;This is the starting frame
(define mainframe (new frame% [label "Live or Dice"]
                              [alignment '(center bottom)]
                              [width 300] 
                              [height 300]
                              ))
(new canvas% [parent mainframe]
             [paint-callback
              (lambda (canvas dc)
                (send dc set-scale 3 3)
                (send dc set-text-foreground "blue")
                (send dc draw-text "Live or Dice!" 0 0))])

;Top panel which contains two subpanel
;These subpanels are bordered for clarity
;They also contain messages which are not expected to change
(define tpanel (new horizontal-panel% [parent mainframe]
                    [alignment '(center center)]
                    [spacing 146]
                    [style '(border)]
                    ))

(define tsubpanel1 (new horizontal-panel% [parent tpanel]
                    [alignment '(center center)]
                    [style '(border)]
                    ))

(define tsubpanel2 (new horizontal-panel% [parent tpanel]
                    [alignment '(center center)]
                    [style '(border)]
                    ))

;Middle panel contains three subpanels
;All three messages are expected to change according to different states
;left and right message will display the player scores
;the middle message will use states to display the condition of the game
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

                         
;Bottom panel which contains two buttons
(define bpanel (new horizontal-panel% [parent mainframe]
                       [alignment '(center center)]
                      [spacing 15]
                      ))

;Mess1 is not expected to recieve data
(define mess1 (new message% [parent tsubpanel1]
                   [label "Player 1"]
                   ))

;Mess2 is not expected to recieve data
(define mess2 (new message% [parent tsubpanel2]
                   [label "Player 2"]
                   ))

;Mess3 keeps track of player 1 score
(define mess3 (new message% [parent msubpanel1]
                   [label "HP:"]
                   ))

;Mess4 keeps track of the current of the game
(define mess4 (new message% [parent msubpanel2]
                   [label "The game begins"]
                   ))

;Mess5 keeps track of player 2 score
(define mess5 (new message% [parent msubpanel3]
                   [label "HP:"]
                   ))

;Roll simply allows you to roll the dice as many times as you wish
;at least until you press "pass"
(new button% [parent bpanel] [label "Roll"])

;Pass will change the state and go over to the other player
(new button% [parent bpanel] [label "Pass"])

;Exit Button
(new button% [parent bpanel]
             [label "Exit"]
             [callback (lambda (button event) (exit))])

;GAUGE FOR PLAYER 1
(define gauge1 (new gauge%
                   (label "")
                   (parent msubpanel1)
                   (range 100)))
(send gauge1 set-value 42)

;GAUGE FOR PLAYER 2
(define gauge2 (new gauge%
                   (label "")
                   (parent msubpanel3)
                   (range 100)))
(send gauge2 set-value 42)


(send mainframe show #t)
