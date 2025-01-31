//
//  AvatarChoice.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 10/12/2024.
//

import SwiftUI

struct AvatarChoice: View {
    
    @Environment(\.dismiss) var dismiss
    
    let playersAvatars: [Image] = [Image(.player1), Image(.player2), Image(.player3), Image(.player4), Image(.player5), Image(.player6)]
    
    let avatarDescription: [Int: String] = [0: "Hipster", 1: "Profesional", 2: "Gamer", 3: "Fitnes Guy", 4: "Amator", 5: "Frat Guy" ]
    
    let colums = [GridItem(.adaptive(minimum: 150))]
    
    @Binding var selectedImage: Image
    @Binding var selectedNumber: Int
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: colums) {
                    ForEach(0..<6) { number in
                        Button {
                            selectedImage = Image("player\(number + 1)")
                            selectedNumber = number + 1
                            dismiss()
                        } label: {
                            VStack {
                                playersAvatars[number]
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                    .padding()
                                Text(avatarDescription[number]!)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                        }
                      
                    }
                    .padding()
                }
                .padding([.horizontal, .bottom])
            }

            .navigationTitle("Choice your avatar")
            .navigationBarTitleDisplayMode(.inline)
           
        }
    }
}

//#Preview {
//    AvatarChoice()
//}
