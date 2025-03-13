//
//  StatisticViews-ViewModel.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 12/03/2025.
//

import Foundation

class StatisticViewsViewModel: ObservableObject {
    
    let dc: DataControllerProtocol
    
    @Published private(set) var player: Player
    @Published private(set) var dataChartForTotalStatistic: [DataStructuresForChart]
    @Published private(set) var dataForEachPlayersCharts: [DataForEachPlayer]
    @Published private(set) var dataChartForEachSparring: [DataForEachSparring]
    
    init(dc: DataControllerProtocol, player: Player) {
        self.dc = dc
        self.player = player
        self.dataChartForTotalStatistic = DataForChartsPreparation.dataForTotalStatisticPreparation(player: player)
        self.dataForEachPlayersCharts = DataForChartsPreparation.dataForEachPlayersChartsPreparation(player: player)
        self.dataChartForEachSparring = DataForChartsPreparation.dataForSparringsStatistic(player: player)
    }
    
}
