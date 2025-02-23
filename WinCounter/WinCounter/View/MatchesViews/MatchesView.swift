//
//  MatchesView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 31/12/2024.
//
import CoreData
import SwiftUI

struct MatchesView: View {
    
    // Environment
    @Environment(\.managedObjectContext) var moc
    
    // CoreData
    @ObservedObject private var sparring: Sparring
    
    // ScoreTracking
    @State private var scoreMap: [String: Int]           = [:]
    @State private var clickState: [String: Bool]        = [:]
    @State private var playersPlayedScore: [Player: Int] = [:]
    
    // UIState
    @State private var notEnoughtPlayersAllert           = false
    @State private var addNewPlayerOrTeam                = false
    @State private var showCheckmark                     = false
    @State private var isATie                            = false
    
    
    
    @State private var matchNumber: Int = 0
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List {
                        if sparring.isSparringEnded == false {
                            VStack {
                                AddingScoreToMatch(sparring: sparring, clickState: $clickState, playersPlayedScore: $playersPlayedScore, scoreMap: $scoreMap)
                                Section {
                                    Button("Add new player or team") {
                                        addNewPlayerOrTeam.toggle()
                                    }
                                    .buttonStyle(.borderless)
                                }
                            }
                        }
                        Section("Matches played") {
                            MatchesPlayedView(sparring: sparring)
                        }
                        Button() {
                            sparring.isSparringEnded.toggle()
                            if moc.hasChanges {
                                do {
                                    try moc.save()
                                } catch {
                                    print("Błąd zapisu: \(error.localizedDescription)")
                                }
                            }
                        } label: {
                            Text(sparring.isSparringEnded ? "Edit sparring" : "End sparring")
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                                }
                            .buttonStyle(.borderless)
                        
                        
                    }
                    
                    
                    
                }
                CheckmarkView(showCheckmark: $showCheckmark)
                
                
            }
            
            .navigationTitle("Matches")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        
                                    save()
                        
                                   
                                    
        
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        showCheckmark = false
                                    }
                                    playersPlayedScore.removeAll()
                                    makingClickState()
                                    addingPlayersToScoreMap()
                    }
                }
            }
                .sheet(isPresented: $addNewPlayerOrTeam, content: {
                    //            AddNewPlayerOrTeamToSparring(sparring: sparring)
                })
                .alert("Not enought players", isPresented: $notEnoughtPlayersAllert) {
                    Button("Ok") { }
                } message: {
                    Text("There are not enough players to play the match - please mark at least 2 players")
                }
                
                .alert("Is's a tie", isPresented: $isATie) {
                    Button("Ok") { }
                } message: {
                    Text("In badminton, there are no ties – someone must win by a two-point advantage or be the first to score 30 points.")
                }
                
                .onAppear {
                    makingClickState()
                    addingPlayersToScoreMap()
                    
                }
            
        }
    }
        
    func save() {

        if playersPlayedScore.keys.count != 2 {
            notEnoughtPlayersAllert = true
            return
        }
        
        if tieCheck() {
            isATie = true
            return
        }
        
        
        
        let matches = sparring.wrappedMatches
   
        let match = Match(context: moc)
            match.sparring = sparring
            match.matchNumber = Int16(matches.count + 1)
    
        for player in playersPlayedScore {
       
            if let score = scoreMap[player.key.wrappedName] {
                let newMatchPoint = MatchPoints(context: moc)
                    newMatchPoint.player = player.key
                    newMatchPoint.points = Int16(score)
                    newMatchPoint.match  = match
                    match.addToPoints(newMatchPoint)
                    playersPlayedScore[player.key] = score
            }
        }
            
        if let winner = playersPlayedScore.max(by: {$0.value < $1.value}) {
            let newMatchWinner = MatchWinners(context: moc)
            newMatchWinner.player = winner.key
            newMatchWinner.points = Int16(winner.value)
            newMatchWinner.match = match
            print(newMatchWinner.player?.wrappedName ?? "c")
        }
        showCheckmark = true
        
        do {
            try moc.save()
        } catch {
            print("Błąd zapisu: \(error.localizedDescription)")
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
        
        func tieCheck() -> Bool {
            var scoreArray = [Int]()
            for player in scoreMap {
                scoreArray.append(player.value)
            }
            if scoreArray[0] == scoreArray[1] {
                return true
            }
            return false
        }
        
        
        init(sparring: Sparring) {
            self.sparring = sparring
            
        }
    }
    
    //#Preview {
    //    MatchesView()
    //}

