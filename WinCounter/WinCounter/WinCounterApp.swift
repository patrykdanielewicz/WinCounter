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

    var body: some Scene {
        WindowGroup {
            WinCounterTabView()
                .modelContainer(for: [Players.self, Sparring.self])
        }
    }
}
