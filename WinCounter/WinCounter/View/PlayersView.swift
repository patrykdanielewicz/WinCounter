//
//  PlayersView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 05/12/2024.
//
import SwiftUI

struct PlayersView: View {
    
    @StateObject private var modelView = PlayersViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(modelView.players, id: \.self) { player in
                    NavigationLink {
                        PlayersDetail(player: player)
                    } label: {
                        HStack {
                            let image = modelView.dc.creatingUIImage(for: player)
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(.circle)
                            Text(player.wrappedName)
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            modelView.dc.deleteData(player)
                        }
                        label: {
                            Text(modelView.archiveOrDeleteChecker(player: player))
                        }
                        .tint(.red)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddNewPlayer()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

