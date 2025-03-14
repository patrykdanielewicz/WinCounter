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
    @StateObject private var viewModel: AddNewSparringViewModel
    
    init(dataController: DataControllerProtocol) {
        _viewModel = StateObject(wrappedValue: AddNewSparringViewModel(dataController: dataController))
    }
    
    init(dataController: DataControllerProtocol, sparring: Sparring) {
        _viewModel = StateObject(wrappedValue: AddNewSparringViewModel(dataController: dataController, sparring: sparring))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Select a date", selection: $viewModel.sparringDate, displayedComponents: .date)
                List() {
                    Section("Select players") {
                        ForEach(viewModel.players, id: \.id) { player in
                            if player.doubles == false {
                                Button {
                                    viewModel.addingPlayersforSparring(for: player)
                                } label: {
                                    HStack {
                                        let image = viewModel.dc.decodeImage(for: player)
                                        PlayerImageView(image: image)
                                        Text(player.wrappedName)
                                        Spacer()
                                        if viewModel.selectedPlayers.contains(player) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.green)
                                        }
                                    }
                                }
                            }
                        }
                        Button("Add new Player") {
                            viewModel.pressingAddNewPlayerButton()
                            }
                            .frame(maxWidth: .infinity)
                    }
                    Section("Select team") {
                        ForEach(viewModel.players, id: \.id) { player in
                            if player.doubles == true {
                                Button {
                                    viewModel.addingPlayersforSparring(for: player)
                                } label: {
                                    HStack {
                                        let image = viewModel.dc.decodeImage(for: player)
                                        PlayerImageView(image: image)
                                        Text(player.wrappedName)
                                        Spacer()
                                        if viewModel.selectedPlayers.contains(player) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.green)
                                        }
                                    }
                                }
                            }
                        }
                        Button("Add new Team") {
                            viewModel.pressingAddNewPlayerButton()
                        }
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Add new Sparring")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add new Sparring", systemImage: "checkmark.circle.fill") {
                        if viewModel.areEnoughPlayers() {
                            viewModel.saveSparring()
                            dismiss()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isAddNewPlayerButtonPresed) {
            AddNewPlayer(dataController: viewModel.dc, doubles: false)
        }
        .sheet(isPresented: $viewModel.isAddNewTeamButtonPresed) {
            AddNewPlayer(dataController: viewModel.dc, doubles: true)
        }
        .alert("Not enought players or teams", isPresented: $viewModel.lessThenTwoPlayers) {
            Button("Ok") { }
        } message: {
            Text("There are not enough players or teams to play the match - please mark at least 2 players or teams")
        }
    }
}

//#Preview {
//    AddNewSparring()
//}
