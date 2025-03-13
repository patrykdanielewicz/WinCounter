//
//  WinCounterApp.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import SwiftData
import SwiftUI

@main

struct WinCounterApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            WinCounterTabView()
                .environmentObject(dataController)
        }
    }
}
