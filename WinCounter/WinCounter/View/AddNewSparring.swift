//
//  AddNewSparring.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 18/12/2024.
//
import CoreData
import SwiftUI

struct AddNewSparring: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var players: FetchedResults<Player>
    
    
    @State var sparringDate: Date = Date()
    @State var selectedPlayers: [Player] = []
    
    @State private var isAddNewPlayerButtonPresed = false
    @State private var isAddNewTeamButtonPresed = false
    @State private var lessThenTwoPlayers = false

    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Select a date", selection: $sparringDate, displayedComponents: .date)
                List() {
                    Section("Select players") {
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
                        
                        Button("Add new Player") {
                            isAddNewPlayerButtonPresed.toggle()
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    
                    Section("Select team") {
                        ForEach(players, id: \.self) { player in
                            if player.doubels == true {
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
                        
                        
                        Button("Add new Team") {
                            isAddNewTeamButtonPresed.toggle()
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    
                }
            }
            .navigationTitle("Add new Sparring")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add new Sparring", systemImage: "checkmark.circle.fill") {
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

                        dismiss()
                     
                    }
                }
            }
        }
  
        .sheet(isPresented: $isAddNewPlayerButtonPresed) {
            AddNewPlayer()
        }
        .sheet(isPresented: $isAddNewTeamButtonPresed) {
//            AddNewTeam()
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
