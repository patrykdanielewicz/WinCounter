//
//  AddNewSparring.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 23/01/2025.
//
import SwiftData
import SwiftUI

struct AddNewSparring: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query var players: [Players]
    
    @State var sparringDate: Date = Date()
    @State var selectedPlayers: [Players] = []
    

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
                            if player.singels == true {
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
                                        Text(player.name)
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
                                        Text(player.name)
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
                            sparring = Sparring(date: sparringDate, players: selectedPlayers)
                            if let sparring = sparring {
                                modelContext.insert(sparring)
                                do {
                                    try modelContext.save()
                                }
                                catch {
                                    print(error.localizedDescription)
                                }
                                
                                newSparringAdded = true
                                
                                
                            }
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
    func addingPlayersforSparring(for player: Players) {
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
