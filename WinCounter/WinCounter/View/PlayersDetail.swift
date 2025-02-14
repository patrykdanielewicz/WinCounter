//
//  PlayersDetail.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 18/12/2024.
//
import SwiftData
import SwiftUI
import Charts


struct PlayersDetail: View {
  
    @Environment(\.modelContext) private var modelContext
    
    @State var player: Players
    @State private var editProfilePictures = false
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
                            .onTapGesture {
                                editProfilePictures = true
                            }
                    } else {
                        Image(.player0)
                    }
                    Text(player.name)
                        .font(.title)
                        .bold()
                    
                    
                    List {
                        Section("General statistic") {
                            GeneralStatisticView(player: player)
                        }
                        Section("Sparring stats") {
                            SparringStatisticView(player: player)
                            
                        }
                        
                        Section("You vs Your Rivals") {
                            PlayerVsRivalsChartView(player: player)
                        }
                        
                    }
                }
            }
            .sheet(isPresented: $editProfilePictures) {
                PlayersImageInsertOptions(selectedImage: $selectedImage, showInsertImageOptions: $editProfilePictures)
            }
            .onChange(of: selectedImage) {
                changeProfilePictures()
            }
        }

    }


    func changeProfilePictures() {
        if selectedImage != UIImage(named: "player0") {
            if let data = selectedImage.pngData() {
                player.image = data
                do {
                    try modelContext.save()
                }
                catch {
                    print(error.localizedDescription)
                }
                
            }
            }
        
    }
    
    //#Preview {
    //    let player = Players(name: "Patryk Danielewicz", image: UIImage(named: "player0")!.pngData()!)
    //
    //    PlayersDetail(matches: <#[Matches]#>, player: player)
    //}
}

