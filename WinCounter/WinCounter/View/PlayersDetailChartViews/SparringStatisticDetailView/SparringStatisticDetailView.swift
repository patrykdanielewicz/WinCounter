//
//  SparringStatisticDetailView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//
//
import Charts
import CoreData
import SwiftUI

struct SparringStatisticDetailView: View {
    
    @FetchRequest private var sparrings: FetchedResults<Sparring>
    @ObservedObject private var player : Player
    
    private var date: Date
    
    @State private var playersMatches = 0
    @State private var wins = 0
    @State private var losses = 0
    @State private var mostFrequentOpponent = ""
    @State private var mostDefeatedOpponents = [Player]()
    @State private var mostDefeatingOpponents = [Player]()
    
    init(date: Date, player: Player) {
        self.date = date
        self.player = player
        self._sparrings = FetchRequest<Sparring>(sortDescriptors: [], predicate: NSPredicate(format: "date == %@", date as CVarArg), animation: .default)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sparrings, id: \.self) { spar in
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
                                    Text("\(losses)")
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
                            Text("\(mostFrequentOpponent)")
                                .font(.title)
                                .bold()
                            Text("Most frequent opponent")
                                .font(.footnote)
                            Divider()
                        }
                        
                        VStack(alignment: .center) {
                            ForEach(mostDefeatedOpponents, id: \.self) { opponent in
                                Text("\(opponent.wrappedName)")
                                    .font(.title)
                                    .bold()
                            }
                            if mostDefeatedOpponents.count > 1 {
                                Text("Most defeated opponents")
                                    .font(.footnote)
                            }
                            else {
                                Text("Most defeated opponent")
                                    .font(.footnote)
                            }
                            Divider()
                        }
                        VStack(alignment: .center) {
                            ForEach(mostDefeatingOpponents, id: \.self) { opponent in
                                Text("\(opponent.wrappedName)")
                                    .font(.title)
                                    .bold()
                            }
                            if mostDefeatingOpponents.count > 1 {
                                Text("Most defeating opponents")
                                    .font(.footnote)
                            }
                            else {
                                Text("Most defeating opponent")
                                    .font(.footnote)
                            }
                        }
                    }
                }
                    Section {
                        ChartForEachPlayerSSDV(sparrings: Array(sparrings), player: player)
                    }
                }
            }
        .navigationTitle("\(sparrings[0].wrappedDate, format: .dateTime.day().month())")
            .onAppear() {
                playersMatches = DataForSparringsDetailView.playersMatchesInSparring(sparrings: Array(sparrings), player: player)
                wins = DataForSparringsDetailView.playersWonMatches(sparrings: Array(sparrings), player: player)
                losses = DataForSparringsDetailView.playersLostMatches(sparrings: Array(sparrings), player: player)
                mostFrequentOpponent = DataForSparringsDetailView.mostFrequentOpponentForPlayer(sparrings: Array(sparrings), player: player)
                mostDefeatedOpponents = DataForSparringsDetailView.mostWinsAgainstOpponent(opponentsStats: DataForSparringsDetailView.playersEachOpponentsStats(sparrings: Array(sparrings), player: player))
                mostDefeatingOpponents = DataForSparringsDetailView.mostLossesAgainstOppoent(opponentsStats: DataForSparringsDetailView.playersEachOpponentsStats(sparrings: Array(sparrings), player: player))
                
                
            }
        }
    }

    
    //#Preview {
    //    SparringStatisticDetailView()
    //}

