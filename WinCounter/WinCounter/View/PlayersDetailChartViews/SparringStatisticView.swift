//
//  SparringStatisticView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import Charts
import SwiftUI

struct SparringStatisticView: View {
    
    @State var player: Players
    @State private var dataChartForEachSparring = [DataForEachSparring]()
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(dataChartForEachSparring) { chart in
                        VStack {
                            Text("\(chart.sparring, format: .dateTime.day().month(.twoDigits))")
                                .font(.footnote)
                                .fontWeight(.ultraLight)
                            
                            NavigationLink(destination: SparringStatisticDetailView(filterDate: chart.sparring, player: player)) {
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
            .onAppear {
                dataChartForEachSparring = DataForChartsPreparation.dataForSparringsStatistic(player: player)
            }
        }
    }
}


//#Preview {
//    SparringStatisticView()
//}
