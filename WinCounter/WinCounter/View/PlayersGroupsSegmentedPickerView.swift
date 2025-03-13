//
//  PlayersGroupsSegmentedPickerView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import SwiftUI


struct PlayersGroupsSegmentedPickerView: View {
    
    @EnvironmentObject var dataController: DataController
    @State private var selectedTab: String = "Singles"

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    TabButton(title: "Singles", isSelected: selectedTab == "Singles") {
                        selectedTab = "Singles"
                    }
                    TabButton(title: "Doubles", isSelected: selectedTab == "Doubles") {
                        selectedTab = "Doubles"
                    }
                }
                .frame(height: 44)
         
                if selectedTab == "Singles" {
                    PlayersView(dataController: dataController, doubles: false)
                } else {
                    PlayersView(dataController: dataController, doubles: true)
                }
                Spacer()
            }
        }
    }
}


struct TabButton: View {
    
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(isSelected ? .accentColor : .gray)
                
                if isSelected {
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(height: 2)
                } else {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 2)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

