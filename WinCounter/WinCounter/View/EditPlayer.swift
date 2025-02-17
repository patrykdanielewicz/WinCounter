//
//  AddNewPlayer.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 06/12/2024.
//
import SwiftData
import SwiftUI
import PhotosUI

struct EditPlayer: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State  var player: Players
    @State private var selectedImage = UIImage(named: "player0")!
    
    @State var selectedNumber: Int = 0
    @State private var showImageInsertOptions: Bool = false
    @State private var notEnoughCaractersInName: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    showImageInsertOptions.toggle()
                } label: {
                        Image(uiImage: unwrappingOptionalDataImage(image: player.image))
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                            .scaledToFill()
                    
                }
                
                Form {
                    TextField("Enter Player's name", text: $player.name)
                }
                Spacer()
            }
            
            
            .sheet(isPresented: $showImageInsertOptions) {
                PlayersImageInsertOptions(selectedImage: $selectedImage, showInsertImageOptions: $showImageInsertOptions)
            }
            .alert("Name is too short", isPresented: $notEnoughCaractersInName) {
                Button("OK") { }
            } message: {
                Text("The name must have at least two characters.")
            }
            .onChange(of: selectedImage) {
                changeProfilePictures()
            }
            .navigationTitle("Add new Player")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", systemImage: "person.fill.checkmark") {
                        if player.name.count < 2 {
                            notEnoughCaractersInName = true
                            return
                        }
                   
                        if let dataImage = unwrappingOptionalDataImage(image: player.image).jpegData(compressionQuality: 0.6) {
                            let player = Players(singels: true, name: player.name, image: dataImage)
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

    func changeProfilePictures() {
        if selectedImage != UIImage(named: "player0") {
            if let data = selectedImage.pngData() {
                player.image = data
                modelContext.insert(player)
                do {
                    try modelContext.save()
                }
                catch {
                    print(error.localizedDescription)
                }
                
            }
            }
        
    }
    func unwrappingOptionalDataImage(image: Data?) -> UIImage {
        if let dataImage = image {
            if let uiImage = UIImage(data: dataImage) {
                return uiImage
            }
            return UIImage(named: "player0")!
        }
        return UIImage(named: "player0")!
    }
    

}

#Preview {
    AddNewPlayer()
}
