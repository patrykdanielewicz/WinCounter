//
//  MatchesView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 31/12/2024.
//
import SwiftData
import SwiftUI

struct MatchesView: View {
    
    @Environment(\.modelContext) var modelContext
//    @Query var matches: [Matches]
    @State private var sparring: Sparring
    
    @State private var scoreMap: [String: Int] = [:]
    @State private var clickState: [String: Bool] = [:]
    @State private var playersPlayedScore: [String: Int] = [:]
    @State private var notEnoughtPlayersAllert =  false
    @State private var addNewPlayerOrTeam = false
    @State private var showCheckmark = false
    @State private var isATie = false
    
    
    
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
                            MatchesPlayedView(sparring: $sparring, matchNumber: $matchNumber)
                        }
                        Button() {
                            sparring.isSparringEnded.toggle()
                            do {
                                try modelContext.save()
                            } catch {
                                print("Błąd zapisu: \(error.localizedDescription)")
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
        }
        .navigationTitle("Matches")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                
                    if playersPlayedScore.keys.count < 2 {
                        notEnoughtPlayersAllert = true
                        return
                    }
                    
                        if var matches = sparring.matches {
                            matchNumber = matches.count + 1
                            if playersPlayedScore.keys.count != 2 {
                                notEnoughtPlayersAllert = true
                                return
                            }
                            for player in playersPlayedScore.keys {
                                playersPlayedScore[player] = scoreMap[player]
                            }
                            
                            if tieCheck() {
                                isATie = true
                                return
                            }
                            if let winner = playersPlayedScore.max(by: {$0.value < $1.value}) {
                                let winnerDic = [winner.key: winner.value]
                                let match = Matches(sparring: sparring, matchNumber: matchNumber, points: playersPlayedScore, winner: winnerDic)
                                matches.append(match)
//                                modelContext.insert(match)
                                do {
                                    try modelContext.save()
                                } catch {
                                    print("Błąd zapisu: \(error.localizedDescription)")
                                }
                            }
                            showCheckmark = true

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        showCheckmark = false
                                    }
                            playersPlayedScore.removeAll()
                            makingClickState()
                            addingPlayersToScoreMap()
                        }
                    
                }
            }
        }
        .sheet(isPresented: $addNewPlayerOrTeam, content: {
            AddNewPlayerOrTeamToSparring(sparring: sparring)
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
    
    func addingPlayersToScoreMap() {
        if let players = sparring.players {
            for player in players {
                scoreMap[player.name] = 21
            }
        }
    }
    func makingClickState() {
        if let players = sparring.players {
            if players.count == 2 {
                for player in players {
                    clickState[player.name] = true
                    playersPlayedScore[player.name] = 0                }
            }
            else {
                for player in players {
                    clickState[player.name] = false
                    playersPlayedScore.removeAll()
                }
            }
        }
    }
    
    func tieCheck() -> Bool {
        var scoreArray = [Int]()
        for player in playersPlayedScore {
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
