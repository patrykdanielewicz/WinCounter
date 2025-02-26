//
//  ContentView.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 21/01/2025.
//
import CoreData
import SwiftUI

struct SparringView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Sparring.date, ascending: false)]) private var sparrings: FetchedResults<Sparring>
    @State private var newSparringAdded = false
    @State private var latestSparring: Sparring?
    
    var body: some View {
    
        NavigationStack {
            NavigationLink("Add sparring") {
                AddNewSparring(newSparringAdded: $newSparringAdded)
            }
            List() {
                ForEach(sparrings) { sparring in
                    if !sparring.isSparringEnded {
                        NavigationLink {
                            AddNewMatchView(sparring: sparring)
                        } label: {
                            Text("\(sparring.wrappedDate, format: .dateTime.day().month(.wide).year())")
                        }
                    }
                }
                .listItemTint(.brand)
            }
            .listStyle(.carousel)
            .frame(maxHeight: .infinity)
            .navigationTitle("Sparrings")
            .navigationBarTitleDisplayMode(.inline)
        }
   
       
    }
}

//#Preview {
//    ContentView()
//}
