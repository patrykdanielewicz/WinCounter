//
//  MatchEditingView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 22/01/2025.
//
import CoreData
import SwiftUI

struct MatchEditingView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss)      var dismiss

    var match: Match
    var sparring: Sparring
    
    @State var players         = [Player]()
    @State private var score   = [Int]()
    @State private var isATie  = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List() {
                    ForEach(match.wrappedPoints, id: \.self) { matchPoints in
                        HStack {
                            HStack {
                                if let data = matchPoints.wrappedPlayer.image {
                                    if let uiimage = UIImage(data: data) {
                                        Image(uiImage: uiimage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                            .clipShape(.circle)
                                    }
                                }
                                Text(matchPoints.wrappedPlayer.wrappedName)
                                    .frame(width: 100, alignment: .leading)

                            }
                            
//                            Picker("score", Binding(
//                                get: { Int(matchPoints.points) },
//                                set: { newValue in matchPoints.points = Int16(newValue) }
//                            )) {
//                                ForEach(0..<30) { value in
//                                    Text("\(value)")
//                                }
//                            }
//                            .pickerStyle(WheelPickerStyle())
//                            .labelsHidden()
                            
                        }
                    }
                }
                
            }
          
            }
        .navigationTitle("Edit score in match number \(Int(match.matchNumber))")
        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                Button {
//                    if score[0] == score[1] {
//                        isATie = true
//                        return
//                    }
//                    for player in players {
//                        match.points[player.name] = score[players.firstIndex(of: player)!]
//                    }
//                    if let maxIndex = score.enumerated().max(by: { $0.element < $1.element })?.offset {
//                        match.winner.removeAll()
//                        match.winner[players[maxIndex].name] = score[maxIndex]
//                        print(match.winner)
//                    }
//                    do {
//                        try modelContext.save()
//                    } catch {
//                        print("Błąd zapisu: \(error.localizedDescription)")
//                    }
//                    dismiss()
//                } label: {
//                    Text("Save")
//                }
//            }
//        }
        .alert("Is's a tie", isPresented: $isATie) {
            Button("Ok") { }
        } message: {
            Text("In badminton, there are no ties – someone must win by a two-point advantage or be the first to score 30 points.")
        }
        .onAppear {
//            playersInMatch()
//            scoreInMatch()
        }
    }
    
//    func playersInMatch() {
//        var playersNameArray = [String]()
//        for playerInMatch in match.wrappedPoints {
//            players.append(playerInMatch.wrappedPlayer)
//        }
//        
//        
//        
//    }
//    func scoreInMatch() {
//        var scoreArray = [Int]()
//            for player in players {
//                scoreArray.append(match.points[player.name]!)
//            }
//            score = scoreArray
//
//    }
    
}
//#Preview {
//    MatchEditingView()
//}
