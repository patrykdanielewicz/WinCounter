//
//  MatchesPlayedView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 21/01/2025.
//
import CoreData
import SwiftUI

struct MatchesPlayedView: View {
    
    let sparring: Sparring
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest private var matches: FetchedResults<Match>
    
    init(sparring: Sparring) {
           self.sparring = sparring
           self._matches = FetchRequest<Match>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Match.matchNumber, ascending: false)],
               predicate: NSPredicate(format: "sparring == %@", argumentArray: [sparring]),
               animation: .default
           )
       }
    
    var body: some View {
                    ForEach(matches, id: \.self) { match in
                        NavigationLink {
                            MatchEditingView(match: match)
                        } label: {
                            VStack(alignment: .leading) {
                                Text("Match nr \(Int(match.matchNumber))")
                                    .font(.headline)
                                PlayersInMatchesPlayedView(match: match)
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

//#Preview {
//    MatchesPlayedView()
//}
