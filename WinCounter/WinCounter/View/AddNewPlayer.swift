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
    @StateObject private var viewModel = AddNewPlayerViewModel()

    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    viewModel.showingImageInsertOptions()
                } label: {
                    if let playersImage = viewModel.playerUIImage {
                        Image(uiImage: playersImage)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                            .scaledToFill()
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
                    TextField("Enter Player's name", text: $viewModel.name)
                }
                Spacer()
            }
            .sheet(isPresented: $viewModel.showImageInsertOptions) {
                PlayersImageInsertOptions()
            }
            .alert("Name is too short", isPresented: $viewModel.notEnoughCaractersInName) {
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
    


