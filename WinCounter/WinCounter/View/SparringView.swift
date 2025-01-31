//
//  MachesView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 18/12/2024.
//
import SwiftData
import SwiftUI

struct SparringView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var sparrings: [Sparring]

    
    @State private var isAddNewSparringPresented: Bool = false
    @State private var isNewSparringAdded:        Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sparrings) { sparing in
                    NavigationLink {
                        MatchesView(sparring: sparing)
                    } label: {
                        Text("\(sparing.date, format: .dateTime.day().month(.wide).year())")
                        
                    }
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            modelContext.delete(sparing)
                            do {
                                 try modelContext.save()
                            }
                            catch {
                                print(error.localizedDescription)
                            }

                        }
                        .tint(.red)
                    }
                }

            }
            .onChange(of: sparrings, { oldValue, newValue in
                if newValue.count > oldValue.count {
                    isNewSparringAdded = true
                }
            })
            .navigationDestination(isPresented: $isNewSparringAdded) {
                if let sparring = sparrings.last {
                    MatchesView(sparring: sparring)
                }
            }
            .navigationTitle("Sparrings")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add new sparring", systemImage: "plus") {
                        isAddNewSparringPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $isAddNewSparringPresented) {
                AddNewSparring()
            }
            
            
            
        }
    }
    
//    func fetchMatches(sparring: Sparring) -> [Matches] {
//        do {
//            return try modelContext.fetch(FetchDescriptor<Matches>(predicate: #Predicate {match in
//                match.sparring.id == sparring.id
//            }))
//        }
//        catch {
//            print("Error fetching players: \(error)")
//                    return []
//        }
//    }
    
    
}
//#Preview {
//    SparringView()
//}
