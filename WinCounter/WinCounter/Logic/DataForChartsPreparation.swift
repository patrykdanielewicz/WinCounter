//
//  DataForChartsPreparation.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import Foundation

class DataForChartsPreparation {

    static func dataForEachPlayersChartsPreparation(player: Players) -> [DataForEachPlayer] {
        var data = [DataForEachPlayer]()
        for rival in player.rivals {
            
            var dataStructuresDictionary = [DataStructuresForChart]()
            
            let winOpponent =  player.winsWithUniqueRivals.filter { $0.key == rival }
            let winArray = Array(winOpponent.values)
            var value = 0
            if !winArray.isEmpty {
                value = winArray[0]
            }
            let winValue = DataStructuresForChart(label: "Wins", value: value)
            dataStructuresDictionary.append(winValue)
            
            let losingOpponent = player.lostWithUnigueRivals.filter { $0.key == rival}
            let lostArray = Array(losingOpponent.values)
            var value2: Int = 0
            if !lostArray.isEmpty {
                value2 = lostArray[0]
            }
            let lossesValue = DataStructuresForChart(label: "Losts", value: value2)
            dataStructuresDictionary.append(lossesValue)
            
            let rivalStats = DataForEachPlayer(name: rival, stats: dataStructuresDictionary)
            data.append(rivalStats)
        }
        return data
    }
    
    static func dataForTotalStatisticPreparation(player: Players) -> [DataStructuresForChart] {
    var data = [DataStructuresForChart]()
    let value1 = DataStructuresForChart(label: "Total wins", value: player.totalWins)
    let value2 = DataStructuresForChart(label: "Total losses", value: (player.totalGames - player.totalWins))
    data.append(contentsOf: [value1, value2])
        return data
}

    static func dataForSparringsStatistic(player: Players) -> [DataForEachSparring] {
        var data = [DataForEachSparring]()
        if let sparrings = player.sparrings {
            for sparring in sparrings {
                if let matches = sparring.matches {
                    let matchesCount: Int = matches.count
                    
                    var matchWins: Int = 0
                    for match in matches {
                        if match.winner.keys.contains(player.name) {
                            matchWins += 1
                        }
                    }
                    if matchesCount != 0 {
                        let totalLosses = DataStructuresForChart(label: "Total Losses", value: (matchesCount - matchWins))
                        let totalMachesWin = DataStructuresForChart(label: "Total Wins", value: matchWins)
                        let machesDataStructuresForChart = [totalLosses,totalMachesWin]
                        let date = sparring.date
                        let sparringData = DataForEachSparring(sparring: date, stats: machesDataStructuresForChart)
                        data.append(sparringData)
                        
                    }
                } }
            
            
        }
        return data
    }
    
    static func dataForEachOpponentsPerSparring(opponentsWinLossesDictionary: [String: [Int]]) -> [DataForEachPlayer] {
        var data = [DataForEachPlayer]()
        for opponent in opponentsWinLossesDictionary {
            let wins = opponent.value[0]
            let losses = opponent.value[1]
            let winsDataStructures = DataStructuresForChart(label: "wins", value: wins)
            let lossesDataStructures = DataStructuresForChart(label: "losses", value: losses)
            let dataStructuresArray = [winsDataStructures, lossesDataStructures]
            let opponentDataStructures = DataForEachPlayer(name: opponent.key, stats: dataStructuresArray)
            data.append(opponentDataStructures)
        }
        return data
    }
    
    
    
    
}

