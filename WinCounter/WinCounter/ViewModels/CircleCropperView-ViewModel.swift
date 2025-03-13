//
//  CircleCropperView-VIewModel.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 02/03/2025.
//

import SwiftUI

class CircleCropperViewModel: ObservableObject {
    
    private weak var addNewPlayerViewModel: AddNewPlayerViewModel?
    
    @Published private(set) var image: UIImage?
    @Published var offset: CGSize = .zero
    @Published var scale: CGFloat = 1.0
    @Published var lastOffset: CGSize = .zero
    @Published var lastScale: CGFloat = 1.0
    
    init(addNewPlayerViewModel: AddNewPlayerViewModel?, image: UIImage?) {
        self.addNewPlayerViewModel = addNewPlayerViewModel
        self.image = image
    }
    
    func saveCroppedImage() {
        if let wrappedimage = image {
            let originalImage = wrappedimage
            let cropSize = CGSize(width: 300, height: 300)
            if let croppedImage = createCircularCroppedImage(from: originalImage, offset: offset, scale: scale, cropSize: cropSize) {
                if let data = croppedImage.jpegData(compressionQuality: 0.6) {
                    addNewPlayerViewModel?.updatePlayersImageData(data)
                }
            }
        }
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
