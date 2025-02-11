//
//  Players.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import SwiftData
import Foundation

@Model
class Players: Hashable, Identifiable {
    
    var id = UUID()
    
    var singels: Bool = true
    var doublesPlayerNr1: String?
    var doublesPlayerNr2: String?
    
    var sparrings: [Sparring]?
   
    var name: String = "Unknown"
    var image: Data?
    
    @Transient
    var totalGames: Int {
        var games = 0
        if let sparrings = sparrings {
            for sparring in sparrings {
                if let matches = sparring.matches {
                    for match in matches {
                        if match.points.keys.contains(name) {
                            games += 1
                        }
                    }
                }
            }
            
        }
        return games
    }
    @Transient
    var totalWins: Int {
        var win = 0
        if let sparrings = sparrings {
            for sparring in sparrings {
                if let matches = sparring.matches {
                    for match in matches {
                        if match.points.keys.contains(name) {
                            if match.winner.keys.contains(name) {
                                win += 1
                            }
                        }
                    }
                }
            }
        }
        return win
    }
    @Transient
    var rivals: Set<String> {
        var opponents: Set<String> = []
        if let sparrings = sparrings {
            for sparring in sparrings {
                if let matches = sparring.matches {
                    for match in matches {
                        if match.points.keys.contains(name) {
                            let rivals = Array(match.points.keys).filter { $0 != name}
                            for rival in rivals {
                                opponents.insert(rival)
                            }
                            
                        }
                    }
                }
            }
            
        }
        return opponents
    }
    
    @Transient
    var winsWithUniqueRivals: [String: Int] {
        var opponentsWithWhomPlayerWins: [String] = []
        var winningMatchesAgainstRival: [String:Int] = [:]
        if let sparrings = sparrings {
            for sparring in sparrings {
                if let matches = sparring.matches {
                    for match in matches {
                        if match.points.keys.contains(name) {
                            if match.winner.keys.contains(name) {
                                
                                let losingPlayers = Array(match.points.keys).filter { $0 != name}
                                for losingPlayer in losingPlayers {
                                    opponentsWithWhomPlayerWins.append(losingPlayer)
                                }
                            }
                        }
                    }
                }
            }
            let uniqueOpponents = Set(opponentsWithWhomPlayerWins)
            for uniqueOpponent in uniqueOpponents {
                
                let numberOfWinnigGamesWithUniqueOpponent = opponentsWithWhomPlayerWins.filter { $0 == uniqueOpponent }.count
                winningMatchesAgainstRival[uniqueOpponent] = numberOfWinnigGamesWithUniqueOpponent
                
            }
            
            
        }
        return winningMatchesAgainstRival
    }
    
    @Transient
    var lostWithUnigueRivals: [String: Int] {
        var opponentsWithWhomPlayerLost: [String] = []
        var lostMatchesAgainstRival: [String:Int] = [:]
        if let sparrings = sparrings {
            for sparring in sparrings {
                if let matches = sparring.matches {
                    for match in matches {
                        if match.points.keys.contains(name) {
                            if !match.winner.keys.contains(name) {
                                
                                let winningPlayers = Array(match.points.keys).filter { $0 != name}
                                for winningPlayer in winningPlayers {
                                    opponentsWithWhomPlayerLost.append(winningPlayer)
                                }
                            }
                        }
                    }
                }
            }
            let uniqueOpponents = Set(opponentsWithWhomPlayerLost)
            for uniqueOpponent in uniqueOpponents {
                
                let numberOfLostGamesWithUniqueOpponent = opponentsWithWhomPlayerLost.filter { $0 == uniqueOpponent }.count
                lostMatchesAgainstRival[uniqueOpponent] = numberOfLostGamesWithUniqueOpponent
                
            }
            
            
        }
        return lostMatchesAgainstRival
    }
    
    
    init(singels: Bool, doublesPlayerNr1: String? = nil, doublesPlayerNr2: String? = nil, sparrings: [Sparring]? = nil, name: String, image: Data? = nil) {
        self.singels = singels
        self.doublesPlayerNr1 = doublesPlayerNr1
        self.doublesPlayerNr2 = doublesPlayerNr2
        self.sparrings = sparrings
        self.name = name
        self.image = image
    }
    
    
    
}

