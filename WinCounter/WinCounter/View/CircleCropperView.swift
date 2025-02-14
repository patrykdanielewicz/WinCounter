//
//  CircleCropperView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 13/02/2025.
//

import SwiftUI

struct CircleCropperView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var image: UIImage
    
    @State private var offset: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    @State private var lastOffset: CGSize = .zero
    @State private var lastScale: CGFloat = 1.0
    @Binding var showInsertImageOptions: Bool
    
    
    
    var body: some View {
        ZStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .offset(offset)
                    .scaleEffect(scale)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                offset = CGSize (
                                    width: lastOffset.width + value.translation.width,
                                    height: lastOffset.height + value.translation.height
                                )
                            }
                            .onEnded { _ in
                                lastOffset = offset
                            }
                )
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = lastScale * value
                            }
                            .onEnded { _ in
                                lastScale = scale
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
                               saveCroppedImage()
    
                           }
                           .padding()
                           .background(Color.blue)
                           .foregroundColor(.white)
                           .cornerRadius(8)
                       }
        }
    }
    
    func saveCroppedImage() {
          let originalImage = image 
          let cropSize = CGSize(width: 300, height: 300)
          if let croppedImage = createCircularCroppedImage(from: originalImage, offset: offset, scale: scale, cropSize: cropSize) {
              image = croppedImage
          }
        showInsertImageOptions = false
          dismiss()
      }
    
    func createCircularCroppedImage(from originalImage: UIImage, offset: CGSize, scale: CGFloat, cropSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: cropSize)
        return renderer.image { context in
            let rect = CGRect(origin: .zero, size: cropSize)
            UIBezierPath(ovalIn: rect).addClip()
            let initialScale = max(cropSize.width / originalImage.size.width,
                                   cropSize.height / originalImage.size.height)
            let effectiveWidth = originalImage.size.width * initialScale
            let effectiveHeight = originalImage.size.height * initialScale
            let center = CGPoint(x: cropSize.width / 2, y: cropSize.height / 2)
            let centeredOrigin = CGPoint(x: (cropSize.width - effectiveWidth) / 2,
                                         y: (cropSize.height - effectiveHeight) / 2)
            let offsetOrigin = CGPoint(x: centeredOrigin.x + offset.width,
                                       y: centeredOrigin.y + offset.height)
            let finalOriginX = center.x + (offsetOrigin.x - center.x) * scale
            let finalOriginY = center.y + (offsetOrigin.y - center.y) * scale
            let finalWidth = effectiveWidth * scale
            let finalHeight = effectiveHeight * scale
            
            let drawRect = CGRect(x: finalOriginX, y: finalOriginY, width: finalWidth, height: finalHeight)
            originalImage.draw(in: drawRect)
        }
    }
    
    
}

//#Preview {
//    CircleCropperView()
//}
