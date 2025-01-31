//
//  AddNewPlayerOrTeamToSparring.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 21/01/2025.
//

import SwiftUI

import SwiftData
import SwiftUI

struct AddNewPlayerOrTeamToSparring: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query var players: [Players]
    
    @State var sparring: Sparring
    @State var selectedPlayers: [Players] = []
    
    @State private var isAddNewPlayerButtonPresed = false
    @State private var isAddNewTeamButtonPresed = false
    @State private var lessThenTwoPlayers = false
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Select players") {
                    
                    List() {
                        ForEach(players) { player in
                            if player.singels == true {
                                Button {
                                    addingPlayersforSparring(for: player)
                                } label: {
                                    if let image = player.image {
                                        if let uiImage = UIImage(data: image) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50)
                                                .clipShape(.circle)
                                        } } else {
                                            Image(.player0)
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
                    Button("Add new Player") {
                        isAddNewPlayerButtonPresed.toggle()
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
                Section("Select team") {
                    
                    List() {
                        ForEach(players) { team in
                            if team.singels == false {
                                Button {
                                    addingPlayersforSparring(for: team)
                                } label: {
                                    if let image = team.image {
                                        if let uiImage = UIImage(data: image) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .clipShape(.circle)
                                        } } else {
                                            Image(.player0)
                                        }
                                    
                                    Text(team.name)
                                    Spacer()
                                    if selectedPlayers.contains(team) {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color.green)
                                    }
                                }
                            }
                        }
                        
                        // x
                    }
                    Button("Add new Team") {
                        isAddNewTeamButtonPresed.toggle()
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
            }
            .navigationTitle("Add new player or team")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add new player or team", systemImage: "checkmark.circle.fill") {
                        for player in selectedPlayers {
                            sparring.players?.append(player)
                        }
                        do {
                            try modelContext.save()
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                        dismiss()
                     
                    }
                }
            }
        }
        .sheet(isPresented: $isAddNewPlayerButtonPresed) {
            AddNewPlayer()
        }
        .sheet(isPresented: $isAddNewTeamButtonPresed) {
            AddNewTeam()
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

#Preview {
    AddNewSparring()
}
