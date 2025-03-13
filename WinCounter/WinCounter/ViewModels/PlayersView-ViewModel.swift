//
//  PlayersView-ViewModel.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 28/02/2025.
//
import Combine
import CoreData
import SwiftUI

    class PlayersViewModel: ObservableObject {
        
        let dc: DataControllerProtocol
        let doubles: Bool
        
        private var cancellables = Set<AnyCancellable>()
        
        @Published private(set) var players: [Player]
      
        init(dataController: DataControllerProtocol, doubles: Bool) {
            self.dc = dataController
            self.doubles = doubles
            players = dc.fetchData(from: Player.self, predicate: nil, sortKey: "name", ascending: true)
            listeningForPlayerChanges()
        }
        
        func archiveOrDeleteChecker(player: Player) -> String {
            return player.sparringsArray.isEmpty ? "Delete" : "Archive"
        }
    
        func listeningForPlayerChanges() {
            NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange)
                .compactMap { notification in
                    (
                        notification.userInfo?[NSInsertedObjectsKey] as? Set<NSManagedObject>,
                        notification.userInfo?[NSDeletedObjectsKey] as? Set<NSManagedObject>,
                        notification.userInfo?[NSUpdatedObjectsKey] as? Set<NSManagedObject>
                    )
                }
                .sink { [weak self] insertedPlayers, deletedPlayers, updatedPlayers in
                    guard let self = self else { return }

                    let wasPlayerInserted = insertedPlayers?.contains(where: { $0 is Player }) ?? false
                    let wasPlayerDeleted = deletedPlayers?.contains(where: { $0 is Player }) ?? false
                    let wasPlayerUpdated = updatedPlayers?.contains(where: { obj in
                        guard let player = obj as? Player else { return false }
                        return player.changedValues().keys.contains(where: { ["name", "image"].contains($0) })
                    }) ?? false

                    if wasPlayerInserted || wasPlayerDeleted || wasPlayerUpdated {
                        self.players = self.dc.fetchData(from: Player.self, predicate: nil, sortKey: "name", ascending: true)
                    }
                }
                .store(in: &cancellables)
        }
    }
    
    
    

