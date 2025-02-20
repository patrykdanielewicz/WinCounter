//
//  DataForSparringsDetailView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//
//
//import Foundation
//
//struct DataForSparringsDetailView {
//    
//    
//    
//    static func playersMatchesInSparring(sparring: [Sparring], player: Players) -> Int {
//        var playersMatches = 0
//        for spar in sparring {
//            if let matches = spar.matches {
//                for match in matches {
//                    if match.points.keys.contains(player.name) {
//                        playersMatches += 1
//                    }
//                }
//            } }
//        return playersMatches
//    }
//    
//    static func playersWonMatches(sparring: [Sparring], player: Players) -> Int {
//        var wins = 0
//        for spar in sparring {
//            if let matches = spar.matches {
//                for match in matches {
//                    if match.winner.keys.contains(player.name) {
//                        wins += 1
//                    }
//                }
//            }
//        }
//        return wins
//    }
//    
//    static func playersLostMatches(sparring: [Sparring], player: Players) -> Int {
//        var losses = 0
//        for spar in sparring {
//            if let matches = spar.matches {
//                for match in matches {
//                    if match.points.keys.contains(player.name) && !match.winner.keys.contains(player.name) {
//                        losses += 1
//                    }
//                }
//            }
//        }
//        return losses
//    }
//    static func totalMatchesWithUniqueOpponent(sparring: [Sparring], player: Players) -> [String: Int] {
//        var opponents = [String]()
//        for spar in sparring {
//            if let matches = spar.matches {
//                for match in matches {
//                    if match.points.keys.contains(player.name) {
//                        let rival =  match.points.filter { $0.key != player.name }
//                        let rivalArrya = Array(rival.keys)
//                        for rival in rivalArrya {
//                            opponents.append(rival)
//                        }
//                    }
//                }
//            }
//        }
//        let counts = opponents.reduce(into: [:]) { opponent, count in
//            opponent[count, default: 0] += 1
//        }
//        return counts
//    }
//    
//    
//    
//    static func mostFrequentOpponentForPlayer(sparring: [Sparring], player: Players) -> String {
//     
//        let counts = totalMatchesWithUniqueOpponent(sparring: sparring, player: player)
//        
//        if let mostFrequentOpponent = counts.max(by: { $0.value < $1.value })?.key {
//            return mostFrequentOpponent
//        }
//        else {
//            return "No data"
//        }
//    }
//    
//    static func playersEachOpponentsStats(sparring: [Sparring], player: Players) -> [String : [Int]] {
//        var opponents = [String]()
//        var opponentsWinLossesDictionary = [String : [Int]]()
//        for spar in sparring {
//            if let matches = spar.matches {
//                for match in matches {
//                    if match.points.keys.contains(player.name) {
//                        let rival =  match.points.filter { $0.key != player.name }
//                        let rivalArrya = Array(rival.keys)
//                        for rival in rivalArrya {
//                            opponents.append(rival)
//                        }
//                    }
//                }
//            }
//        }
//        let uniqueOpponents = Set(opponents)
//        for spar in sparring {
//            for uniqueOpponent in uniqueOpponents {
//                var matchesWinByOpponents = 0
//                var matchesWithOpponent = 0
//                if let matches = spar.matches {
//                    for match in matches {
//                        
//                        if match.points.keys.contains(player.name) {
//                            
//                            if match.winner.keys.contains(uniqueOpponent) {
//                                matchesWinByOpponents += 1
//                                print("x")
//                            }
//                            if match.points.keys.contains(uniqueOpponent) {
//                                matchesWithOpponent += 1
//                            }
//                            
//                        }
//                    }
//                    let matchesLostByOpponents = matchesWithOpponent - matchesWinByOpponents
//                    var winLossesArray = [Int]()
//                    winLossesArray.append(matchesLostByOpponents)
//                    winLossesArray.append(matchesWinByOpponents)
//                    opponentsWinLossesDictionary[uniqueOpponent] = winLossesArray
//                } }
//        }
//
//        return opponentsWinLossesDictionary
//    }
//    static func mostWinsAgainstOpponent(opponentsStats: [String : [Int]]) -> [String] {
//        var array = [String]()
//        var winPercentageWithOpponents = [String: Double]()
//        
//        for opponent in opponentsStats {
//            let wins = opponent.value[0]
//            let total = opponent.value[0] + opponent.value[1]
//            let vinsInPercentage = Double(wins) / Double(total)
//            winPercentageWithOpponents[opponent.key] = vinsInPercentage
//        }
//        if let maxWinPercentage = winPercentageWithOpponents.max(by: { $0.value < $1.value}) {
//            let opponentsWithMaxWinPercentage = winPercentageWithOpponents.filter { $0 == maxWinPercentage}.map {$0.key}
//            
//            for opponent in opponentsWithMaxWinPercentage {
//                let winLosses = opponentsStats.filter { $0.key == opponent}
//                for x in winLosses {
//                    array.append(x.key)
//                }
//            }
//        }
//        else {
//            array.append("No data")
//        }
//        return array
//    }
//    static func mostLossesAgainstOppoent(opponentsStats: [String: [Int]]) -> [String] {
//        var array = [String]()
//        var lossesPercentageWithOpponents = [String: Double]()
//        
//        for opponent in opponentsStats {
//            let losses =  opponent.value[1]
//            let total = opponent.value[0] + losses
//            let winInPercentage = Double(losses) / Double(total)
//            lossesPercentageWithOpponents[opponent.key] = winInPercentage
//        }
//        
//        if let maxWinPercentage = lossesPercentageWithOpponents.max(by: { $0.value < $1.value}) {
//            let opponentsWithMaxLossesPercentage = lossesPercentageWithOpponents.filter { $0 == maxWinPercentage}.map {$0.key}
//            
//            for opponent in opponentsWithMaxLossesPercentage {
//                let losses = opponentsStats.filter { $0.key == opponent}
//                for x in losses {
//                    array.append(x.key)
//                }
//            }
//        }
//        else {
//            array.append("No data")
//        }
//        return array
//    }
//    
//}

