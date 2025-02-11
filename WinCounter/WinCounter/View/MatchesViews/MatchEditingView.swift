//
//  MatchEditingView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 22/01/2025.
//

import SwiftUI

struct MatchEditingView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss)      var dismiss

    var match: Matches
    var sparring: Sparring
    
    @State var players         = [Players]()
    @State private var score   = [Int]()
    @State private var isATie  = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List() {
                    ForEach(players, id: \.self) { player in
                        HStack {
                            VStack {
                                if let data = player.image {
                                    if let uiimage = UIImage(data: data) {
                                        Image(uiImage: uiimage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .clipShape(.circle)
                                    }
                                }
                                Text(player.name)
                            }
                            
                            Picker("score", selection: $score[players.firstIndex(of: player)!]) {
                                ForEach(0..<30) { value in
                                    Text("\(value)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .labelsHidden()
                            
                        }
                    }
                }
                
            }
          
            }
        .navigationTitle("Edit score in match number \(match.matchNumber)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if score[0] == score[1] {
                        isATie = true
                        return
                    }
                    for player in players {
                        match.points[player.name] = score[players.firstIndex(of: player)!]
                    }
                    if let maxIndex = score.enumerated().max(by: { $0.element < $1.element })?.offset {
                        match.winner.removeAll()
                        match.winner[players[maxIndex].name] = score[maxIndex]
                        print(match.winner)
                    }
                    do {
                        try modelContext.save()
                    } catch {
                        print("Błąd zapisu: \(error.localizedDescription)")
                    }
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
        .alert("Is's a tie", isPresented: $isATie) {
            Button("Ok") { }
        } message: {
            Text("In badminton, there are no ties – someone must win by a two-point advantage or be the first to score 30 points.")
        }
        .onAppear {
            playersInMatch()
            scoreInMatch()
        }
    }
    
    func playersInMatch() {
        var playersNameArray = [String]()
            for player in match.points {
                playersNameArray.append(player.key)
            }
            if let pla = sparring.players {
                let playersArray = pla.filter {playersNameArray.contains($0.name)}
                
                for p in playersArray {
                    players.append(p)
                }
            }
    }
    func scoreInMatch() {
        var scoreArray = [Int]()
            for player in players {
                scoreArray.append(match.points[player.name]!)
            }
            score = scoreArray

    }
    
}
//#Preview {
//    MatchEditingView()
//}
