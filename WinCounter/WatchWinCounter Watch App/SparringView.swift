//
//  ContentView.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 21/01/2025.
//
//import SwiftData
//import SwiftUI
//
//struct SparringView: View {
//    
//    @Environment(\.modelContext) var modelContext
//    @Query(sort: \Sparring.date, order: .reverse) var sparrings : [Sparring]
//    
//    @State private var newSparringAdded = false
//    @State private var latestSparring: Sparring?
//    
//    var body: some View {
//    
//        NavigationStack {
//            NavigationLink("Add sparring") {
//                AddNewSparring(newSparringAdded: $newSparringAdded)
//            }
//            List() {
//                ForEach(sparrings) { sparring in
//                    if !sparring.isSparringEnded {
//                        NavigationLink {
//                            AddNewMatchView(sparring: sparring)
//                        } label: {
//                            Text("\(sparring.date, format: .dateTime.day().month(.wide).year())")
//                        }
//                    }
//                }
//                .listItemTint(.brand)
//            }
//            .listStyle(.carousel)
//            .frame(maxHeight: .infinity)
//            .navigationTitle("Sparrings")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//   
//       
//    }
//}
//
//#Preview {
//    ContentView()
//}
