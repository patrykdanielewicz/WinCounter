//
//  AddNewSparring.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 23/01/2025.
//
import CoreData
import SwiftUI

struct AddNewSparring: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) private var players: FetchedResults<Player>
    
    @State var sparringDate: Date = Date()
    @State var selectedPlayers: [Player] = []
    

    @State private var lessThenTwoPlayers = false
    
    @Binding var newSparringAdded: Bool
    @State private var sparring: Sparring?
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Select a date", selection: $sparringDate, displayedComponents: .date)

                Section("Select players") {
                    
                    List() {
                        ForEach(players, id: \.self) { player in
                            if player.doubels == false {
                                Button {
                                    addingPlayersforSparring(for: player)
                                } label: {
                                    HStack {
                                        if let image = player.image {
                                            if let uiImage = UIImage(data: image) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 30, height: 30)
                                                    .clipShape(.circle)
                                            }
                                        }
                                        Text(player.wrappedName)
                                        Spacer()
                                        if selectedPlayers.contains(player) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.brand)
                                        }
                                    }
                                }
                            }
                            else {
                                Button {
                                    addingPlayersforSparring(for: player)
                                } label: {
                                    HStack {
                                        if let image = player.image {
                                            if let uiImage = UIImage(data: image) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 50, height: 50)
                                                    .clipShape(.circle)
                                            }
                                        }
                                        Text(player.wrappedName)
                                        Spacer()
                                        if selectedPlayers.contains(player) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.green)
                                        }
                                    }
                                }
                            }
                        }
                        Button("Done") {
                            if selectedPlayers.count < 2 {
                                lessThenTwoPlayers.toggle()
                                return
                            }
                            let sparring = Sparring(context: moc)
                            sparring.date = sparringDate
                            for player in selectedPlayers {
                                sparring.addToPlayers(player)
                            }
                            
                           
                                do {
                                    try moc.save()
                                }
                                catch {
                                    print(error.localizedDescription)
                                }
                                
                                newSparringAdded = true
                                
                                
                            
                        }

                    }
                 
                    
                }
                

                
            }
            .navigationDestination(isPresented: $newSparringAdded) {
                if let sparring = sparring {
                    AddNewMatchView(sparring: sparring)
                }
            }
            .navigationTitle("Add new Sparring")
        }
  
        .alert("Not enought players or teams", isPresented: $lessThenTwoPlayers) {
            Button("Ok") { }
        } message: {
            Text("There are not enough players or teams to play the match - please mark at least 2 players or teams")
        }

        }
    func addingPlayersforSparring(for player: Player) {
        if let index = selectedPlayers.firstIndex(of: player) {
            selectedPlayers.remove(at: index)
        } else {
            selectedPlayers.append(player)
        }
        
    }
}

//#Preview {
//    AddNewSparring()
//}
