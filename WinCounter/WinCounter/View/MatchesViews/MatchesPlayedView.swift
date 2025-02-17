//
//  MatchesPlayedView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 21/01/2025.
//

import SwiftUI

struct MatchesPlayedView: View {
    
    @Environment(\.modelContext) var modelContext

    @Binding var sparring: Sparring
    @Binding var matchNumber: Int
    
    var body: some View {
                if let matches = sparring.matches {
                    ForEach(matches.sorted(by: { $0.matchNumber > $1.matchNumber } ), id: \.self) { match in
                        NavigationLink {
                            MatchEditingView(match: match, sparring: sparring)
                        } label: {
                            VStack(alignment: .leading) {
                                Text("Match nr \(match.matchNumber)")
                                    .font(.headline)
                                ForEach(match.points.sorted(by: <), id: \.key) { key, value in
                                    Text("\(key): \(value) points")
                                }
                            }
                        }
                        
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(match)
                                do {
                                    try modelContext.save()
                                } catch {
                                    print("Błąd zapisu: \(error.localizedDescription)")
                                }
                            }
                            .tint(.red)
                        }
                    }
                }
            
    }
}

//#Preview {
//    MatchesPlayedView()
//}
