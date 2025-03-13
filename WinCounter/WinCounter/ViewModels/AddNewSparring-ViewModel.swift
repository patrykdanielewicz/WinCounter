//
//  AddNewSparring-ViewModel.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 10/03/2025.
//

import Foundation

class AddNewSparringViewModel: ObservableObject {
    
    let dc: DataControllerProtocol
    private(set) var sparring: Sparring?
    
    @Published private(set) var players: [Player]
    
    @Published  var sparringDate: Date = Date()
    @Published  var selectedPlayers: [Player] = []
    
    @Published  var isAddNewPlayerButtonPresed = false
    @Published  var isAddNewTeamButtonPresed = false
    @Published  var lessThenTwoPlayers = false
    
    init(dataController: DataControllerProtocol) {
        self.dc = dataController
        players = dc.fetchData(from: Player.self, predicate: nil, sortKey: "name", ascending: true)
    }
    
    init(dataController: DataControllerProtocol, sparring: Sparring) {
        self.dc = dataController
        self.sparring = sparring
        self.selectedPlayers = sparring.wrappedPlayers
        self.sparringDate = sparring.wrappedDate
        players = dc.fetchData(from: Player.self, predicate: nil, sortKey: "name", ascending: true)
    }
    
    func pressingAddNewPlayerButton() {
        isAddNewPlayerButtonPresed.toggle()
    }
    
    func pressingAddNewTeamButton() {
        isAddNewTeamButtonPresed.toggle()
    }
    
    func addingPlayersforSparring(for player: Player) {
        if let index = selectedPlayers.firstIndex(of: player) {
            selectedPlayers.remove(at: index)
        } else {
            selectedPlayers.append(player)
        }
    }
        
    func areEnoughPlayers() -> Bool {
        if selectedPlayers.count < 2 {
            lessThenTwoPlayers = true
            return false
        }
        else {
            return true
        }
    }
        
    func saveSparring() {
        dc.addingSparring(date: sparringDate, players: selectedPlayers)
        }
    }

