//
//  SwiftUIView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 21/01/2025.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {

    
    @Binding var selectedImage: UIImage?
    @Environment(\.isPresented) var isPresented
    @Environment(\.dismiss) var dissmis
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
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
        guard let orginalImage = info[.originalImage] as? UIImage else { return }
        guard let compressedImage = orginalImage.jpegData(compressionQuality: 0.8) else { return }
        guard let selectedImage = UIImage(data: compressedImage) else { return }
        self.picker.selectedImage = selectedImage
        self.picker.dissmis()
        
        
    }
    
}

