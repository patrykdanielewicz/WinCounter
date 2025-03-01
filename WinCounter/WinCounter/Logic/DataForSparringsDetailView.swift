//
//  DataForSparringsDetailView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//
//
import Foundation

struct DataForSparringsDetailView {
    
    
    
    static func playersMatchesInSparring(sparrings: [Sparring], player: Player) -> Int {
        var playersMatches = 0
        for sparring in sparrings {
            let matches = sparring.wrappedMatches
            for match in matches {
                for points in match.wrappedPoints {
                    if points.player == player {
                        playersMatches += 1
                    }
                }
            }
        }
        return playersMatches
    }
    
    static func playersWonMatches(sparrings: [Sparring], player: Player) -> Int {
        var wins = 0
        for sparring in sparrings {
            let matches = sparring.wrappedMatches
            for match in matches {
                if let winnerPlayer = match.winner?.player {
                    if winnerPlayer == player {
                        wins += 1
                    }
                }
            }
        }
        return wins
    }
    
    static func playersLostMatches(sparrings: [Sparring], player: Player) -> Int {
        let totalMatchesInSparring = playersMatchesInSparring(sparrings: sparrings, player: player)
        let winsInSparring = playersWonMatches(sparrings: sparrings, player: player)
        return totalMatchesInSparring - winsInSparring
    }
    
    static func totalMatchesWithUniqueOpponent(sparrings: [Sparring], player: Player) -> [String: Int] {
        var playerMatches = [Match]()
        var opponents = [String]()
        for sparring in sparrings {
            let matches = sparring.wrappedMatches
                for match in matches {
                    for points in match.wrappedPoints {
                        if points.player == player {
                            playerMatches.append(points.wrappedMatch)
                        }
                    }
                }
            for match in playerMatches {
                for points in match.wrappedPoints {
                    if points.player != player {
                        opponents.append(points.wrappedPlayer.wrappedName)
                    }
                }
            }
        }
        let counts = opponents.reduce(into: [:]) { opponent, count in
            opponent[count, default: 0] += 1
        }
        return counts
    }
    
    
    
    static func mostFrequentOpponentForPlayer(sparrings: [Sparring], player: Player) -> String {
        let counts = totalMatchesWithUniqueOpponent(sparrings: sparrings, player: player)
        if let mostFrequentOpponent = counts.max(by: { $0.value < $1.value })?.key {
            return mostFrequentOpponent
        }
        else {
            return "No data"
        }
    }
//    
    static func playersEachOpponentsStats(sparrings: [Sparring], player: Player) -> [Player : [Int]] {
        var playerMatches = [Match]()
        var opponents = [Player]()
        var opponentsWinLossesDictionary = [Player : [Int]]()
        for sparring in sparrings {
            let matches = sparring.wrappedMatches
                for match in matches {
                    for points in match.wrappedPoints {
                        if points.player == player {
                            playerMatches.append(points.wrappedMatch)
                        }
                    }
                }
            for match in playerMatches {
                for points in match.wrappedPoints {
                    if points.player != player {
                        opponents.append(points.wrappedPlayer)
                    }
                }
            }
        }
        let uniqueOpponents = Set(opponents)
        for sparing in sparrings {
            for uniqueOpponent in uniqueOpponents {
                var matchesWinByOpponents = 0
                var matchesWithOpponent = 0
                for match in playerMatches {
                    if let winner = match.winner?.player {
                        if winner == uniqueOpponent {
                            matchesWinByOpponents += 1
                        }
                    }
                    for point in match.wrappedPoints {
                        if point.wrappedPlayer == uniqueOpponent {
                            matchesWithOpponent += 1
                        }
                    }
                }
                let matchesLostByOpponents = matchesWithOpponent - matchesWinByOpponents
                var winLossesArray = [Int]()
                winLossesArray.append(matchesLostByOpponents)
                winLossesArray.append(matchesWinByOpponents)
                opponentsWinLossesDictionary[uniqueOpponent] = winLossesArray
            }
        }
        return opponentsWinLossesDictionary
    }
    static func mostWinsAgainstOpponent(opponentsStats: [Player : [Int]]) -> [Player] {
        var array = [Player]()
        var winPercentageWithOpponents = [Player: Double]()
        
        for opponent in opponentsStats {
            let wins = opponent.value[0]
            let total = opponent.value[0] + opponent.value[1]
            let vinsInPercentage = Double(wins) / Double(total)
            winPercentageWithOpponents[opponent.key] = vinsInPercentage
        }
        if let maxWinPercentage = winPercentageWithOpponents.max(by: { $0.value < $1.value}) {
            let opponentsWithMaxWinPercentage = winPercentageWithOpponents.filter { $0 == maxWinPercentage}.map {$0.key}
            
            for opponent in opponentsWithMaxWinPercentage {
                let winLosses = opponentsStats.filter { $0.key == opponent}
                for x in winLosses {
                    array.append(x.key)
                }
            }
        }
        else {
            array = [Player]()
        }
        return array
    }
    static func mostLossesAgainstOppoent(opponentsStats: [Player: [Int]]) -> [Player] {
        var array = [Player]()
        var lossesPercentageWithOpponents = [Player: Double]()
        
        for opponent in opponentsStats {
            let losses =  opponent.value[1]
            let total = opponent.value[0] + losses
            let winInPercentage = Double(losses) / Double(total)
            lossesPercentageWithOpponents[opponent.key] = winInPercentage
        }
        
        if let maxWinPercentage = lossesPercentageWithOpponents.max(by: { $0.value < $1.value}) {
            let opponentsWithMaxLossesPercentage = lossesPercentageWithOpponents.filter { $0 == maxWinPercentage}.map {$0.key}
            
            for opponent in opponentsWithMaxLossesPercentage {
                let losses = opponentsStats.filter { $0.key == opponent}
                for x in losses {
                    array.append(x.key)
                }
            }
        }
        else {
            array = [Player]()
        }
        return array
    }
    
}

