//
//  PlayerVsRivalsChartView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//
//
//import Charts
//import SwiftUI
//
//struct PlayerVsRivalsChartView: View {
//    
//    @State var player: Players
//    
//    @State private var dataForEachPlayersCharts = [DataForEachPlayer]()
//    
//    
//    var body: some View {
//    
//        VStack {
//            ForEach(dataForEachPlayersCharts) { chart in
//                HStack {
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text(chart.name)
//                            .listRowSeparator(.hidden)
//                            .bold()
//                            .padding(.top)
//                        
//                        Chart(chart.stats, id: \.label) { dataItem in
//                            SectorMark(angle: .value("label", dataItem.value), innerRadius: .ratio(0.8))
//                                .foregroundStyle(by: .value("Player", dataItem.label))
//                        }
//                        .frame(width: 150, height: 150)
//                        .padding()
//                        .chartForegroundStyleScale([
//                            "Wins": .brandPrimary,
//                            "Losts": .brandPrimary.opacity(0.5)
//                        ])
//                        .chartLegend(.hidden)
//                        .chartBackground { chartProxy  in
//                            GeometryReader { geometry in
//                                let frame = geometry[chartProxy.plotFrame!]
//                                let visibleSize = min(frame.width, frame.height)
//                                VStack {
//                                    Text("\(player.winsWithUniqueRivals[chart.name] ?? 0)")
//                                        .font(.title)
//                                        .fontWeight(.heavy)
//                                    Text("matches")
//                                        .font(.footnote)
//                                        .opacity(0.8)
//                                    Text("won")
//                                        .font(.footnote)
//                                        .opacity(0.8)
//                                }
//                                .frame(maxWidth: visibleSize * 0.8, maxHeight: visibleSize * 0.8)
//                                .position(x: frame.midX, y: frame.midY)
//                                
//                            }
//                        }
//                        
//                    }
//                    
//                    
//                    VStack {
//                        if let win = player.winsWithUniqueRivals[chart.name] {
//                            if let losses = player.lostWithUnigueRivals[chart.name] {
//                                let totalGames = win + losses
//                                VStack {
//                                    Text("\(totalGames)")
//                                        .font(.title)
//                                        .fontWeight(.heavy)
//                                    Text("Total Games")
//                                        .font(.footnote)
//                                        .opacity(0.8)
//                                }
//                         
//                                .padding(.bottom, 0.8)
//                                
//                                VStack {
//                                    Text("\(losses)")
//                                        .font(.title)
//                                        .fontWeight(.heavy)
//                                    Text("Total Losses")
//                                        .font(.footnote)
//                                        .opacity(0.8)
//                                }
//                            }
//                            else {
//                                let totalGames = win
//                                VStack {
//                                    Text("\(totalGames)")
//                                        .font(.title)
//                                        .fontWeight(.heavy)
//                                    Text("Total Games")
//                                        .font(.footnote)
//                                        .opacity(0.8)
//                                }
//                                .padding(.bottom, 0.8)
//                                VStack {
//                                    Text("0")
//                                        .font(.title)
//                                        .fontWeight(.heavy)
//                                    Text("Total Losses")
//                                        .font(.footnote)
//                                        .opacity(0.8)
//                                }
//                            }
//                        }
//                        else {
//                            if let losses = player.lostWithUnigueRivals[chart.name] {
//                                let totalGames = losses
//                                VStack {
//                                    Text("\(totalGames)")
//                                        .font(.title)
//                                        .fontWeight(.heavy)
//                                    Text("Total Games")
//                                        .font(.footnote)
//                                        .opacity(0.8)
//                                }
//                                .padding(.bottom, 0.8)
//                                VStack {
//                                    Text("\(losses)")
//                                        .font(.title)
//                                        .fontWeight(.heavy)
//                                    Text("Total Losses")
//                                        .font(.footnote)
//                                        .opacity(0.8)
//                                }
//                                .padding(.bottom, 0.8)
//                                
//                            }
//                        }
//                    }
//                    .padding(.top)
//                }
//                .frame(maxWidth: .infinity, alignment: .center)
//            }
//        }
//    
//        .onAppear {
//            dataForEachPlayersCharts = DataForChartsPreparation.dataForEachPlayersChartsPreparation(player: player)
//        }
//    }
//}

//#Preview {
//
//    if let uiImage = UIImage(named: "player1") {
//        if let dataImage = uiImage.pngData() {
//            let player = Players(name: "Patryk Danielewicz", image: dataImage)
//            PlayerVsRivalsChartView(player: player)
//        }
//    }
//}
