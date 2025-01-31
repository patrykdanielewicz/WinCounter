//
//  Sparring.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import SwiftData
import Foundation

@Model
class Sparring: Hashable, Identifiable {
    
    var id = UUID()
    
    var isSparringEnded = false
    
    @Relationship(deleteRule: .cascade) var matches: [Matches]?
    
    var date: Date = Date.now
    @Relationship(inverse: \Players.sparrings) var players: [Players]?
    
    init(isSparringEnded: Bool = false, matches: [Matches]? = nil, date: Date, players: [Players]? = nil) {
        self.isSparringEnded = isSparringEnded
        self.matches = matches
        self.date = date
        self.players = players
    }
    
}
