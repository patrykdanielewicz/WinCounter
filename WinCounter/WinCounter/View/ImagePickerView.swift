//
//  ImagePickerView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 21/01/2025.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {

    var playersImageInsertOptionsViewModel: PlayersImageInsertOptionsViewModel
    
    @Environment(\.dismiss) var dismiss
    
    init(playersImageInsertOptionsViewModel: PlayersImageInsertOptionsViewModel) {
        self.playersImageInsertOptionsViewModel = playersImageInsertOptionsViewModel
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
    
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[.originalImage] as? UIImage else { return }
        guard let compressedImage = originalImage.jpegData(compressionQuality: 0.6) else { return }
        guard let selectedImage = UIImage(data: compressedImage) else { return }
        self.picker.playersImageInsertOptionsViewModel.selectedImage = selectedImage
        self.picker.dismiss()
        
        
    }
    
}

