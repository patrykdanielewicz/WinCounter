//
//  AddNewTeam.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 20/01/2025.
//

import SwiftData
import SwiftUI
import PhotosUI

struct AddNewTeam: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var name: String = ""
    @State private var players1name = ""
    @State private var players2name = ""
    
    
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
                        .frame(width: 200, height: 200)
                        .scaledToFill()
                }
                
                Form {
                    TextField("Enter Team name", text: $name)
                    TextField("Enter name of player one", text: $players1name)
                    TextField("Enter name of player two", text: $players2name)
                }
                Spacer()
            }
            .alert("Name is too short", isPresented: $notEnoughCaractersInName) {
                Button("OK") { }
            } message: {
                Text("The name must have at least two characters.")
            }
            .sheet(isPresented: $showImageInsertOptions) {
                PlayersImageInsertOptions(selectedImage: $playersImage, showInsertImageOptions: $showImageInsertOptions)
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
                        if let dataImage = playersImage.pngData() {
                            let player = Players(singels: false, doublesPlayerNr1: players1name, doublesPlayerNr2: players2name, name: name, image: dataImage)
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
