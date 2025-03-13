//
//  PlayerImageView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 10/03/2025.
//

import SwiftUI

struct PlayerImageView: View {
    let image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
    }
}

