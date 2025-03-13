//
//  CircleCropperView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 13/02/2025.
//

import SwiftUI

struct CircleCropperView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: CircleCropperViewModel
    
    init(addNewPlayerViewModel: AddNewPlayerViewModel?, image: UIImage?) {
        _viewModel = StateObject(wrappedValue: CircleCropperViewModel(addNewPlayerViewModel: addNewPlayerViewModel, image: image))
    }
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .offset(viewModel.offset)
                    .scaleEffect(viewModel.scale)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                viewModel.offset = CGSize (
                                    width: viewModel.lastOffset.width + value.translation.width,
                                    height: viewModel.lastOffset.height + value.translation.height
                                )
                            }
                            .onEnded { _ in
                                viewModel.lastOffset = viewModel.offset
                            }
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                viewModel.scale = viewModel.lastScale * value
                            }
                            .onEnded { _ in
                                viewModel.lastScale = viewModel.scale
                            }
                    )
                    .clipShape(Circle())
                    .frame(width: 300, height: 300)
                    .clipped()
                Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: 300, height: 300)
                VStack {
                    Spacer()
                    Button("Done") {
                        viewModel.saveCroppedImage()
                        dismiss()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
    }
}

//#Preview {
//    CircleCropperView()
//}
