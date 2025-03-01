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
                    showImageInsertOptions.toggle()
                } label: {
                    if let playersImage = playersImage {
                        Image(uiImage: playersImage)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                            .scaledToFill()
                    }
                }
                
                Form {
                    TextField("Enter Player's name", text: $name)
                }
                Spacer()
            }
            .sheet(isPresented: $showImageInsertOptions) {
                PlayersImageInsertOptions(selectedImage: $playersImage, showInsertImageOptions: $showImageInsertOptions)
            }
            .alert("Name is too short", isPresented: $notEnoughCaractersInName) {
                Button("OK") { }
            } message: {
                Text("The name must have at least two characters.")
            }
            .navigationTitle("Add new Player")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", systemImage: "person.fill.checkmark") {
                        if name.count < 2 {
                            notEnoughCaractersInName = true
                            return
                        }
                        if playersImage == UIImage(named: "addPicture") {
                            playersImage = UIImage(named: "player0")!
                        }
                        if let playersImage = playersImage {
                            if let dataImage = playersImage.jpegData(compressionQuality: 0.6) {
                                let player = Player(context: moc)
                                player.name = name
                                player.doubels = false
                                player.image = dataImage
                                
                                do {
                                    try moc.save()
                                }
                                catch {
                                    print(error.localizedDescription)
                                }
                            }
                            
                            dismiss()
                        }
                    }
                    .tint(.brandPrimary)
                }
            }
        }

    }
    
//    func savePlayer() {
//        if name.count < 2 {
//            notEnoughCaractersInName = true
//            return
//        }
//        if playersImage == UIImage(named: "addPicture") {
//            playersImage = UIImage(named: "player0")!
//        }
//        if let dataImage = playersImage.jpegData(compressionQuality: 0.6) {
//                let player = Players(singels: true, name: name, image: dataImage)
//                modelContext.insert(player)
//                do {
//                    try modelContext.save()
//                }
//                catch {
//                    print(error.localizedDescription)
//                }
//            }
//    }
    
    func converToUIIImage(selectetItem: PhotosPickerItem) {
        
        Task {
            do {
                if let data = try await selectetItem.loadTransferable(type: Data.self) {
                    if let  uiImage = UIImage(data: data) {
                        playersImage = uiImage

                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }

}
