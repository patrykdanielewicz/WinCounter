//
//  MatchEditingView-ViewModel.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 11/03/2025.
//

import Foundation

class MatchEditingViewModel: ObservableObject {
    
    let dc: DataControllerProtocol
    let match: Match
    
    init(dataController: DataControllerProtocol, match: Match) {
        self.dc = dataController
        self.match = match
    }
    
    
    
}
