//
//  AddNewPlayer.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 06/12/2024.
//
import CoreData
import SwiftUI
import PhotosUI

struct AddNewPlayer: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: AddNewPlayerViewModel

    init(dataController: DataControllerProtocol, doubles: Bool) {
        _viewModel = StateObject(wrappedValue: AddNewPlayerViewModel(dataController: dataController, doubles: doubles))
    }
    
    init(dataController: DataControllerProtocol, name: String, image: Data?, id: UUID?, doubles: Bool, player1Name: String, player2Name: String) {
        _viewModel = StateObject(wrappedValue: AddNewPlayerViewModel(dataController: dataController, name: name, playersImageData: image, playersID: id, doubles: doubles, players1name: player1Name, players2name: player2Name))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    viewModel.showingImageInsertOptions()
                } label: {
                    if let playersImage = viewModel.playersImageData {
                        if let image = UIImage(data: playersImage) {
                            Image(uiImage: image)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 200, height: 200)
                                .scaledToFill()
                        }
                    }
                    else {
                        Image(.addPicture)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                            .scaledToFill()
                    }
                }
                Form {
                    Section {
                        TextField(viewModel.doubles ? "Enter Team name" : "Enter Player's name", text: $viewModel.name)
                    }
                    if viewModel.doubles {
                        Section(header: Text("Players")) {
                            TextField("Enter name of player one", text: $viewModel.player1Name)
                            TextField("Enter name of player two", text: $viewModel.player2Name)
                        }
                    }
                }
                Spacer()
            }
            .sheet(isPresented: $viewModel.showImageInsertOptions) {
                PlayersImageInsertOptions(addNewPlayerViewModel: viewModel)
            }
            .alert("Name is too short", isPresented: $viewModel.notEnoughCharactersInName) {
                Button("OK") { }
            } message: {
                Text("The name must have at least two characters.")
            }
            .navigationTitle("Add new Player")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", systemImage: "person.fill.checkmark") {
                        viewModel.savePlayer()
                        dismiss()
                    }
                }
            }
            .tint(.brandPrimary)
        }
    }
}
    


