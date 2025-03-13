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
    
    @StateObject private var viewModel: AddNewMatchViewModel
    
    init(dataController: DataControllerProtocol, sparring: Sparring) {
        _viewModel = StateObject(wrappedValue: AddNewMatchViewModel(dataController: dataController, sparring: sparring))
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Chose players for match") {
                    ForEach(viewModel.playersToChoose(), id: \.id) { player in
                            Button {
                                viewModel.addingPlayersforMatch(for: player)
                            } label: {
                                HStack {
                                    let image = viewModel.dc.decodeImage(for: player)
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 30, height: 30)
                                    Text(player.wrappedName)
                                    Spacer()
                                    if viewModel.selectedPlayers.contains(player) {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color.green)
                                    }
                                }
                            }
                        }
                        Button {
                            if viewModel.selectedPlayers.count != 2 {
                                viewModel.isTwoPlayersOrTeamSelected = true
                            }
                            else {
                                viewModel.startMatch = true
                            }
                        } label: {
                            Text("Start game")
                        }
                        Button {
                            viewModel.endMatches = true
                        } label: {
                            Text("End matches")
                        }
                    
                }
            }
            .navigationDestination(isPresented: $viewModel.startMatch, destination: {
                MatchView(dataController: viewModel.dc, sparring: viewModel.sparring, selectedPlayers: viewModel.selectedPlayers)
            })
            .navigationDestination(isPresented: $viewModel.endMatches, destination: {
                SparringView(dataController: viewModel.dc)
            })
            .alert("Two players or team only", isPresented: $viewModel.isTwoPlayersOrTeamSelected) {
                Button("OK") {
                    
                }
            } message: {
                Text("Badminton can be played either by two players or by two teams.")
            }
        }
    }
}
//#Preview {
//    MatchView()
//}
