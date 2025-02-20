//
//  AddNewTeam.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 20/01/2025.
//
//
import CoreData
import SwiftUI
import PhotosUI

struct AddNewTeam: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc

    @State private var name: String = ""
    @State private var players1name = ""
    @State private var players2name = ""
    
    
    @State var teamImage: UIImage? = UIImage(named: "addPicture")
    @State var selectedNumber: Int = 0
    @State private var showImageInsertOptions: Bool = false
    @State private var notEnoughCaractersInName: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    showImageInsertOptions.toggle()
                } label: {
                    if let teamImage = teamImage {
                        Image(uiImage: teamImage)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                            .scaledToFill()
                    }
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
                PlayersImageInsertOptions(selectedImage: $teamImage, showInsertImageOptions: $showImageInsertOptions)
            }
            .navigationTitle("Add new Team")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", systemImage: "person.fill.checkmark") {
                        
                        if name.count < 2 {
                            notEnoughCaractersInName = true
                            return
                        }
                        
                        if teamImage == UIImage(named: "addPicture") {
                            teamImage = UIImage(named: "player0")!
                        }
                        if let teamImage = teamImage {
                            if let dataImage = teamImage.jpegData(compressionQuality: 0.6) {
                                let team = Player(context: moc)
                                team.doubels = true
                                team.doublesPlayerNr1 = players1name
                                team.doublesPlayerNr2 = players2name
                                team.image = dataImage
                            
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
    
    func converToUIIImage(selectetItem: PhotosPickerItem) {
        
        Task {
            do {
                if let data = try await selectetItem.loadTransferable(type: Data.self) {
                    if let  uiImage = UIImage(data: data) {
                        teamImage = uiImage

                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }

}
//
//#Preview {
//    AddNewPlayer()
//}
