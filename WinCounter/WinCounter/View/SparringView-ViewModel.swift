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
    
    let dc = DataController.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var sparrings:                 [Sparring]
    @Published var isAddNewSparringPresented: Bool = false
    @Published var isNewSparringAdded:        Bool = false
    
    init() {
        self.sparrings = dc.fetchData(from: Sparring.self)
    }
    
    func setupNotificationListener() {
        NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave).compactMap { notification  in
            notification.userInfo?[NSInsertedObjectsKey] as? Set<NSManagedObject>
        }.sink { [weak self] insertedSparring in
            if insertedSparring.contains(where: {$0 is Sparring}) {
                self?.isNewSparringAdded = true
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
