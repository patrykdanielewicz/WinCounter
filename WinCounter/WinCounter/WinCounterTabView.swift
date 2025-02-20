//
//  ContentView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import SwiftUI

struct WinCounterTabView: View {
    

    
    var body: some View {
        TabView {
                Tab("Players", systemImage: "person.3") {
                    PlayersView()
//                    PlayersGrupsSegmentetPickerView()
                }
                Tab("Sparring", systemImage: "sportscourt.fill") {
                    SparringView()
                }
            }
        
        .tint(.brandPrimary)
    }
}

#Preview {
    WinCounterTabView()
}
