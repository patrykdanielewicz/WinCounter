//
//  StatisticViews.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 12/03/2025.
//
import Charts
import SwiftUI

struct StatisticViews: View {
    
    @StateObject private var viewModel: StatisticViewsViewModel
    
    init(dataController: DataControllerProtocol, player: Player) {
        _viewModel =  StateObject(wrappedValue: StatisticViewsViewModel(dc: dataController, player: player))
    }
    
    
    var body: some View {
        List {
            Section("General statistic") {
                VStack {
                    HStack(alignment: .center) {
                        Chart(viewModel.dataChartForTotalStatistic, id: \.label) { dataItem in
                            SectorMark(angle: .value("label", dataItem.value), innerRadius: .ratio(0.8))
                                .foregroundStyle(by: .value("Total", dataItem.label))
                        }
                            .chartLegend(.hidden)
                            .frame(width: 150, height: 150)
                            .chartForegroundStyleScale([
                                "Total wins": .brandPrimary,
                                "Total losses": .brandPrimary.opacity(0.35)
                            ])
                            .chartBackground { chartProxy  in
                                GeometryReader(content: { geometry in
                                    let frame = geometry[chartProxy.plotFrame!]
                                    let visibleSize = min(frame.width, frame.height)
                                    VStack{
                                        Text("\(StatisticPreparation.totalWins(for: viewModel.player))")
                                            .font(.title)
                                            .fontWeight(.heavy)
                                        Text("matches")
                                            .opacity(0.8)
                                            .font(.footnote)
                                        Text("won")
                                            .opacity(0.8)
                                            .font(.footnote)
                                    }
                                    .frame(maxWidth: visibleSize * 0.7, maxHeight: visibleSize * 0.7)
                                    .position(x: frame.midX, y: frame.midY)
                                })
                            }
                        VStack(alignment: .center) {
                            VStack {
                                Text("\(viewModel.player.pointsInMatchArray.count)")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                Text("Total Games")
                                    .font(.footnote)
                                    .opacity(0.8)
                            }
                                .padding(.leading)
                                .padding(.bottom, 0.8)
                            VStack {
                                Text("\(StatisticPreparation.totalLosses(for: viewModel.player))")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                Text("Total losses")
                                    .font(.footnote)
                                    .opacity(0.8)
                            }
                                .padding(.leading)
                                .padding(.bottom)
                        }
                    }
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            Section("Sparring statistics") {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.dataChartForEachSparring) { chart in
                            VStack {
                                Text("\(chart.sparring, format: .dateTime.day().month(.twoDigits))")
                                    .font(.footnote)
                                    .fontWeight(.ultraLight)
                                NavigationLink(destination: SparringStatisticDetailView(dataController: viewModel.dc, date: chart.sparring, player: viewModel.player)) {
                                    Chart(chart.stats, id: \.label) { dataItem in
                                        SectorMark(angle: .value("label", dataItem.value), innerRadius: .ratio(0.7))
                                            .foregroundStyle(by: .value("Player", dataItem.label))
                                    }
                                    .chartForegroundStyleScale([
                                        "Total Wins": .brandPrimary,
                                        "Total Losses": .brandPrimary.opacity(0.35)
                                    ])
                                    .frame(minWidth: 50, idealWidth: 50, maxWidth: .infinity, minHeight: 30, idealHeight: 40, maxHeight: .infinity)
                                    .chartLegend(.hidden)
                                    .chartBackground { chartProxy in
                                        GeometryReader(content: { geometry in
                                            let frame = geometry[chartProxy.plotFrame!]
                                            let visibleSize = min(frame.width, frame.height)
                                            Text("\(chart.stats[1].value)")
                                                .font(.footnote)
                                                .opacity(0.35)
                                                .frame(maxWidth: visibleSize * 0.7 , maxHeight: visibleSize * 0.7)
                                                .position(x: frame.midX, y: frame.midY)
                                        })
                                    }
                                }
                            }
                        }
                    }
                    .frame(height: 60)
                }
            }
                Section("You vs Your Rivals") {
                    VStack {
                        ForEach(viewModel.dataForEachPlayersCharts) { chart in
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(chart.name.wrappedName)
                                        .listRowSeparator(.hidden)
                                        .bold()
                                        .padding(.top)
                                    Chart(chart.stats, id: \.label) { dataItem in
                                        SectorMark(angle: .value("label", dataItem.value), innerRadius: .ratio(0.8))
                                            .foregroundStyle(by: .value("Player", dataItem.label))
                                    }
                                    .frame(width: 150, height: 150)
                                    .padding()
                                    .chartForegroundStyleScale([
                                        "Wins": .brandPrimary,
                                        "Losses": .brandPrimary.opacity(0.5)
                                    ])
                                    .chartLegend(.hidden)
                                    .chartBackground { chartProxy  in
                                        GeometryReader { geometry in
                                            let frame = geometry[chartProxy.plotFrame!]
                                            let visibleSize = min(frame.width, frame.height)
                                            VStack {
                                                Text("\(StatisticPreparation.calculateWins(for: viewModel.player, with: chart.name))")
                                                    .font(.title)
                                                    .fontWeight(.heavy)
                                                Text("matches")
                                                    .font(.footnote)
                                                    .opacity(0.8)
                                                Text("won")
                                                    .font(.footnote)
                                                    .opacity(0.8)
                                            }
                                            .frame(maxWidth: visibleSize * 0.8, maxHeight: visibleSize * 0.8)
                                            .position(x: frame.midX, y: frame.midY)
                                        }
                                    }
                                }
                                VStack {
                                    let win = StatisticPreparation.calculateWins(for: viewModel.player, with: chart.name)
                                    let losses = StatisticPreparation.calculateLosses(for: viewModel.player, with: chart.name)
                                    let totalGames = win + losses
                                    VStack {
                                        Text("\(totalGames)")
                                            .font(.title)
                                            .fontWeight(.heavy)
                                        Text("Total Games")
                                            .font(.footnote)
                                            .opacity(0.8)
                                            }
                                        .padding(.bottom, 0.8)
                                    VStack {
                                        Text("\(losses)")
                                            .font(.title)
                                            .fontWeight(.heavy)
                                        Text("Total Losses")
                                            .font(.footnote)
                                            opacity(0.8)
                                    }
                                }
                                .padding(.top)
                        }
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
        }
    }
}

