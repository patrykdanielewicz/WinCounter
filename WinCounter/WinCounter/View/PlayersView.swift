//
//  PlayersView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 05/12/2024.
//
import SwiftUI

struct PlayersView: View {
    
    @StateObject private var viewModel: PlayersViewModel
    
    init(dataController: DataControllerProtocol, doubles: Bool) {
        _viewModel = StateObject(wrappedValue: PlayersViewModel(dataController: dataController, doubles: doubles))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.players.filter { $0.doubles == viewModel.doubles }, id: \.id) { player in
                    NavigationLink {
                        PlayersDetail(dataController: viewModel.dc, player: player, double: viewModel.doubles)
                    } label: {
                        HStack {
                            let image = viewModel.dc.decodeImage(for: player)
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(.circle)
                            VStack(alignment: .leading) {
                                Text(player.wrappedName)
                                if viewModel.doubles == true {
                                    HStack {
                                        Image(systemName: "1.square")
                                        Text(player.wrappedDoublesPlayerNr1)
                                            .font(.footnote)
                                            .opacity(0.5)
                                        
                                    }
                                    HStack {
                                        Image(systemName: "2.square")
                                        Text(player.wrappedDoublesPlayerNr2)
                                            .font(.footnote)
                                            .opacity(0.5)
                                    }
                                }
                            }
                            
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.dc.deleteData(player)
                        }
                        label: {
                            Text(viewModel.archiveOrDeleteChecker(player: player))
                        }
                        .tint(.red)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddNewPlayer(dataController: viewModel.dc, doubles: viewModel.doubles )
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
