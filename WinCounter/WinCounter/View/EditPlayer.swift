//
//  AddNewPlayer.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 06/12/2024.
//
import CoreData
import SwiftUI
import PhotosUI

struct EditPlayer: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc

    @ObservedObject  var player: Player
    @State private var selectedImage = UIImage(named: "player0")
    
    
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
                    TextField("Enter Player's name", text: Binding(
                        get: { player.name ?? "" },
                        set: { player.name = $0 }))
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
                        if player.wrappedName.count < 2 {
                            notEnoughCaractersInName = true
                            return
                        }
                   
                        if let dataImage = unwrappingOptionalDataImage(image: player.image).jpegData(compressionQuality: 0.6) {
                                do {
                                    try moc.save()
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
        if let selectedImage = selectedImage {
            if selectedImage != UIImage(named: "player0") {
                if let data = selectedImage.pngData() {
                    player.image = data
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

//#Preview {
//    AddNewPlayer()
//}
