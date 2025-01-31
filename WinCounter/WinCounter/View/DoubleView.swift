//
//  Double.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import SwiftData
import SwiftUI

struct DoubleView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query(filter: #Predicate<Players> { player in
        player.singels == false
    }) var teams: [Players]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(teams) { team in
                    NavigationLink {
                        PlayersDetail(player: team)
                    } label: {
                            HStack {
                                if let image = team.image {
                                    if let uiImage = UIImage(data: image) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .clipShape(.circle)
                                    } else {
                                        Image(.player0)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(team.name)
                                        HStack {
                                           
                                                Image(systemName: "1.square")
                                                if let player1 = team.doublesPlayerNr1 {
                                                    Text(player1)
                                                        .font(.footnote)
                                                        .opacity(0.5)
                                                }
                                            }
                                            HStack {
                                                Image(systemName: "2.square")
                                                if let player2 = team.doublesPlayerNr2 {
                                                    Text(player2)
                                                        .font(.footnote)
                                                        .opacity(0.5)
                                                }
                                            }
                                        
                                      
                                    }
                                    
                                }
                            }
                                    
                                
                        }
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            modelContext.delete(team)
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
            }
            .listStyle(PlainListStyle())
             
                
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            AddNewTeam()
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
                }
            
                
                
            }

            
        }
        
    


#Preview {
    PlayersView()
}

