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
    
    @Environment(\.dismiss) var dissmis
    
    @StateObject private var viewModel: MatchViewModel
    
    init(dataController: DataControllerProtocol, sparring: Sparring, selectedPlayers: [Player]) {
        _viewModel = StateObject(wrappedValue: MatchViewModel(dataController: dataController, sparring: sparring, selectedPlayers: selectedPlayers))
        
        
        
    }
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
                                    viewModel.addingPointToPlayer1()
                                } else {
                                    viewModel.addingPointToPlayer2()
                                }
                            } else if deltaY > 0 {
                                if startX < midX {
                                    if viewModel.scorePlayer1 > 0 { viewModel.substractPointToPlayer1() }
                                } else {
                                    if viewModel.scorePlayer2 > 0 { viewModel.substracPointToPlayer2() }
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
                                let playerNr1 = viewModel.selectedPlayers[0]
                                let image = viewModel.dc.decodeImage(for: playerNr1)
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipShape(.circle)
                                    .overlay(
                                        Circle().stroke(Color.brand, lineWidth: 2))
                                    .shadow(radius: 10)
                                Text("\(viewModel.scorePlayer1)")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                        }
                        ZStack {
                            Color.player2
                            VStack {
                                let playerNr2 = viewModel.selectedPlayers[1]
                                let image = viewModel.dc.decodeImage(for: playerNr2)
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipShape(.circle)
                                    .overlay(
                                        Circle().stroke(Color.brand, lineWidth: 2))
                                    .shadow(radius: 10)
                                Text("\(viewModel.scorePlayer2)")
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
                            viewModel.gameOver()
                        })
                }
                .edgesIgnoringSafeArea(.all)
                .alert("End game?", isPresented: $viewModel.isGameOver) {
                    Button("Yes, and start another one.") {
                        viewModel.savingMatch()
                        viewModel.newGame()
                        
                    }
                    Button("Yes, but end sparring") {
                        viewModel.savingMatch()
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
                .alert("Is's a tie", isPresented: $viewModel.isATie) {
                    Button("Ok") { }
                } message: {
                    Text("In badminton, there are no ties – someone must win by a two-point advantage or be the first to score 30 points.")
                }
                
            .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $viewModel.endSparring) {
                SparringView(dataController: viewModel.dc)
            }
            .navigationDestination(isPresented: $viewModel.newMatch) {
                AddNewMatchView(dataController: viewModel.dc, sparring: viewModel.sparring)
            }
        }
    }
}
//#Preview {
//    MatchView()
//}
