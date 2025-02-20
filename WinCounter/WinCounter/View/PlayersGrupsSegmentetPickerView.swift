//
//  PlayersGrupsSegmentetPickerView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//
//
//import SwiftUI
//
//
//struct PlayersGrupsSegmentetPickerView: View {
//    @State private var selectedTab: String = "Singels" // Aktualnie wybrana zakładka
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 0) {
//                
//                    HStack {
//                        TabButton(title: "Singels", isSelected: selectedTab == "Singels") {
//                            selectedTab = "Singels"
//                        }
//                        TabButton(title: "Doubles", isSelected: selectedTab == "Doubles") {
//                            selectedTab = "Doubles"
//                        }
//                    }
//                .frame(height: 44)
//         
//
//                if selectedTab == "Singels" {
//                    PlayersView()
//                } else {
//                    DoubleView()
//                }
//                
//                Spacer()
//            }
//           
//        }
//    }
//}
//
//
//struct TabButton: View {
//    let title: String
//    let isSelected: Bool
//    let action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            VStack {
//                Text(title)
//                    .font(.headline)
//                    .foregroundColor(isSelected ? .accentColor : .gray)
//               
//                    if isSelected {
//                        Rectangle()
//                            .fill(Color.accentColor)
//                            .frame(height: 2)
//                     
//                    } else {
//                        Rectangle()
//                            .fill(Color.clear)
//                
//                            .frame(height: 2)
//       
//                    }
//                
//            }
//            
//            .frame(maxWidth: .infinity)
//        }
//    }
//}


//#Preview {
//    PlayersGrupsSegmentetPickerView()
//}
