//
//  AddNewSparringView-ViewModel.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 12/03/2025.
//


import Foundation

class AddNewSparringViewModel: ObservableObject {
    
    let dc: DataControllerProtocol
    
    @Published private(set) var players: [Player]
    @Published var sparringDate: Date = Date()
    @Published private(set) var selectedPlayers: [Player] = []
    @Published var lessThenTwoPlayers = false
    @Published private(set) var isNewSparringAdded: Bool = false
    
    
    init(dataController: DataControllerProtocol) {
        self.dc = dataController
        self.players = dc.fetchData(from: Player.self, predicate: nil, sortKey: "name", ascending: true)
    }

    func addingPlayersforSparring(for player: Player) {
        if let index = selectedPlayers.firstIndex(of: player) {
            selectedPlayers.remove(at: index)
        } else {
            selectedPlayers.append(player)
        }
    }
    
    func AreEnoughPlayers() -> Bool {
        if selectedPlayers.count >= 2 {
            lessThenTwoPlayers = false
            return true
        } else {
            lessThenTwoPlayers = true
            return false
        }
    }
    
    func saveSparring() {
        dc.addingSparring(date: sparringDate, players: selectedPlayers)
    }
    
}
