//
//  AddNewSparring.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 23/01/2025.
//
import CoreData
import SwiftUI

struct AddNewSparring: View {
    
    @StateObject private var viewModel: AddNewSparringViewModel
    
    @Environment(\.dismiss) var dismiss
 
    init(dataController: DataControllerProtocol) {
        _viewModel = StateObject(wrappedValue: AddNewSparringViewModel(dataController: dataController))
        }
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Select a date", selection: $viewModel.sparringDate, displayedComponents: .date)

                Section("Select players") {
                    
                    List() {
                        ForEach(viewModel.players, id: \.self) { player in
                            if player.doubles == false {
                                Button {
                                    viewModel.addingPlayersforSparring(for: player)
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
                                        if viewModel.selectedPlayers.contains(player) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.brand)
                                        }
                                    }
                                }
                            }
                            else {
                                Button {
                                    viewModel.addingPlayersforSparring(for: player)
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
                                        if viewModel.selectedPlayers.contains(player) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.green)
                                        }
                                    }
                                }
                            }
                        }
                        Button("Done") {
                            if !viewModel.AreEnoughPlayers() {
                                return
                            }
                            viewModel.saveSparring()
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Add new Sparring")
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
