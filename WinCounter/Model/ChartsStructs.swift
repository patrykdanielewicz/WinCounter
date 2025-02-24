//
//  ChartsStructs.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import Foundation

struct DataStructuresForChart {
    
    let label: String
    let value: Int
}

struct DataForEachPlayer: Identifiable {
    
    let id = UUID()
    
    let name: Player
    let stats: [DataStructuresForChart]

}
struct DataForEachSparring: Identifiable {
    
    let id = UUID()
    
    let sparring: Date
    let stats: [DataStructuresForChart]

}
