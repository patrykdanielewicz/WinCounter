//
//  StatisticPreparation.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 24/02/2025.
//

import Foundation

struct StatisticPreparation {
    
    static func makingRivalsArray(for player: Player) -> [Player] {
        var playersInMatch = [Player]()
        var opponentsInMatches = [Player]()
        for matchPoints in player.pointsInMatchArray {
            if let matchPointsInMatch = matchPoints.match?.wrappedPoints {
                for matchPoint in matchPointsInMatch {
                    playersInMatch.append(matchPoint.wrappedPlayer)
                }
            }
        }
        let filteredPlayersInMatch = playersInMatch.filter { $0 != player }
        let playersInMatchSet: Set<Player> = Set(filteredPlayersInMatch)
        for opponent in playersInMatchSet {
            opponentsInMatches.append(opponent)
        }
        return opponentsInMatches
    }
    
    static func totalWins(for player: Player) -> Int {
       return player.winnerInMatchArray.count
    }
    
    static func totalLosses(for player: Player) -> Int {
        return (player.pointsInMatchArray.count - player.winnerInMatchArray.count)
    }
    
    
    static func calculateWins(for player: Player, with opponent: Player) -> Int {
        var wins = 0
        for matchPoints in opponent.pointsInMatchArray {
            if let matchWinner = matchPoints.match?.winner {
                if matchWinner.wrappedPlayer == player {
                    wins += 1
                }
            }
        }
        return wins
    }
    static func calculateLosses(for player: Player, with opponent: Player) -> Int {
        var loses = 0
        for matchPoints in player.pointsInMatchArray {
            if let matchWinner = matchPoints.match?.winner {
                if matchWinner.wrappedPlayer == opponent {
                    loses += 1
                }
            }
        }
        return loses
    }
}

