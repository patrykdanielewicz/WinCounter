//
//  MachesView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 18/12/2024.
//
import CoreData
import SwiftUI

struct SparringView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var sparrings: FetchedResults<Sparring>
    
    @State private var isAddNewSparringPresented: Bool = false
    @State private var isNewSparringAdded:        Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sparrings, id: \.self) { sparring in
                    NavigationLink {
                        //                        MatchesView(sparring: sparring)
                    } label: {
                        Text("\(sparring.wrappedDate, format: .dateTime.day().month(.wide).year())")
                        
                        
                    }
                    
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            moc.delete(sparring)
                            do {
                                try moc.save()
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                            
                        }
                        .tint(.red)
                    }
                }
            }
                
            .onReceive(NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)) { notification in
                if let insertedObjects = notification.userInfo?[NSInsertedObjectsKey] as? Set<NSManagedObject> {
                    if insertedObjects.contains(where: {$0 is Sparring}) {
                        isNewSparringAdded = true
                    }
                }
            }
                       
                .navigationDestination(isPresented: $isNewSparringAdded) {
                    if let sparring = sparrings.first {
                        //                    MatchesView(sparring: sparring)
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
    
    
//}
//#Preview {
//    SparringView()
//}
