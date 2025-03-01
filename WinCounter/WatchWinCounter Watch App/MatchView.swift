//
//  TestView.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 23/01/2025.
//
//
import WatchKit
import SwiftUI

struct MatchView: View {
    
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) var dissmis
    
    @State  var sparring: Sparring
    
    @State  var selectedPlayers: [Player]
    
    @State private var isATie = false
    @State private var isGameOver = false
    
    @State private var scorePlayer1 = 0
    @State private var scorePlayer2 = 0
    
    @State private var newMatch = false
    @State private var endSparring = false
    
    var body: some View {
        NavigationStack {
        GeometryReader { geometry in
            let midX = geometry.size.width / 2
            
            let dragGesture = DragGesture(minimumDistance: 10, coordinateSpace: .local)
                .onEnded { value in
                    let startX = value.startLocation.x
                    let deltaX = abs(value.translation.width)
                    let deltaY = value.translation.height
                    
                    if deltaX < abs(deltaY) {
                        if deltaY < 0 {
                            if startX < midX {
                                scorePlayer1 += 1
                            } else {
                                scorePlayer2 += 1
                            }
                        } else if deltaY > 0 {
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
                                        .frame(width: 75, height: 75)
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
                                        .frame(width: 75, height: 75)
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
                Button("Yes, and start another one.") {
                    savingData()
                    newMatch = true
                    
                }
                Button("Yes, but end sparring") {
                    savingData()
                    dissmis()
                    
                }
                Button("No") {
                    
                }
                Button("Leave the match without saving") {
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
        .navigationDestination(isPresented: $endSparring) {
            SparringView()
        }
        .navigationDestination(isPresented: $newMatch) {
            AddNewMatchView(sparring: sparring)
        }
    }
//            .fullScreenCover(isPresented: $newMatch) {
//                AddNewMatchView(sparring: sparring)
//            }
        
        
        }
    func savingData() {
        let matchNumber = sparring.wrappedMatches.count + 1
        let matchWinner = MatchWinners(context: moc)
        let matchPoints1 = MatchPoints(context: moc)
        let matchPoints2 = MatchPoints(context: moc)
    
        if selectedPlayers.count == 2 {
            matchPoints1.player = selectedPlayers[0]
            matchPoints2.player = selectedPlayers[1]
            matchPoints1.points = Int16(scorePlayer1)
            matchPoints2.points = Int16(scorePlayer2)
     }
     else {
         return
     }
        if scorePlayer1 == scorePlayer2 {
            isATie = true
            return
        }
        
     else if scorePlayer1 > scorePlayer2 {
         matchWinner.player = selectedPlayers[0]
         matchWinner.points = Int16(scorePlayer1)
     
     }
     else {
         matchWinner.player = selectedPlayers[1]
         matchWinner.points = Int16(scorePlayer2)
    }
    let match = Match(context: moc)
        match.sparring = sparring
        match.matchNumber = Int16(matchNumber)
        match.winner = matchWinner
        match.addToPoints(matchPoints1)
        match.addToPoints(matchPoints2)
        
        do {
            try moc.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
//#Preview {
//    MatchView()
//}
