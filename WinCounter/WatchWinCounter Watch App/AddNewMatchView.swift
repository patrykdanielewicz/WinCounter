//
//  MatchView.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 23/01/2025.
//
//
import SwiftUI

struct AddNewMatchView: View {
    
    @Environment(\.dismiss) var dissmis
    
    @ObservedObject var sparring: Sparring
    @State var selectedPlayers = [Player]()
    @State var isTwoPlayersOrTeamSelected = false
    @State private var startMatch = false
    @State private var endMatches = false

    
    var body: some View {
        NavigationStack {
            List() {
                
                Section("Chose players for match") {
                    let players = sparring.wrappedPlayers
                    ForEach(players, id: \.self) { player in
                            Button {
                                addingPlayersforMatch(for: player)
                            } label: {
                                HStack {
                                    if let image = player.image {
                                        if let uiimage = UIImage(data: image) {
                                            Image(uiImage: uiimage)
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(Circle())
                                                .frame(width: 30, height: 30)
                                            
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
                        Button {
                            endMatches = true
                        } label: {
                            Text("End matches")
                        }
                    
                }
            }
            .navigationDestination(isPresented: $startMatch, destination: {
                MatchView(sparring: sparring, selectedPlayers: selectedPlayers)
            })
            .navigationDestination(isPresented: $endMatches, destination: {
                SparringView()
            })
            .alert("Two players or team only", isPresented: $isTwoPlayersOrTeamSelected) {
                Button("OK") {
                    
                }
            } message: {
                Text("Badminton can be played either by two players or by two teams.")
            }

        }
        
    }
    func addingPlayersforMatch(for player: Player) {
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
