//
//  PlayersImageInsertOptions.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 20/01/2025.
//

import PhotosUI
import SwiftUI


struct LazyView<Content: View>: View {
    private let build: () -> Content

    init(_ build: @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}

struct PlayersImageInsertOptions: View {
    
    @Environment(\.dismiss) var dismiss

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedCameraImage: UIImage?
    @Binding  var selectedImage: UIImage
    @Binding var showInsertImageOptions: Bool
    @State var showCamera = false
    @State var showCircleCropper = false
   
    
    
    var body: some View {
        NavigationStack {
            List {
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    HStack {
                        Image(systemName: "photo")
                        Text("Choose from library")
                    }
                }
                Button {
                    showCamera.toggle()
                } label: {
                    HStack {
                        Image(systemName: "camera")
                        Text("Take a picture")
                    }
                }
            }

            
         
            .presentationDetents([.fraction(0.2)])
            .onChange(of: selectedImage) {
                showCircleCropper = true
            }
            .onChange(of: selectedItem) {
                if let selectedItemToData = selectedItem {
                    converToUIIImage(selectetItem: selectedItemToData)
                }
            }
            .onChange(of: selectedCameraImage) {
                if let selectedCameraImage = selectedCameraImage {
                    selectedImage = selectedCameraImage
        
                }
            }
            .fullScreenCover(isPresented: $showCamera) {
                ImagePickerView(selectedImage: $selectedCameraImage)
            }
            .fullScreenCover(isPresented: $showCircleCropper) {
                CircleCropperView(image: $selectedImage, showInsertImageOptions: $showInsertImageOptions)
            }
        }
        
        .tint(.brandPrimary)
    }
    func converToUIIImage(selectetItem: PhotosPickerItem) {
        
        Task {
            do {
                if let data = try await selectetItem.loadTransferable(type: Data.self) {
                    if let  uiImage = UIImage(data: data) {
                        await MainActor.run {
                            selectedImage = uiImage
                            
                        }
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

//#Preview {
//    PlayersImageInsertOptions()
//}
