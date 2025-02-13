//
//  AddNewPlayer.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 06/12/2024.
//
import SwiftData
import SwiftUI
import PhotosUI

struct AddNewPlayer: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var name: String = ""
    @State var playersImage: UIImage = UIImage(named: "add_new_pictures_placeholder")!
    @State var selectedNumber: Int = 0
    @State private var showImageInsertOptions: Bool = false
    @State private var notEnoughCaractersInName: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    showImageInsertOptions.toggle()
                } label: {
                    Image(uiImage: playersImage)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                        .scaledToFill()
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
                        if playersImage == UIImage(named: "add_new_pictures_placeholder") {
                            playersImage = UIImage(named: "player0")!
                        }
                        if let dataImage = playersImage.jpegData(compressionQuality: 0.8) {
                                let player = Players(singels: true, name: name, image: dataImage)
                                modelContext.insert(player)
                                do {
                                    try modelContext.save()
                                }
                                catch {
                                    print(error.localizedDescription)
                                }
                            }
                        
                        dismiss()
                    }
                    .tint(.brandPrimary)
                }
            }
        }

    }
    
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

#Preview {
    AddNewPlayer()
}
