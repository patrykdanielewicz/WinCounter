//
//  SparringViews-ViewModel.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 12/03/2025.
//
import Combine
import CoreData
import Foundation

class SparringViewViewModel: ObservableObject {
    
    let dc: DataControllerProtocol
    
    @Published private(set) var sparrings: [Sparring]
    
    private var cancellable = Set<AnyCancellable>()
    
    init(dataController: DataControllerProtocol) {
        self.dc = dataController
        self.sparrings = dc.fetchData(from: Sparring.self, predicate: nil, sortKey: "date", ascending: false)
        listeningForChanges()
    }
    
    func listeningForChanges() {
        NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange)
            .compactMap { notification in
                (notification.userInfo?[NSInsertedObjectsKey] as? Set<NSManagedObject>,
                 notification.userInfo?[NSDeletedObjectsKey] as? Set<NSManagedObject>)
            }
            .sink { [weak self] insertedObjects, deletedObject in
                guard let self = self else { return }
                let wasSparringInserted: Bool = insertedObjects?.contains(where: { $0 is Sparring }) ?? false
                let wasSparringDeleted: Bool = deletedObject?.contains(where: { $0 is Sparring }) ?? false
                
                if wasSparringInserted || wasSparringDeleted {
                    sparrings = dc.fetchData(from: Sparring.self, predicate: nil, sortKey: "date", ascending: false)
            
                }
            }
            .store(in: &cancellable)
    }
}
