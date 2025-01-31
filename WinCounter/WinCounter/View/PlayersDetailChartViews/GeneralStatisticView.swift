//
//  GeneralStatisticView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import Charts
import SwiftUI

struct GeneralStatisticView: View {
    
    @State var player: Players
    @State private var dataChartForTotalStatistic = [DataStructuresForChart]()
    
    var body: some View {
      
        VStack {

            HStack(alignment: .center) {
                Chart(dataChartForTotalStatistic, id: \.lable) { dataItem in
                    SectorMark(angle: .value("label", dataItem.value), innerRadius: .ratio(0.8))
                        .foregroundStyle(by: .value("Total", dataItem.lable))
                    
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
                            Text("\(player.totalWins)")
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
                        Text("\(player.totalGames)")
                            .font(.title)
                            .fontWeight(.heavy)
                        Text("Total Games")
                            .font(.footnote)
                            .opacity(0.8)
                    }
                    //                            .padding(.top)
                    .padding(.leading)
                    .padding(.bottom, 0.8)
                    
                    VStack {
                        Text("\(player.totalGames - player.totalWins)")
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
        .onAppear {
            dataChartForTotalStatistic = DataForChartsPreparation.dataForTotalStatisticPreparation(player: player)
        }
    }
}

//#Preview {
//    GeneralStatisticView()
//}
