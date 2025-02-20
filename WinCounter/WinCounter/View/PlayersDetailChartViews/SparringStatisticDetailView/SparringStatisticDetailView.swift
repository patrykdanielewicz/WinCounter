//
//  SparringStatisticDetailView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//
//
//import Charts
//import SwiftData
//import SwiftUI
//
//struct SparringStatisticDetailView: View {
//    
//    @Query var sparrings: [Sparring]
//    
//    @State var player: Players
//    @State var playersMatches = 0
//    @State var wins = 0
//    @State var losses = 0
//    @State var mostFrequentOpponent = ""
//    @State var mostDefeatedOpponents = [String]()
//    @State var mostDefeatingOpponents = [String]()
//    
//    init(filterDate: Date, player: Players) {
//        _sparrings = Query(filter: #Predicate<Sparring> { spar in
//            spar.date == filterDate
//            
//        })
//        self.player = player
//    }
//    
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(sparrings) { spar in
//                    HStack {
//                        VStack {
//                            HStack {
//                                Circle()
//                                    .frame(width: 15, height: 15)
//                                    .foregroundStyle(.brandPrimary)
//                                VStack(alignment: .center) {
//                                    if let matches = spar.matches {
//                                        Text("\(matches.count)")
//                                            .font(.title)
//                                            .bold()
//                                        Text("total matches")
//                                            .font(.footnote)
//                                    } }
//                            }
//                            HStack {
//                                Circle()
//                                    .frame(width: 15, height: 15)
//                                    .foregroundStyle(.brandPrimary)
//                                VStack(alignment: .center) {
//                                    Text("\(wins)")
//                                        .font(.title)
//                                        .bold()
//                                    Text("matches won")
//                                        .font(.footnote)
//                                }
//                            }
//                            
//                            
//                        }
//                        Spacer()
//                        VStack {
//                            HStack {
//                                Circle()
//                                    .frame(width: 15, height: 15)
//                                    .foregroundStyle(.brandPrimary)
//                                VStack(alignment: .center) {
//                                    Text("\(playersMatches)")
//                                        .font(.title)
//                                        .bold()
//                                    Text("Your matches")
//                                        .font(.footnote)
//                                }
//                                
//                            }
//                            HStack {
//                                Circle()
//                                    .frame(width: 15, height: 15)
//                                    .foregroundStyle(.brandPrimary)
//                                VStack(alignment: .center) {
//                                    Text("\(losses)")
//                                        .font(.title)
//                                        .bold()
//                                    Text("matches lost")
//                                        .font(.footnote)
//                                }
//                            }
//                        }
//                    }
//                }
//                
//                Section {
//                    VStack {
//                        VStack(alignment: .center) {
//                            Text("\(mostFrequentOpponent)")
//                                .font(.title)
//                                .bold()
//                            Text("Most frequent opponent")
//                                .font(.footnote)
//                            Divider()
//                        }
//                        
//                        VStack(alignment: .center) {
//                            ForEach(mostDefeatedOpponents, id: \.self) { opponent in
//                                Text("\(opponent)")
//                                    .font(.title)
//                                    .bold()
//                            }
//                            if mostDefeatedOpponents.count > 1 {
//                                Text("Most defeated opponents")
//                                    .font(.footnote)
//                            }
//                            else {
//                                Text("Most defeated opponent")
//                                    .font(.footnote)
//                            }
//                            Divider()
//                        }
//                        VStack(alignment: .center) {
//                            ForEach(mostDefeatingOpponents, id: \.self) { opponent in
//                                Text("\(opponent)")
//                                    .font(.title)
//                                    .bold()
//                            }
//                            if mostDefeatingOpponents.count > 1 {
//                                Text("Most defeating opponents")
//                                    .font(.footnote)
//                            }
//                            else {
//                                Text("Most defeating opponent")
//                                    .font(.footnote)
//                            }
//                        }
//                    }
//                }
//                    Section {
//                        ChartForEachPlayerSSDV(sparrings: sparrings, player: player)
//                    }
//                }
//            }
//        .navigationTitle("\(sparrings[0].date, format: .dateTime.day().month())")
//            .onAppear() {
//                playersMatches = DataForSparringsDetailView.playersMatchesInSparring(sparring: sparrings, player: player)
//                wins = DataForSparringsDetailView.playersWonMatches(sparring: sparrings, player: player)
//                losses = DataForSparringsDetailView.playersLostMatches(sparring: sparrings, player: player)
//                mostFrequentOpponent = DataForSparringsDetailView.mostFrequentOpponentForPlayer(sparring: sparrings, player: player)
//                mostDefeatedOpponents = DataForSparringsDetailView.mostWinsAgainstOpponent(opponentsStats: DataForSparringsDetailView.playersEachOpponentsStats(sparring: sparrings, player: player))
//                mostDefeatingOpponents = DataForSparringsDetailView.mostLossesAgainstOppoent(opponentsStats: DataForSparringsDetailView.playersEachOpponentsStats(sparring: sparrings, player: player))
//                
//                
//            }
//        }
//    }

    
    //#Preview {
    //    SparringStatisticDetailView()
    //}

