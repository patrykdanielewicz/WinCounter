//
//  addNewPlayerViewModelView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 01/03/2025.
//
import PhotosUI
import SwiftUI

class AddNewPlayerViewModel: ObservableObject {
    
    let dc: DataControllerProtocol
    let doubles : Bool
    
    @Published var name: String = ""
    @Published var player1Name: String = ""
    @Published var player2Name: String = ""
    @Published var showImageInsertOptions: Bool = false
    @Published var notEnoughCharactersInName: Bool = false
    @Published private(set) var playersImageData: Data?
               private(set) var playersID: UUID?
                            var playerUIImage: UIImage? {
                                guard let data = playersImageData else {return nil}
                                return UIImage(data: data)
                                }
    
    init(dataController: DataControllerProtocol, doubles: Bool) {
        self.dc = dataController
        self.doubles = doubles
    }
    
    init(dataController: DataControllerProtocol, name: String, playersImageData: Data?, playersID: UUID?, doubles: Bool, players1name: String, players2name: String) {
        self.dc = dataController
        self.name = name
        self.playersImageData = playersImageData
        self.playersID = playersID
        self.doubles = doubles
        self.player1Name = players1name
        self.player2Name = players2name
    }
    
     func updatePlayersImageData(_ data: Data) {
        playersImageData = data
    }
    
    func showingImageInsertOptions() {
        showImageInsertOptions.toggle()
    }
    
    func savePlayer() {
        if name.count < 2 {
            notEnoughCharactersInName = true
            return
        }
        if let id = playersID {
            dc.updatePlayer(id: id, newName: name, newImage: playersImageData)
        } else {
            dc.addingPlayer(name: name, image: playersImageData, doubles: doubles, doublesPlayerNr1: player1Name, doublesPlayerNr2: player2Name )
        }
        dc.saveData()
    }
    
    func singleOrDoubles() {
        if doubles {
            
        }
    }
}
