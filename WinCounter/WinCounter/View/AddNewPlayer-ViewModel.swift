//
//  AddNewPlayerModelView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 01/03/2025.
//
import PhotosUI
import Combine
import SwiftUI

class AddNewPlayerViewModel: ObservableObject {
    
    let dc = DataController.shared
    let ImagePickerViewModel = PlayersImageInsertOptionsViewModel()
    var cancellables = Set<AnyCancellable>()
    
    @Published var name: String = ""
    @Published var selectedNumber: Int = 0
    @Published var showImageInsertOptions: Bool = false
    @Published var notEnoughCaractersInName: Bool = false
    @Published var playersImageData: Data?
               var playerUIImage: UIImage? {
                    guard let data = playersImageData else {return nil}
                    return UIImage(data: data)
               }
    
    func showingImageInsertOptions() {
        showImageInsertOptions.toggle()
    }
    
    func savePlayer() {
        if name.count < 2 {
            notEnoughCaractersInName = true
            return
        }
        dc.addingPlayer(name: name, image: playersImageData)
        dc.saveData()
    }
    
    func converPPIToUIImage(selectetItem: PhotosPickerItem) {
        Task {
            do {
                if let data = try await selectetItem.loadTransferable(type: Data.self) {
                    playersImageData = data
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func observeImagePicker() {
        ImagePickerViewModel.$selectedItem
            .sink { newValue in
                guard let selectedItem = newValue else { return }
                self.converPPIToUIImage(selectetItem: selectedItem)
            }
            .store(in: &cancellables)
    }
    
}
