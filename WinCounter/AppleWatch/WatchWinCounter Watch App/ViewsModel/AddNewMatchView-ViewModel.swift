//
//  AddNewMatchView-ViewModel.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 12/03/2025.
//

import Foundation

class AddNewMatchViewModel:ObservableObject {
    
    let dc: DataControllerProtocol
    let sparring: Sparring
    
    @Published var selectedPlayers = [Player]()
    @Published var isTwoPlayersOrTeamSelected = false
    @Published  var startMatch = false
    @Published  var endMatches = false
    
    init(dataController: DataControllerProtocol, sparring: Sparring) {
        self.dc = dataController
        self.sparring = sparring
    }
    
    func addingPlayersforMatch(for player: Player) {
        if let index = selectedPlayers.firstIndex(of: player) {
            selectedPlayers.remove(at: index)
        } else {
            selectedPlayers.append(player)
        }
    }
    
    func playersToChoose() -> [Player] {
        return sparring.wrappedPlayers
    }
    
}
