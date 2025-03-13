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
    
    @StateObject private var viewModel: PlayersDetailViewModel
    
    init(dataController: DataControllerProtocol, player: Player, double: Bool) {
        _viewModel = StateObject(wrappedValue: PlayersDetailViewModel(dataController: dataController, player: player, doubles: double))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                let Image = viewModel.dc.decodeImage(for: viewModel.player)
                PlayerImageView(image: Image)
                Text(viewModel.player.wrappedName)
                    .font(.title)
                    .bold()
                StatisticViews(dataController: viewModel.dc, player: viewModel.player)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddNewPlayer(dataController: viewModel.dc, name: viewModel.player.wrappedName, image: viewModel.player.image, id: viewModel.player.id, doubles: viewModel.doubles, player1Name: viewModel.player.wrappedDoublesPlayerNr1, player2Name: viewModel.player.wrappedDoublesPlayerNr2)
                    } label: {
                    Text("Edit")
                    }
                }
            }
        }
    }
}

