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
            
            let winOponent =  player.winsWithUniqueRivals.filter { $0.key == rival }
            let winArray = Array(winOponent.values)
            var value = 0
            if !winArray.isEmpty {
                value = winArray[0]
            }
            let winValue = DataStructuresForChart(lable: "Wins", value: value)
            dataStructuresDictionary.append(winValue)
            
            let losingOponent = player.lostWithUnigueRivals.filter { $0.key == rival}
            let lostArray = Array(losingOponent.values)
            var value2: Int = 0
            if !lostArray.isEmpty {
                value2 = lostArray[0]
            }
            let loseValue = DataStructuresForChart(lable: "Losts", value: value2)
            dataStructuresDictionary.append(loseValue)
            
            let rivalStats = DataForEachPlayer(name: rival, stats: dataStructuresDictionary)
            data.append(rivalStats)
        }
        return data
    }
    
    static func dataForTotalStatisticPreparation(player: Players) -> [DataStructuresForChart] {
    var data = [DataStructuresForChart]()
    let value1 = DataStructuresForChart(lable: "Total wins", value: player.totalWins)
    let value2 = DataStructuresForChart(lable: "Total losses", value: (player.totalGames - player.totalWins))
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
                        let totalLosses = DataStructuresForChart(lable: "Total Losses", value: (matchesCount - matchWins))
                        let totalMachesWin = DataStructuresForChart(lable: "Total Wins", value: matchWins)
                        let machesDataStructuresForChart = [totalLosses,totalMachesWin]
                        let date = sparring.date
                        let sparringData = DataForEachSparring(sparring: date, stats: machesDataStructuresForChart)
                        data.append(sparringData)
                        
                    }
                } }
            
            
        }
        return data
    }
    
    static func dataForEachOponentsPerSparring(oponentsWinLoseDictionary: [String: [Int]]) -> [DataForEachPlayer] {
        var data = [DataForEachPlayer]()
        for oponent in oponentsWinLoseDictionary {
            let wins = oponent.value[0]
            let loses = oponent.value[1]
            let winsDataStructures = DataStructuresForChart(lable: "wins", value: wins)
            let losesDataStructures = DataStructuresForChart(lable: "loses", value: loses)
            let dataStructuresArray = [winsDataStructures, losesDataStructures]
            let oponentDataStructures = DataForEachPlayer(name: oponent.key, stats: dataStructuresArray)
            data.append(oponentDataStructures)
        }
        return data
    }
    
    
    
    
}

