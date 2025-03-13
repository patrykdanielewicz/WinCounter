//
//  MatchesView-ViewModel.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 10/03/2025.
//
import CoreData
import Combine
import Foundation

class MatchesViewModel: ObservableObject {
    
    let dc: DataControllerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var sparring: Sparring
    @Published private(set) var matches: [Match]
    
    @Published var scoreMap: [String: Int]           = [:]
    @Published private(set) var clickState: [String: Bool]        = [:]
    @Published private(set) var playersPlayedScore: [Player: Int] = [:]
    
    @Published var notEnoughtPlayersAllert           = false
    @Published var addNewPlayerOrTeam                = false
    @Published var showCheckmark                     = false
    @Published var isATie                            = false
    
    init(dataController: DataControllerProtocol, sparring: Sparring) {
        self.dc = dataController
        self.sparring = sparring
        self.matches = self.dc.fetchData(from: Match.self, predicate: NSPredicate(format: "sparring == %@", sparring as CVarArg), sortKey: "matchNumber", ascending: true)
        makingClickState()
        addingPlayersToScoreMap()
        listeningForChanges()
        
    }
 
    func listeningForChanges() {
        NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange)
            .compactMap { notification in
                (
                    notification.userInfo?[NSUpdatedObjectsKey] as? Set<NSManagedObject>,
                    notification.userInfo?[NSInsertedObjectsKey] as? Set<NSManagedObject>
                )
            }
            .sink { [weak self] updatedObject, insertedMatch in
                guard let self = self else { return }
                
                let wasSparringUpdate = updatedObject?.contains(where: { $0 is Sparring }) ?? false
                let wasMatchInserted  = insertedMatch?.contains(where: { $0 is Match }) ?? false
                let wasMatchPointUpdate = updatedObject?.contains(where: { $0 is MatchPoints }) ?? false
                
                if wasSparringUpdate, let updatedSparring = updatedObject?.first(where: { $0 is Sparring }) as? Sparring {
                    DispatchQueue.main.async {
                        self.sparring = updatedSparring
                    }
                }
                if wasMatchInserted, let insertedMatch = insertedMatch?.compactMap({ $0 as? Match }) {
                    matches.append(contentsOf: insertedMatch)
                }
              
                if wasMatchPointUpdate {
                    
                    DispatchQueue.main.async {
                    
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func addingPlayerOrTeamToMatch(player: Player) {
        clickState[player.wrappedName, default: false].toggle()
        if clickState[player.wrappedName] == true {
            playersPlayedScore[player] = 0
        }
        else {
            playersPlayedScore.removeValue(forKey: player)
        }
    }
    
    func confirmJoiningMatch(player: Player) -> Bool {
        if let _ =  clickState[player.wrappedName] {
            return true
        }
        else {
            return false
        }
    }
    
    func addingPlayersToScoreMap() {
        let players = sparring.wrappedPlayers
        for player in players {
            scoreMap[player.wrappedName] = 21
        }
    }
    
    func makingClickState() {
        let players = sparring.wrappedPlayers
        if players.count == 2 {
            for player in players {
                clickState[player.wrappedName] = true
                playersPlayedScore[player] = 0                }
        }
        else {
            for player in players {
                clickState[player.wrappedName] = false
                playersPlayedScore.removeAll()
            }
        }
    }
    
    func addingNewPlayerOrTeam() {
        addNewPlayerOrTeam.toggle()
    }
    
    func endingSparring() {
        sparring.isSparringEnded.toggle()
        dc.saveData()
    }
    
    func isEnoughPlayersSelected() -> Bool {
        if playersPlayedScore.keys.count != 2 {
            notEnoughtPlayersAllert = true
            return false
        }
        else {
            return true
        }
    }
    
    func tieCheck() -> Bool {
        var scoreArray = [Int]()
        for player in scoreMap.filter({clickState[$0.key] ==  true}) {
            scoreArray.append(player.value)
        }
        if scoreArray[0] == scoreArray[1] {
            isATie = true
            return true
        }
        return false
    }
    
    func setingPlayersScore(match: Match) {
        for player in playersPlayedScore {
            if let score = scoreMap[player.key.wrappedName] {
                let newMatchPoint = dc.addingMatchPoint(player: player.key, match: match, point: score)
                match.addToPoints(newMatchPoint)
                dc.saveData()
                playersPlayedScore[player.key] = score
            }
        }
    }
    
    func setingWinner(match: Match) {
        if let winner = playersPlayedScore.max(by: {$0.value < $1.value}) {
            let newMatchWinner = dc.addingMatchWinner(match: match, winningPlayer: winner.key, points: winner.value)
            match.winner = newMatchWinner
        }
    }
    
    func saveMatch() {
        if !isEnoughPlayersSelected() {
            return
        }
        if tieCheck() {
            return
        }
        let matchNumber = sparring.wrappedMatches.count + 1
        let match = dc.addingMatch(sparring: sparring, matchNumber: matchNumber)
        setingPlayersScore(match: match)
        setingWinner(match: match)
        dc.saveData()
        showCheckmark = true
        playersPlayedScore.removeAll()
        makingClickState()
        addingPlayersToScoreMap()
    }
}
