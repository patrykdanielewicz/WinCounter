//
//  MatchView.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 23/01/2025.
//

import SwiftUI

struct AddNewMatchView: View {
    
    @State var sparring: Sparring
    @State var selectedPlayers = [Players]()
    @State var isTwoPlayersOrTeamSelected = false
    @State private var startMatch = false

    
    var body: some View {
        NavigationStack {
            List() {
                
                Section("Chose players for match") {
                    if let players = sparring.players {
                        ForEach(players) { player in
                            Button {
                                addingPlayersforSparring(for: player)
                            } label: {
                                HStack {
                                    if let image = player.image {
                                        if let uiimage = UIImage(data: image) {
                                            Image(uiImage: uiimage)
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(Circle())
                                                .frame(width: 50, height: 50)
                                            
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
                        Button {
                            if selectedPlayers.count != 2 {
                                isTwoPlayersOrTeamSelected = true
                            }
                            else {
                                
                                startMatch = true
                            }
                        } label: {
                            Text("Start game")
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $startMatch, destination: {
                MatchView(sparring: sparring, selectedPlayers: selectedPlayers)
            })
            .alert("Two players or team only", isPresented: $isTwoPlayersOrTeamSelected) {
                Button("OK") {
                    
                }
            } message: {
                Text("Badminton can be played either by two players or by two teams.")
            }

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
//    MatchView()
//}
