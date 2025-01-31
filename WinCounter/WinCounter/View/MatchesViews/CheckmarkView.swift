//
//  CheckmarkView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 21/01/2025.
//

import SwiftUI

struct CheckmarkView: View {
    
    @Binding  var showCheckmark: Bool
    
    var body: some View {
        if showCheckmark {
            VStack {
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.brandPrimary)
                    .transition(.scale)
                    .animation(.easeInOut, value: showCheckmark)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.black.opacity(0.4)) // Półprzezroczyste tło
            .edgesIgnoringSafeArea(.all)
            .animation(.easeInOut, value: showCheckmark)
        }
    }
      
}

//#Preview {
//    CheckmarkView()
//}
