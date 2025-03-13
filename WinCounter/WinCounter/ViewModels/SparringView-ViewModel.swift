//
//  SparringView-ViewModel.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 01/03/2025.
//
import Combine
import CoreData
import Foundation

class SparringViewModel: ObservableObject {
    
    let dc: DataControllerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var sparrings: [Sparring]
    @Published var isAddNewSparringPresented: Bool = false
    @Published var isNewSparringAdded:        Bool = false
    
    init(dataController: DataControllerProtocol) {
        self.dc = dataController
        self.sparrings = dc.fetchData(from: Sparring.self, predicate: nil, sortKey: nil, ascending: true)
        setupNotificationListener()
    }
    
    func setupNotificationListener() {
        NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange)
            .compactMap { notification  in
           (notification.userInfo?[NSInsertedObjectsKey] as? Set<NSManagedObject>,
            notification.userInfo?[NSDeletedObjectsKey] as? Set<NSManagedObject> )
        }
        .sink { [weak self] insertedSparring, deletedSparring in
            guard let self = self else { return }
            
            let wasSparringInserted: Bool = insertedSparring?.contains(where: { $0 is Sparring }) ?? false
            let wasSparringDeleted:  Bool = deletedSparring?.contains(where: { $0 is Sparring }) ?? false
            
            if wasSparringInserted, let inserted = insertedSparring?.compactMap({ $0 as? Sparring }) {
                self.sparrings.append(contentsOf: inserted)
                self.isNewSparringAdded = true
            }
            
            if wasSparringDeleted, let deleted = deletedSparring?.compactMap({ $0 as? Sparring }) {
                self.sparrings.removeAll { deleted.contains($0) }
            }
            
        }
        .store(in: &cancellables)
    }
    
    func latestSparring() -> Sparring {
        return sparrings.first ?? Sparring()
    }
    
    func addNewSparring() {
        isAddNewSparringPresented.toggle()
    }
    
}
