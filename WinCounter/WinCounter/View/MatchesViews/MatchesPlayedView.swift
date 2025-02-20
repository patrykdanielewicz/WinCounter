//
//  MatchesPlayedView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 21/01/2025.
//
import CoreData
import SwiftUI

struct MatchesPlayedView: View {
    
    @Environment(\.managedObjectContext) var moc

    @Binding var sparring: Sparring
    @Binding var matchNumber: Int
    
    var body: some View {
        if let matches = sparring.wrappedMatches {
                    ForEach(matches, id: \.self) { match in
                        NavigationLink {
                            MatchEditingView(match: match, sparring: sparring)
                        } label: {
                            VStack(alignment: .leading) {
                                Text("Match nr \(Int(match.matchNumber))")
                                    .font(.headline)
                                ForEach(match.points.sorted(by: <), id: \.key) { key, value in
                                    Text("\(key): \(value) points")
                                }
                            }
                        }
                        
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                moc.delete(match)
                                do {
                                    try moc.save()
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
