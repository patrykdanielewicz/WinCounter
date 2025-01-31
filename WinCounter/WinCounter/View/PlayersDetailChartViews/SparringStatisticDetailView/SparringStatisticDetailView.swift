//
//  SparringStatisticDetailView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import Charts
import SwiftData
import SwiftUI

struct SparringStatisticDetailView: View {
    
    @Query var sparrings: [Sparring]
    
    @State var player: Players
    @State var playersMatches = 0
    @State var wins = 0
    @State var loses = 0
    @State var mostFrequentOponent = ""
    @State var mostDefeatedOpponents = [String]()
    @State var mostDefeatingOpponents = [String]()
    
    init(filterDate: Date, player: Players) {
        _sparrings = Query(filter: #Predicate<Sparring> { spar in
            spar.date == filterDate
            
        })
        self.player = player
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sparrings) { spar in
                    HStack {
                        VStack {
                            HStack {
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundStyle(.brandPrimary)
                                VStack(alignment: .center) {
                                    if let matches = spar.matches {
                                        Text("\(matches.count)")
                                            .font(.title)
                                            .bold()
                                        Text("total matches")
                                            .font(.footnote)
                                    } }
                            }
                            HStack {
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundStyle(.brandPrimary)
                                VStack(alignment: .center) {
                                    Text("\(wins)")
                                        .font(.title)
                                        .bold()
                                    Text("matches won")
                                        .font(.footnote)
                                }
                            }
                            
                            
                        }
                        Spacer()
                        VStack {
                            HStack {
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundStyle(.brandPrimary)
                                VStack(alignment: .center) {
                                    Text("\(playersMatches)")
                                        .font(.title)
                                        .bold()
                                    Text("Your matches")
                                        .font(.footnote)
                                }
                                
                            }
                            HStack {
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundStyle(.brandPrimary)
                                VStack(alignment: .center) {
                                    Text("\(loses)")
                                        .font(.title)
                                        .bold()
                                    Text("matches lost")
                                        .font(.footnote)
                                }
                            }
                        }
                    }
                }
                
                Section {
                    VStack {
                        VStack(alignment: .center) {
                            Text("\(mostFrequentOponent)")
                                .font(.title)
                                .bold()
                            Text("Most frequent oponent")
                                .font(.footnote)
                            Divider()
                        }
                        
                        VStack(alignment: .center) {
                            ForEach(mostDefeatedOpponents, id: \.self) { oponent in
                                Text("\(oponent)")
                                    .font(.title)
                                    .bold()
                            }
                            if mostDefeatedOpponents.count > 1 {
                                Text("Most defeated oponents")
                                    .font(.footnote)
                            }
                            else {
                                Text("Most defeated oponent")
                                    .font(.footnote)
                            }
                            Divider()
                        }
                        VStack(alignment: .center) {
                            ForEach(mostDefeatingOpponents, id: \.self) { oponent in
                                Text("\(oponent)")
                                    .font(.title)
                                    .bold()
                            }
                            if mostDefeatingOpponents.count > 1 {
                                Text("Most defeating oponents")
                                    .font(.footnote)
                            }
                            else {
                                Text("Most defeating oponent")
                                    .font(.footnote)
                            }
                        }
                    }
                }
                    Section {
                        ChartForEatchPlayerSSDV(sparrings: sparrings, player: player)
                    }
                }
            }
        .navigationTitle("\(sparrings[0].date, format: .dateTime.day().month())")
            .onAppear() {
                playersMatches = DataForSparringsDetailView.playersMatchesInSparring(sparring: sparrings, player: player)
                wins = DataForSparringsDetailView.playersWonMatches(sparring: sparrings, player: player)
                loses = DataForSparringsDetailView.playersLostMatches(sparring: sparrings, player: player)
                mostFrequentOponent = DataForSparringsDetailView.mostFrequentOpponentForPlayer(sparring: sparrings, player: player)
                mostDefeatedOpponents = DataForSparringsDetailView.mostWinsAgainstOpponent(oponentsStats: DataForSparringsDetailView.playersEachOponentsStats(sparring: sparrings, player: player))
                mostDefeatingOpponents = DataForSparringsDetailView.mostLosesAgainstOppoent(oponentsStats: DataForSparringsDetailView.playersEachOponentsStats(sparring: sparrings, player: player))
                
                
            }
        }
    }

    
    //#Preview {
    //    SparringStatisticDetailView()
    //}

