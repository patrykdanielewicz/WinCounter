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
    @StateObject var viewModel: PlayersImageInsertOptionsViewModel
    
    init(addNewPlayerViewModel: AddNewPlayerViewModel) {
        _viewModel = StateObject(wrappedValue: PlayersImageInsertOptionsViewModel(addNewPlayerViewMode: addNewPlayerViewModel))
    }
    
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
                    viewModel.showingCamera()
                } label: {
                    HStack {
                        Image(systemName: "camera")
                        Text("Take a picture")
                    }
                }
            }
            .presentationDetents([.fraction(0.2)])
            .onChange(of: viewModel.selectedImage) {
                viewModel.showingCircleCropper()
            }
            .onChange(of: viewModel.addNewPlayerViewModel?.playersImageData) {
                dismiss()
            }
            .onChange(of: viewModel.selectedCameraImage) {
                if let selectedCameraImage = viewModel.selectedCameraImage {
                    viewModel.selectedImage = selectedCameraImage
                }
            }
            .fullScreenCover(isPresented: $viewModel.showCamera) {
                ImagePickerView(playersImageInsertOptionsViewModel: viewModel)
            }
            .fullScreenCover(isPresented: $viewModel.showCircleCropper) {
                CircleCropperView(addNewPlayerViewModel: viewModel.addNewPlayerViewModel, image: viewModel.selectedImage)
            }
        }
        .tint(.brandPrimary)
    }
}

//#Preview {
//    PlayersImageInsertOptions()
//}
