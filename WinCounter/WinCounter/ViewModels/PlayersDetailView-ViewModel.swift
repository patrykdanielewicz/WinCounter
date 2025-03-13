//
//  PlayersDetailView-ViewModel.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 03/03/2025.
//
import CoreData
import Combine
import Foundation


class PlayersDetailViewModel: ObservableObject {
    
    let dc: DataControllerProtocol
    let doubles: Bool
    
    @Published private(set) var player: Player
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(dataController: DataControllerProtocol, player: Player, doubles: Bool) {
        self.dc = dataController
        self.player = player
        self.doubles = doubles
        if let id = player.id {
            listeningForChanges(in: id)
        }
    }
    
    func listeningForChanges(in playerID: UUID) {
        NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange)
            .map { notification -> Set<NSManagedObject> in
                return notification.userInfo?[NSUpdatedObjectsKey] as? Set<NSManagedObject> ?? Set()
            }
            .sink { [weak self] updatedPlayers in
                guard let self = self else { return }
                let wasThisPlayerUpdated = updatedPlayers.contains(where: { obj in
                    guard let player = obj as? Player else { return false }
                    guard player.id == playerID else { return false }
                    
                    return player.changedValues().keys.contains { ["name", "image"].contains($0) }
                }) 

                if wasThisPlayerUpdated {
                    let players = dc.fetchData(from: Player.self, predicate: NSPredicate(format: "id == %@", playerID as CVarArg), sortKey: nil, ascending: true)
                    player = players.first ?? player
                }
            }
            .store(in: &cancellables)
    }
}

