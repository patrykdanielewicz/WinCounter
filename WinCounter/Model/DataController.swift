//
//  DataController.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 17/02/2025.
//
import CloudKit
import CoreData
import SwiftUI

class DataController: ObservableObject {
    
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
    
    func fetchData<T: NSManagedObject>(from entitiesType: T.Type, predicate: NSPredicate? = nil) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entitiesType))
        request.predicate = predicate
        
        do {
            return try container.viewContext.fetch(request)
        }
        catch {
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
    
    func addingPlayer(name: String, image: Data? ) {
        let player = Player(context: container.viewContext)
        player.doubels = false
        player.id = UUID()
        player.name = name
        player.image = image
        
    }
    
}
