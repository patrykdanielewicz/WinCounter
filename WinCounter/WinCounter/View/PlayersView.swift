//
//  PlayersView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 05/12/2024.
//
import SwiftData
import SwiftUI

struct PlayersView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query(filter: #Predicate<Players> { player in
        player.singels == true
    }) var players: [Players]
    
    @State private var isAddNewPlayerPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(players) { player in
                    NavigationLink {
                        PlayersDetail(player: player)
                    } label: {
                        HStack {
                            if let image = player.image {
                                if let uiImage = UIImage(data: image) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(.circle)
                                } else {
                                    Image(.player0)
                                }
                                Text(player.name)
                            } }
                        
                    }
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            modelContext.delete(player)
                            do {
                                 try modelContext.save()
                            }
                            catch {
                                print(error.localizedDescription)
                            }

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


#Preview {
    PlayersView()
}
