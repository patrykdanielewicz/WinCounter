//
//  Double.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 15/01/2025.
//

import CoreData
import SwiftUI

struct DoubleView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Player.entity(), sortDescriptors: [], predicate: NSPredicate(format: "doubels == %@", NSNumber(value: true))) private var teams: FetchedResults<Player>
 
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(teams) { team in
                    NavigationLink {
//                        PlayersDetail(player: team)
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
                                        Text(team.wrappedName)
                                        HStack {
                                           
                                                Image(systemName: "1.square")
                                                let player1 = team.wrappedDoublesPlayerNr1
                                                    Text(player1)
                                                        .font(.footnote)
                                                        .opacity(0.5)
                                                
                                            }
                                            HStack {
                                                Image(systemName: "2.square")
                                                let player2 = team.wrappedDoublesPlayerNr2
                                                    Text(player2)
                                                        .font(.footnote)
                                                        .opacity(0.5)
                                                
                                            }
                                        
                                      
                                    }
                                    
                                }
                            }
                                    
                                
                        }
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            moc.delete(team)
                            do {
                                try moc.save()
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
        
    


//#Preview {
//    PlayersView()
//}

