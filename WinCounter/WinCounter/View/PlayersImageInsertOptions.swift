//
//  PlayersImageInsertOptions.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 20/01/2025.
//

import PhotosUI
import SwiftUI

struct PlayersImageInsertOptions: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = PlayersImageInsertOptionsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                    HStack {
                        Image(systemName: "photo")
                        Text("Choose from library")
                    }
                }
                Button {
                    viewModel.showingCammera()
                } label: {
                    HStack {
                        Image(systemName: "camera")
                        Text("Take a picture")
                    }
                }
            }
            .presentationDetents([.fraction(0.2)])
            .onChange(of: viewModel.selectedImage) {
                viewModel.showingCircelCropper()
            }
         
            .onChange(of: viewModel.selectedCameraImage) {
                if let selectedCameraImage = viewModel.selectedCameraImage {
                    viewModel.selectedImage = selectedCameraImage
        
                }
            }
            .fullScreenCover(isPresented: $viewModel.showCamera) {
                ImagePickerView(selectedImage: $viewModel.selectedCameraImage)
            }
//            .fullScreenCover(isPresented: $viewModel.showCircleCropper) {
//                CircleCropperView(image: $viewModel.selectedImage, showInsertImageOptions: $viewModel.showInsertImageOptions)
//            }
        }
        
        .tint(.brandPrimary)
    }
 
}

//#Preview {
//    PlayersImageInsertOptions()
//}
