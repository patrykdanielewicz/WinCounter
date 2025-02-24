//
//  PlayersView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 05/12/2024.
//
import SwiftData
import SwiftUI

struct PlayersView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "doubels == %@", NSNumber(value: false))) var players: FetchedResults<Player>
  
    
    @State private var isAddNewPlayerPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(players, id: \.self) { player in
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
                                Text(player.wrappedName)
                            } }
                        
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            moc.delete(player)
                            do {
                                try moc.save()
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                        }
                            label: {
                                if player.sparringsArray.isEmpty {
                                    Text("Delete")
                                }
                                else {
                                    Text("Archivize")
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
