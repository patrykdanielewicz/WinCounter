//
//  WatchWinCounterApp.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 21/01/2025.
//
import CoreData
import SwiftUI

@main
struct WatchWinCounter_Watch_AppApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            SparringView(dataController: dataController)
                .ignoresSafeArea()
        }
    }
}
