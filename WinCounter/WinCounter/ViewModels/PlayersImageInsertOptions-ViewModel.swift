//
//  PlayersImageInserOption-ViewModel.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 01/03/2025.
//
import PhotosUI
import SwiftUI

class PlayersImageInsertOptionsViewModel: ObservableObject {
    
 weak var addNewPlayerViewModel: AddNewPlayerViewModel?
    
@Published var selectedItem: PhotosPickerItem? {
    didSet { convertSelectedItemToImage()}
}
@Published var selectedCameraImage: UIImage?
@Published var selectedImage: UIImage?
@Published var showInsertImageOptions: Bool?
@Published var showCamera = false
@Published var showCircleCropper = false
@Published var selectedImagaData: Data?
    
    init(addNewPlayerViewMode: AddNewPlayerViewModel) {
        self.addNewPlayerViewModel = addNewPlayerViewMode
    }
    
    func showingCamera() {
        showCamera.toggle()
    }
    func showingCircleCropper() {
        showCircleCropper = true
    }
  
    private func convertSelectedItemToImage() {
        guard let selectedItem = selectedItem else { return }

        selectedItem.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data = data, let uiImage = UIImage(data: data) {
                        self.selectedImage = uiImage
                    }
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
}
