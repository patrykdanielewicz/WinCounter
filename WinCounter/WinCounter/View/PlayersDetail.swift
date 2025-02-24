//
//  PlayersDetail.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 18/12/2024.
//
import CoreData
import SwiftUI
import Charts


struct PlayersDetail: View {
    
    @Environment(\.managedObjectContext) private var moc
    
    @ObservedObject var player: Player
    @State private var selectedImage = UIImage(named: "player0")!
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = player.image {
                    if let uiImage = UIImage(data: image) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(.circle)
                        
                    } else {
                        Image(.player0)
                    }
                    Text(player.wrappedName)
                        .font(.title)
                        .bold()
                    
                    
                    List {
                        Section("General statistic") {
                            GeneralStatisticView(player: player)
                        }
                        Section("Sparring stats") {
                            //                            SparringStatisticView(player: player)
                            
                        }
                        
                        Section("You vs Your Rivals") {
                            PlayerVsRivalsChartView(player: player)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        EditPlayer(player: player)
                    } label: {
                        Text("Edit")
                    }
                }
            }
        }
    }
}
    //#Preview {
    //    let player = Players(name: "Patryk Danielewicz", image: UIImage(named: "player0")!.pngData()!)
    //
    //    PlayersDetail(matches: <#[Matches]#>, player: player)
    //}
//}

