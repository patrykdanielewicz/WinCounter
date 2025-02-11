//
//  TestView.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 23/01/2025.
//

import WatchKit
import SwiftUI

struct MatchView: View {
    
    @Environment(\.dismiss) var dissmis
    
    @State  var sparring: Sparring
    
    @State  var selectedPlayers: [Players]
    
    @State private var isATie = false
    @State private var isGameOver = false
    
    @State private var scorePlayer1 = 0
    @State private var scorePlayer2 = 0
    
    var body: some View {
       
            GeometryReader { geometry in
                let midX = geometry.size.width / 2
                
                let dragGesture = DragGesture(minimumDistance: 10, coordinateSpace: .local)
                    .onEnded { value in
                        let startX = value.startLocation.x
                                let deltaX = abs(value.translation.width) // Ruch w osi X
                                let deltaY = value.translation.height // Ruch w osi Y
                                
                                // Sprawdź, czy gest jest bardziej pionowy niż poziomy
                                if deltaX < abs(deltaY) {
                                    if deltaY < 0 { // Przesunięcie w górę
                                        if startX < midX {
                                            scorePlayer1 += 1
                                        } else {
                                            scorePlayer2 += 1
                                        }
                                    } else if deltaY > 0 { // Przesunięcie w dół
                                        if startX < midX {
                                            if scorePlayer1 > 0 { scorePlayer1 -= 1 }
                                        } else {
                                            if scorePlayer2 > 0 { scorePlayer2 -= 1 }
                                        }
                                    }
                            
                                    WKInterfaceDevice.current().play(.click)
                                 
                                }
                    }
              
                ZStack {
                    HStack(spacing: 0 ){
                        ZStack {
                            Color.player1
                            VStack {
                                let playerNr1 = selectedPlayers[0]
                                if let dataImage = playerNr1.image {
                                    if let uiiImage = UIImage(data: dataImage) {
                                        Image(uiImage: uiiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 75, height: 100)
                                            .clipShape(.circle)
                                            .overlay(
                                                Circle().stroke(Color.brand, lineWidth: 2))
                                            .shadow(radius: 10)
                                    }
                                }
                                
                                
                                Text("\(scorePlayer1)")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                
                            }
                        }
                        ZStack {
                            Color.player2
                            VStack {
                                let playerNr2 = selectedPlayers[1]
                                if let dataImage = playerNr2.image {
                                    if let uiiImage = UIImage(data: dataImage) {
                                        Image(uiImage: uiiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 75, height: 100)
                                            .clipShape(.circle)
                                            .overlay(
                                                Circle().stroke(Color.brand, lineWidth: 2))
                                            .shadow(radius: 10)
                                    }
                                }
                                Text("\(scorePlayer2)")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    
                    .gesture(dragGesture)
                  
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 100, height: 100)
                        .contentShape(Circle())
                        .onLongPressGesture(minimumDuration: 0.5,maximumDistance: 1, perform: {
                            WKInterfaceDevice.current().play(.success)
                            isGameOver = true
                        })
                }
                    .edgesIgnoringSafeArea(.all)
                    .alert("End game?", isPresented: $isGameOver) {
                        Button("Yes") {
                            if let match = preperingDataForSending() {
                                sparring.matches?.append(match)
                                dissmis()
                            }
                        }
                        Button("No") {
                            
                        }
                        Button("Leave match") {
                            dissmis()
                        }
                    } message: {
                        Text("Are you sure you want to end this match?")
                    }
                    .alert("Is's a tie", isPresented: $isATie) {
                        Button("Ok") { }
                    } message: {
                        Text("In badminton, there are no ties – someone must win by a two-point advantage or be the first to score 30 points.")
                    }
                
                .navigationBarBackButtonHidden()
            }
            
        
        
        }
    func preperingDataForSending() -> Matches? {
                                var matchNumber = 0
                                var points = [String:Int]()
                                var winner = [String: Int]()
                                if let matchesInSparring = sparring.matches {
                                    matchNumber = matchesInSparring.count + 1
                                }
                              
                                if selectedPlayers.count == 2 {
                                    points[selectedPlayers[0].name] = scorePlayer1
                                    points[selectedPlayers[1].name] = scorePlayer2
                                }
                                else {
                                    return nil
                                }
                                if scorePlayer1 > scorePlayer2 {
                                    winner[selectedPlayers[0].name] = scorePlayer1
                                }
                                else if scorePlayer1 == scorePlayer2 {
                                    isATie = true
                                    return nil
                                }
                                else {
                                    winner[selectedPlayers[1].name] = scorePlayer2
                                }
        print(points)
                                let match = Matches(sparring: sparring, matchNumber: matchNumber, points: points, winner: winner)
                            
        return match
    }
}
//#Preview {
//    MatchView()
//}
