//
//  AddNewPlayerOrTeamToSparring.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 21/01/2025.
//

import CoreData
import SwiftUI

struct AddNewPlayerOrTeamToSparring: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) private var players: FetchedResults<Player>
    
    @State var sparring: Sparring
    @State var selectedPlayers: [Player] = []
    
    @State private var isAddNewPlayerButtonPresed = false
    @State private var isAddNewTeamButtonPresed = false
    @State private var lessThenTwoPlayers = false
    
    var body: some View {
        NavigationStack {
            Form {
                
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
                                                    .frame(width: 50, height: 50)
                                                    .clipShape(.circle)
                                            } } else {
                                                Image(.player0)
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
                        

                    }
                    Button("Add new Player") {
                        isAddNewPlayerButtonPresed.toggle()
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
                Section("Select team") {
                    
                    List() {
                        ForEach(players, id: \.self) { team in
                            if team.doubels == true {
                                Button {
                                    addingPlayersforSparring(for: team)
                                } label: {
                                    HStack {
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
                                        
                                        Text(team.wrappedName)
                                        Spacer()
                                        if selectedPlayers.contains(team) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.green)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Button("Add new Team") {
                        isAddNewTeamButtonPresed.toggle()
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
            }
            .navigationTitle("Add new player or team")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add new player or team", systemImage: "checkmark.circle.fill") {
                        for player in selectedPlayers {
                            sparring.addToPlayers(player)
                        }
                        do {
                            try moc.save()
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
