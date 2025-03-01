//
//  PlayersImageInserOption-ViewModel.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 01/03/2025.
//
import PhotosUI
import SwiftUI

class PlayersImageInsertOptionsViewModel: ObservableObject {
    
    
@Published var selectedItem: PhotosPickerItem?
@Published var selectedCameraImage: UIImage?
@Published var selectedImage: UIImage?
@Published var showInsertImageOptions: Bool?
@Published var showCamera = false
@Published var showCircleCropper = false
    
    func showingCammera() {
        showCamera.toggle()
    }
    func showingCircelCropper() {
        showCircleCropper = true
    }
  
    
}
