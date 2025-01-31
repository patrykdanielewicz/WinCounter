//
//  Matches.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import SwiftData
import Foundation

@Model
class Matches: Hashable, Identifiable {
    
    var id = UUID()
    
    @Relationship(inverse: \Sparring.matches) var sparring: Sparring?
    
    var matchNumber: Int = 0
    
    var points = [String: Int]()
    
    var winner = [String: Int]()
    
 
    
    init(sparring: Sparring? = nil, matchNumber: Int, points: [String : Int] = [String: Int](), winner: [String : Int] = [String: Int]()) {
        self.sparring = sparring
        self.matchNumber = matchNumber
        self.points = points
        self.winner = winner
    }
}
