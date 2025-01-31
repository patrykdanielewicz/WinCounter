//
//  DataForSparringsDetailView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import Foundation

struct DataForSparringsDetailView {
    
    
    
    static func playersMatchesInSparring(sparring: [Sparring], player: Players) -> Int {
        var playersMatches = 0
        for spar in sparring {
            if let matches = spar.matches {
                for match in matches {
                    if match.points.keys.contains(player.name) {
                        playersMatches += 1
                    }
                }
            } }
        return playersMatches
    }
    
    static func playersWonMatches(sparring: [Sparring], player: Players) -> Int {
        var wins = 0
        for spar in sparring {
            if let matches = spar.matches {
                for match in matches {
                    if match.winner.keys.contains(player.name) {
                        wins += 1
                    }
                }
            }
        }
        return wins
    }
    
    static func playersLostMatches(sparring: [Sparring], player: Players) -> Int {
        var loses = 0
        for spar in sparring {
            if let matches = spar.matches {
                for match in matches {
                    if match.points.keys.contains(player.name) && !match.winner.keys.contains(player.name) {
                        loses += 1
                    }
                }
            }
        }
        return loses
    }
    static func totalMatchesWithUniqueOponent(sparring: [Sparring], player: Players) -> [String: Int] {
        var oponents = [String]()
        for spar in sparring {
            if let matches = spar.matches {
                for match in matches {
                    if match.points.keys.contains(player.name) {
                        let rival =  match.points.filter { $0.key != player.name }
                        let rivalArrya = Array(rival.keys)
                        for rival in rivalArrya {
                            oponents.append(rival)
                        }
                    }
                }
            }
        }
        let counts = oponents.reduce(into: [:]) { oponent, count in
            oponent[count, default: 0] += 1
        }
        return counts
    }
    
    
    
    static func mostFrequentOpponentForPlayer(sparring: [Sparring], player: Players) -> String {
     
        let counts = totalMatchesWithUniqueOponent(sparring: sparring, player: player)
        
        if let mostFrequentOpponent = counts.max(by: { $0.value < $1.value })?.key {
            return mostFrequentOpponent
        }
        else {
            return "No data"
        }
    }
    
    static func playersEachOponentsStats(sparring: [Sparring], player: Players) -> [String : [Int]] {
        var oponents = [String]()
        var oponentsWinLoseDictionary = [String : [Int]]()
        for spar in sparring {
            if let matches = spar.matches {
                for match in matches {
                    if match.points.keys.contains(player.name) {
                        let rival =  match.points.filter { $0.key != player.name }
                        let rivalArrya = Array(rival.keys)
                        for rival in rivalArrya {
                            oponents.append(rival)
                        }
                    }
                }
            }
        }
        let uniqueOponents = Set(oponents)
        for spar in sparring {
            for uniqueOponent in uniqueOponents {
                var matchesWinByOponents = 0
                var matchesWithOponent = 0
                if let matches = spar.matches {
                    for match in matches {
                        
                        
                        if match.winner.keys.contains(uniqueOponent) {
                            matchesWinByOponents += 1
                        }
                        if match.points.keys.contains(uniqueOponent) {
                            matchesWithOponent += 1
                        }
                        
                    }
                    let matchesLostByOponents = matchesWithOponent - matchesWinByOponents
                    var winLoseArray = [Int]()
                    winLoseArray.append(matchesLostByOponents)
                    winLoseArray.append(matchesWinByOponents)
                    oponentsWinLoseDictionary[uniqueOponent] = winLoseArray
                } }
        }
        return oponentsWinLoseDictionary
    }
    static func mostWinsAgainstOpponent(oponentsStats: [String : [Int]]) -> [String] {
        var array = [String]()
        var winPercentageWithOponents = [String: Double]()
        
        for oponent in oponentsStats {
            let wins = oponent.value[0]
            let total = oponent.value[0] + oponent.value[1]
            let vinsInPercentage = Double(wins) / Double(total)
            winPercentageWithOponents[oponent.key] = vinsInPercentage
        }
        if let maxWinPercentage = winPercentageWithOponents.max(by: { $0.value < $1.value}) {
            let oponentsWithMaxWinPercentage = winPercentageWithOponents.filter { $0 == maxWinPercentage}.map {$0.key}
            
            for oponent in oponentsWithMaxWinPercentage {
                let winLoses = oponentsStats.filter { $0.key == oponent}
                for x in winLoses {
                    array.append(x.key)
                }
            }
        }
        else {
            array.append("No data")
        }
        return array
    }
    static func mostLosesAgainstOppoent(oponentsStats: [String: [Int]]) -> [String] {
        var array = [String]()
        var losePercentageWithOponents = [String: Double]()
        
        for oponent in oponentsStats {
            let loses =  oponent.value[1]
            let total = oponent.value[0] + loses
            let winInPercentage = Double(loses) / Double(total)
            losePercentageWithOponents[oponent.key] = winInPercentage
        }
        
        if let maxWinPercentage = losePercentageWithOponents.max(by: { $0.value < $1.value}) {
            let oponentsWithMaxLosesPercentage = losePercentageWithOponents.filter { $0 == maxWinPercentage}.map {$0.key}
            
            for oponent in oponentsWithMaxLosesPercentage {
                let loses = oponentsStats.filter { $0.key == oponent}
                for x in loses {
                    array.append(x.key)
                }
            }
        }
        else {
            array.append("No data")
        }
        return array
    }
    
}

