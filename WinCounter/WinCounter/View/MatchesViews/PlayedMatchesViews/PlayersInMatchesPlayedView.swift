//
//  PlayersInMatchesPlayedView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 23/02/2025.
//

import SwiftUI

struct PlayersInMatchesPlayedView: View {
    
    let match: Match
    
    @FetchRequest private var matchPoints: FetchedResults<MatchPoints>
    
    init(match: Match) {
        self.match = match
        self._matchPoints = FetchRequest<MatchPoints>(
            sortDescriptors: [NSSortDescriptor(keyPath: \MatchPoints.points, ascending: false)],
            predicate: NSPredicate(format: "match == %@", argumentArray: [match]),
               animation: .default
           )
       }
    
    var body: some View {
        ForEach(matchPoints) { points in
            let player = points.wrappedPlayer
            Text("\(player.wrappedName): \(Int(points.points)) points")
                .fontWeight(match.winner?.player == player ? .bold : .regular)
            
        }
    }
}

