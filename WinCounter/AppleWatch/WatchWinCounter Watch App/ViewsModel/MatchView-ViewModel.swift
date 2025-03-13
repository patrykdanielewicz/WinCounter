//
//  MatchView-ViewModel.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 13/03/2025.
//

import Foundation

class MatchViewModel: ObservableObject {
    
    let dc: DataControllerProtocol
    let sparring: Sparring
    
    @Published  var selectedPlayers: [Player]
    @Published  var isATie = false
    @Published  var isGameOver = false
    
    @Published  var scorePlayer1 = 0
    @Published  var scorePlayer2 = 0
    
    @Published  var newMatch = false
    @Published  var endSparring = false
    
    init(dataController: DataControllerProtocol, sparring: Sparring, selectedPlayers: [Player]) {
        self.dc = dataController
        self.sparring = sparring
        self.selectedPlayers = selectedPlayers
    }
    
    func addingPointToPlayer1() {
        scorePlayer1 += 1
    }
    
    func addingPointToPlayer2() {
        scorePlayer2 += 1
    }
    
    func substractPointToPlayer1() {
        scorePlayer1 -= 1
    }
    
    func substracPointToPlayer2() {
        scorePlayer2 -= 1
    }
    
    func gameOver() {
        isGameOver = true
    }
    
    func newGame() {
        newMatch = true
    }
    
    func savingMatch() {
        if scorePlayer1 == scorePlayer2 {
            isATie = true
            return
        }
        let matchNumber = sparring.wrappedMatches.count + 1
        let match = dc.addingMatch(sparring: sparring, matchNumber: matchNumber)
        if selectedPlayers.count == 2 {
            let player1 = dc.addingMatchPoint(player: selectedPlayers[0], match: match, point: scorePlayer1)
            match.addToPoints(player1)
            let player2 = dc.addingMatchPoint(player: selectedPlayers[1], match: match, point: scorePlayer2)
            match.addToPoints(player2)
        }
        else {
            return
        }
        
        if scorePlayer1 > scorePlayer2 {
            let winner = dc.addingMatchWinner(match: match, winningPlayer: selectedPlayers[0], points: scorePlayer1)
            match.winner = winner
     }
     else {
         let winner = dc.addingMatchWinner(match: match, winningPlayer: selectedPlayers[1], points: scorePlayer2)
         match.winner = winner
    }
        dc.saveData()
    }
}
