#lang racket
(require racket/gui/base)

(define state "Player 1's Turn")
(define rolltrac 0)
(define trdice 0)
(define player1score 0)
(define player2score 0)

;Chance rolls 0 to 10
;Dice rolls from 1 to 6
(define (chance) (random 10))
(define (dice) (+ 1 (random 6)))

;sumroll uses trdice to capture the dice value 
;it also sets rolltrac to the combined value of the dice roll
;p1store and p2store are used to keep track of player score 
(define sumroll (lambda () (set! trdice (dice)) (set! rolltrac (+ rolltrac trdice ))))
(define p1store (lambda () (set! player1score (+ player1score rolltrac))))
(define p2store (lambda () (set! player2score (+ player2score rolltrac))))



(define mainframe (new frame% [label "Live or Dice"]
                              [alignment '(center bottom)]
                              [width 300] 
                              [height 300]
                              ))

;tpanel contains three bordered panels for clarity which also contain three messages
(define tpanel (new horizontal-panel% [parent mainframe]
                    [alignment '(center center)]
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

(define tsubpanel3 (new horizontal-panel% [parent tpanel]
                    [alignment '(center center)]
                    [style '(border)]
                    ))

;mpanel contains three bordered panels for clarity which also contain three messages
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


      

;bpanel contains three button 
(define bpanel1 (new horizontal-panel% [parent mainframe]
                       [alignment '(center center)]
                      [spacing 10]
                      ))

;mess1 located in tpanel should be static and accepts no input
(define mess1 (new message% [parent tsubpanel1]
                   [label "Player 1 total   "]
                   ))
;mess2 located in tpanel is dynamic and accepts the current state given to it
(define mess2 (new message% [parent tsubpanel2]
                   [label state]
                   ))

;mess3 located in tpanel should be static and accepts no input
(define mess3 (new message% [parent tsubpanel3]
                   [label "Player 2 total   "]
                   ))

;mess4 located in mpanel takes player 1's score which is p1store 
(define mess4 (new message% [parent msubpanel1]
                   [label "0    "]
                   ))

;mess5 located in mpanel takes rolltrac 
;which is total sum of the rolls done with the "roll" button
(define mess5 (new message% [parent msubpanel2]
                   [label "0    "]
                   ))

;mess6 located in mpanel takes player 2's score which is p2store 
(define mess6 (new message% [parent msubpanel3]
                   [label "0    "]
                   ))
;p1 and p2 updates mess2 which is the top middle box to show which state the game is in
(define p1
(let ([new-es (make-eventspace)])
  (parameterize ([current-eventspace new-es])
    (lambda () (send mess2 set-label "Player 1's Turn")))))
(define p2
(let ([new-es (make-eventspace)])
  (parameterize ([current-eventspace new-es])
    (lambda () (send mess2 set-label "Player 2's Turn")))))

;updates mess4 located bottom left with the player 1 score
(define p3
(let ([new-es (make-eventspace)])
  (parameterize ([current-eventspace new-es])
    (lambda () (send mess4 set-label (number->string player1score))))))

;updates mess5 located bottom center with the sum of total dice rolls
(define p4
(let ([new-es (make-eventspace)])
  (parameterize ([current-eventspace new-es])
    (lambda () (send mess5 set-label  "0   ")))))

;updates mess6 located bottom right with the player 2 score
(define p5
(let ([new-es (make-eventspace)])
  (parameterize ([current-eventspace new-es])
    (lambda () (send mess6 set-label (number->string player2score))))))

;p1win and p2win display a message to the player if the winning conditions are met
(define (p1win) (message-box "Results" "Player One Wins     " mainframe '(ok)))
(define (p2win) (message-box "Results" "Player Two Wins     " mainframe '(ok)))

;determines who goes first
(define turn (if (>= (chance) 5)
                 (begin (set! state "Player 1's Turn")(p1))
                 (begin (set! state "Player 2's Turn")(p2))))

;resets everything to the beginning
(define (nullify)(set! player1score 0)
                 (set! player2score 0)
                 (set! rolltrac 0))

;first four conditions check the winning condition
;which requires the player to have 100 or more points
;switch over to the other player while clearing the board
;last two conditions check if the dice rolls a 1 and what playerstate its in
;depending on the playerstate it resets the sum of total dice rolls to 0 
;and passes the turn to the other player
(define (cona n)(cond  ((and (>= player1score 100) (equal? state "Player 2's Turn")) 
                            (p1win)(nullify)(p2)(p3)(p4)(p5))
                       ((and (>= player2score 100) (equal? state "Player 1's Turn")) 
                            (p2win)(nullify)(p1)(p3)(p4)(p5))
                       ((and (>= player1score 100) (equal? state "Player 1's Turn")) 
                            (p1win)(nullify)(p2)(p3)(p4)(p5))
                       ((and (>= player2score 100) (equal? state "Player 2's Turn")) 
                            (p2win)(nullify)(p1)(p3)(p4)(p5))
                       ((and (= trdice 1) (equal? state "Player 1's Turn")) 
                            (set! rolltrac 0)(set! state "Player 2's Turn")(p2))
                       ((and (= trdice 1)(equal? state "Player 2's Turn")) 
                             (set! rolltrac 0)(set! state "Player 1's Turn")(p1))
                       (else rolltrac))rolltrac) 

;rolls the dice and adds it to the total sum while checking if the above conditions are met
(define (rolling) (sumroll) (cona rolltrac))
(new button% [parent bpanel1] 
     [label "Roll"]
      [callback (lambda (t e) (send mess5 set-label (number->string  (rolling) )))]
     )

;stores the value of the total dice roll sums while setting it to 0 for the next turn
;it also changes the state to the other player
(new button% [parent bpanel1] 
     [label "Pass"]
     [callback (lambda (t e) 
             (if (equal? state "Player 1's Turn") 
             (begin(set! state "Player 2's Turn")(p2)(p1store)(p3)(set! rolltrac 0)(p4))
             (begin(set! state "Player 1's Turn")(p1)(p2store)(p5)(set! rolltrac 0)(p4))
             ))]
     )


;exits the game
(new button% [parent bpanel1]
             [label "Exit"]
             [callback (lambda (button event) (exit))])




(send mainframe show #t)
