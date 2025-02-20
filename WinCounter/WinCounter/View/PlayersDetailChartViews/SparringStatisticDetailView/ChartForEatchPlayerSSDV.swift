//
//  ChartForEachPlayerSSDV.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//
//
//import Charts
//import SwiftUI
//
//struct ChartForEachPlayerSSDV: View {
//    
//    @State var dataForCharts = [DataForEachPlayer]()
//    @State var sparrings: [Sparring]
//    @State var player: Players
//    
//    var body: some View {
//        
//            VStack {
//                ForEach(dataForCharts) { chart in
//                    HStack {
//                        VStack {
//                            Text(chart.name)
//                            Chart(chart.stats, id: \.label) { dataItem in
//                                SectorMark(angle: .value("label", dataItem.value), innerRadius: .ratio(0.8))
//                                    .foregroundStyle(by: .value("Player", dataItem.label))
//                            }
//                            .frame(width: 150, height: 150)
//                            .padding()
//                            .chartForegroundStyleScale([
//                                "wins": .brandPrimary,
//                                "losses": .brandPrimary.opacity(0.5)
//                            ])
//                            .chartLegend(.hidden)
//                            .chartBackground { chartProxy  in
//                                GeometryReader { geometry in
//                                    let frame = geometry[chartProxy.plotFrame!]
//                                    let visibleSize = min(frame.width, frame.height)
//                                    VStack {
//                                        Text("\(chart.stats[0].value)")
//                                            .font(.title)
//                                            .fontWeight(.heavy)
//                                        Text("matches")
//                                            .font(.footnote)
//                                            .opacity(0.8)
//                                        Text("won")
//                                            .font(.footnote)
//                                            .opacity(0.8)
//                                    }
//                                    .frame(maxWidth: visibleSize * 0.8, maxHeight: visibleSize * 0.8)
//                                    .position(x: frame.midX, y: frame.midY)
//                                    
//                                }
//                            }
//                        }
//                        VStack {
//                            let totalMatches = chart.stats[0].value + chart.stats[1].value
//                            VStack {
//                                Text("\(totalMatches)")
//                                    .font(.title)
//                                    .fontWeight(.heavy)
//                                Text("Total Matches")
//                                    .font(.footnote)
//                                    .opacity(0.8)
//                            }
//                            
//                            .padding(.bottom, 0.8)
//                            
//                            VStack {
//                                Text("\(chart.stats[1].value)")
//                                    .font(.title)
//                                    .fontWeight(.heavy)
//                                Text("Total Losses")
//                                    .font(.footnote)
//                                    .opacity(0.8)
//                            }
//                        }
//                    }
//                }
//            }
//            .onAppear {
//                dataForCharts = DataForChartsPreparation.dataForEachOpponentsPerSparring(opponentsWinLossesDictionary: DataForSparringsDetailView.playersEachOpponentsStats(sparring: sparrings, player: player))
//                print(DataForSparringsDetailView.playersEachOpponentsStats(sparring: sparrings, player: player))
//            }
//        }
//        
//    }


//#Preview {
//    ChartForEachPlayerSSDV()
//}
