//
//  DataController.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 17/02/2025.
//
import CloudKit
import CoreData
import SwiftUI

class DataController: ObservableObject, DataControllerProtocol {
    
    static let shared = DataController()
    
        let container = NSPersistentCloudKitContainer(name: "WinCounterModel")
    
    init() {
        let storeDescription = container.persistentStoreDescriptions.first
        storeDescription?.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        storeDescription?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription) \(error) ")
            }

            self.container.viewContext.automaticallyMergesChangesFromParent = true
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            
        }
       
    }
    
    func fetchData<T: NSManagedObject>(from entitiesType: T.Type, predicate: NSPredicate? = nil, sortKey: String? = nil, ascending: Bool? = true
    ) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entitiesType))
        request.predicate = predicate
        print("myFunction() została wywołana!")
        if let sortKey = sortKey, let ascending = ascending {
            request.sortDescriptors = [NSSortDescriptor(key: sortKey, ascending: ascending)]
        }

        do {
            return try container.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func saveData() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteData<T: NSManagedObject>(_ object: T) {
        container.viewContext.delete(object)
        saveData()
    }
    
    func decodeImage(for player: Player) -> UIImage {
        if let image = player.image {
            if let uiImage = UIImage(data: image) {
                return uiImage
            }
        }
        return UIImage(systemName: "person.crop.rectangle.fill") ?? UIImage()
    }
    
    func addingPlayer(name: String, image: Data?, doubles: Bool, doublesPlayerNr1: String, doublesPlayerNr2: String) {
        let player = Player(context: container.viewContext)
        if doubles {
            player.doubles = true
            player.doublesPlayerNr1 = doublesPlayerNr1
            player.doublesPlayerNr2 = doublesPlayerNr2
            
        }
        else {
            player.doubles = false
        }
        player.id = UUID()
        player.name = name
        player.image = image

    }
    
    func updatePlayer(id: UUID, newName: String?, newImage: Data?) {
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let players = try container.viewContext.fetch(fetchRequest)
            if let player = players.first {
                if let newName = newName {
                    player.name = newName
                }
                if let newImage = newImage {
                    player.image = newImage
                }
            } else {
                print("Player with id \(id) not found")
            }
        } catch {
            print("Failed to update player: \(error.localizedDescription)")
        }
    }
    
    func addingSparring(date: Date, players: [Player]) {
        let sparring = Sparring(context: container.viewContext)
        sparring.id = UUID()
        sparring.isSparringEnded = false
        sparring.date = date
        for player in players {
            sparring.addToPlayers(player)
        }
        saveData()
    }
    
    func addingMatch(sparring: Sparring, matchNumber: Int) -> Match {
        let match = Match(context: container.viewContext)
        match.id = UUID()
        match.sparring = sparring
        match.matchNumber = Int16(matchNumber)
        saveData()
        return match
    }
    
    func addingMatchPoint(player: Player, match: Match, point: Int) -> MatchPoints {
        let matchPoint = MatchPoints(context: container.viewContext)
        matchPoint.id = UUID()
        matchPoint.player = player
        matchPoint.match = match
        matchPoint.points = Int16(point)
        saveData()
        return matchPoint
    }
    
    func addingMatchWinner(match: Match, winningPlayer: Player, points: Int) -> MatchWinners {
        let winner = MatchWinners(context: container.viewContext)
        winner.player = winningPlayer
        winner.match = match
        winner.points = Int16(points)
        return winner
    }
    
//    func deleteAllData(context: NSManagedObjectContext) {
//        guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
//        
//        for entity in persistentStoreCoordinator.managedObjectModel.entities {
//            deleteAllObjects(of: entity.name ?? "", context: context)
//        }
//    }
//
//    func deleteAllObjects(of entityName: String, context: NSManagedObjectContext) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try context.execute(deleteRequest)
//            try context.save()
//        } catch {
//            print("❌ Błąd podczas usuwania danych dla \(entityName): \(error)")
//        }
//    }
    
   
    
}
