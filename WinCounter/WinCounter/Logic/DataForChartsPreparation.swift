//
//  DataForChartsPreparation.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//
//
import Foundation

class DataForChartsPreparation {

    static func dataForEachPlayersChartsPreparation(player: Player) -> [DataForEachPlayer] {
        var data = [DataForEachPlayer]()
        for rival in StatisticPreperation.makingRivalsArray(for: player) {
            
            var dataStructuresDictionary = [DataStructuresForChart]()
            
            let wins = StatisticPreperation.calculateWins(for: player, with: rival)
            let winValue = DataStructuresForChart(label: "Wins", value: wins)
            dataStructuresDictionary.append(winValue)
            
            let losses = StatisticPreperation.calculateLosses(for: player, with: rival)
            let lossesValue = DataStructuresForChart(label: "Losts", value: losses)
            dataStructuresDictionary.append(lossesValue)
            
            let rivalStats = DataForEachPlayer(name: rival, stats: dataStructuresDictionary)
            data.append(rivalStats)
        }
        return data
    }
    
    static func dataForTotalStatisticPreparation(player: Player) -> [DataStructuresForChart] {
    var data = [DataStructuresForChart]()
        let value1 = DataStructuresForChart(label: "Total wins", value: StatisticPreperation.totalWins(for: player))
        let value2 = DataStructuresForChart(label: "Total losses", value: StatisticPreperation.totalLosses(for: player))
    data.append(contentsOf: [value1, value2])
        return data
}
//
    static func dataForSparringsStatistic(player: Player) -> [DataForEachSparring] {
        var data = [DataForEachSparring]()
         let sparrings = player.sparringsArray
            for sparring in sparrings {
            let matches = sparring.wrappedMatches
            let matchesCount: Int = matches.count
                var matchWins: Int = 0
                for match in matches {
                    if let winner = match.winner {
                        if  winner.player == player {
                        matchWins += 1
                        }
                    }
                }
                if matchesCount != 0 {
                    let totalLosses = DataStructuresForChart(label: "Total Losses", value: (matchesCount - matchWins))
                    let totalMachesWin = DataStructuresForChart(label: "Total Wins", value: matchWins)
                    let machesDataStructuresForChart = [totalLosses,totalMachesWin]
                    let date = sparring.wrappedDate
                    let sparringData = DataForEachSparring(sparring: date, stats: machesDataStructuresForChart)
                        data.append(sparringData)
                        
                }
            }
        return data
    }
    
    static func dataForEachOpponentsPerSparring(opponentsWinLossesDictionary: [Player: [Int]]) -> [DataForEachPlayer] {
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

