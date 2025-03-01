//
//  PlayersView-ModelView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 28/02/2025.
//
import CoreData
import SwiftUI


  
    class PlayersViewModel: ObservableObject {
        
        let dc       = DataController.shared
        @Published var players: [Player]
      
        
        init() {
            players = dc.fetchData(from: Player.self)
        }
        
        func archiveOrDeleteChecker(player: Player) -> String {
            if player.sparringsArray.isEmpty {
                return "Delete"
            }
            else {
                return "Archivize"
            }
        }
    
        
 
    }
    
    
    

