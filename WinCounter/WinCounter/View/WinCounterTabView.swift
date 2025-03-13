//
//  ContentView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import SwiftUI

struct WinCounterTabView: View {
    
    @EnvironmentObject private var dataController: DataController
    
    var body: some View {
        TabView {
            Tab("Players", systemImage: "person.3") {
                PlayersGroupsSegmentedPickerView()
            }
            Tab("Sparring", systemImage: "sportscourt.fill") {
                SparringView(dataController: dataController)
            }
        }
        .tint(.brandPrimary)
    }
}

