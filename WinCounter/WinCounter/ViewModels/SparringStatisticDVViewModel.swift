//
//  SparringStatisticDVViewModel.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 12/03/2025.
//

import Foundation

class SparringStatisticDVViewModel: ObservableObject {
    
    let dc: DataControllerProtocol
    let date: Date
    let player: Player
    let sparrings: [Sparring]
    let playersMatches: Int
    let wins: Int
    let losses: Int
    let mostFrequentOpponent: String
    let mostDefeatedOpponents: [Player]
    let mostDefeatingOpponents:[Player]
    let dataForCharts: [DataForEachPlayer]
    
    init(dataController: DataControllerProtocol, player: Player, date: Date) {
        self.dc = dataController
        self.player = player
        self.date = date
        if let playerID = player.id {
        self.sparrings = dc.fetchData(from: Sparring.self, predicate: NSPredicate(format: "ANY players.id = %@", playerID as CVarArg ), sortKey: "date", ascending: true)
        }
        else {
            self.sparrings = []
        }
        self.playersMatches = DataForSparringsDetailView.playersMatchesInSparring(sparrings: sparrings, player: player)
        self.wins = DataForSparringsDetailView.playersWonMatches(sparrings: sparrings, player: player)
        self.losses = DataForSparringsDetailView.playersLostMatches(sparrings: sparrings, player: player)
        self.mostFrequentOpponent = DataForSparringsDetailView.mostFrequentOpponentForPlayer(sparrings: sparrings, player: player)
        self.mostDefeatedOpponents = DataForSparringsDetailView.mostWinsAgainstOpponent(opponentsStats: DataForSparringsDetailView.playersEachOpponentsStats(sparrings: sparrings, player: player))
        self.mostDefeatingOpponents = DataForSparringsDetailView.mostLossesAgainstOppoent(opponentsStats: DataForSparringsDetailView.playersEachOpponentsStats(sparrings: sparrings, player: player))
        self.dataForCharts = DataForChartsPreparation.dataForEachOpponentsPerSparring(opponentsWinLossesDictionary: DataForSparringsDetailView.playersEachOpponentsStats(sparrings: sparrings, player: player))
    }
    
    
}
