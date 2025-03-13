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
    
    @StateObject private var viewModel: SparringStatisticDVViewModel
    
    init(dataController: DataControllerProtocol, date: Date, player: Player) {
        _viewModel = StateObject(wrappedValue: SparringStatisticDVViewModel(dataController: dataController, player: player, date: date))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sparrings, id: \.self) { spar in
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
                                    }
                                }
                            }
                            HStack {
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundStyle(.brandPrimary)
                                VStack(alignment: .center) {
                                    Text("\(viewModel.wins)")
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
                                    Text("\(viewModel.playersMatches)")
                                        .font(.title)
                                        .bold()
                                    Text("Your total matches")
                                        .font(.footnote)
                                }
                            }
                            HStack {
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundStyle(.brandPrimary)
                                VStack(alignment: .center) {
                                    Text("\(viewModel.losses)")
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
                            Text("\(viewModel.mostFrequentOpponent)")
                                .font(.title)
                                .bold()
                            Text("Most frequent opponent")
                                .font(.footnote)
                            Divider()
                        }
                        VStack(alignment: .center) {
                            ForEach(viewModel.mostDefeatedOpponents, id: \.self) { opponent in
                                Text("\(opponent.wrappedName)")
                                    .font(.title)
                                    .bold()
                            }
                            if viewModel.mostDefeatedOpponents.count > 1 {
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
                            ForEach(viewModel.mostDefeatingOpponents, id: \.self) { opponent in
                                Text("\(opponent.wrappedName)")
                                    .font(.title)
                                    .bold()
                            }
                            if viewModel.mostDefeatingOpponents.count > 1 {
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
                    VStack {
                        ForEach(viewModel.dataForCharts) { chart in
                            HStack {
                                VStack {
                                    Text(chart.name.wrappedName)
                                    Chart(chart.stats, id: \.label) { dataItem in
                                        SectorMark(angle: .value("label", dataItem.value), innerRadius: .ratio(0.8))
                                            .foregroundStyle(by: .value("Player", dataItem.label))
                                        }
                                    .frame(width: 150, height: 150)
                                    .padding()
                                    .chartForegroundStyleScale([
                                        "wins": .brandPrimary,
                                        "losses": .brandPrimary.opacity(0.5)
                                    ])
                                    .chartLegend(.hidden)
                                    .chartBackground { chartProxy  in
                                        GeometryReader { geometry in
                                            let frame = geometry[chartProxy.plotFrame!]
                                            let visibleSize = min(frame.width, frame.height)
                                            VStack {
                                                Text("\(chart.stats[0].value)")
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
                                    let totalMatches = chart.stats[0].value + chart.stats[1].value
                                    VStack {
                                        Text("\(totalMatches)")
                                            .font(.title)
                                            .fontWeight(.heavy)
                                        Text("Total Matches")
                                            .font(.footnote)
                                            .opacity(0.8)
                                    }
                                    .padding(.bottom, 0.8)
                                    VStack {
                                        Text("\(chart.stats[1].value)")
                                            .font(.title)
                                            .fontWeight(.heavy)
                                        Text("Matches Lost")
                                            .font(.footnote)
                                            .opacity(0.8)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("\(viewModel.sparrings[0].wrappedDate, format: .dateTime.day().month())")
    }
}

    
    //#Preview {
    //    SparringStatisticDetailView()
    //}

