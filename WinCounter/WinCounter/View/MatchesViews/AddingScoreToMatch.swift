//
//  MatchesPlayedView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 21/01/2025.
//
import CoreData
import SwiftUI

struct AddingScoreToMatch: View {
    
    @Environment(\.managedObjectContext) var moc
    
    
    @State var sparring: Sparring
    
    @Binding var clickState:         [String: Bool]
    @Binding var playersPlayedScore: [Player: Int]
    @Binding var scoreMap:           [String: Int]
    
    var body: some View {

      VStack {
          ForEach(sparring.wrappedPlayers, id: \.self) { player in
                  HStack {
                      if let dataImage = player.image {
                          if let uiImage = UIImage(data: dataImage) {
                              Image(uiImage: uiImage)
                                  .resizable()
                                  .scaledToFill()
                                  .frame(width: 60, height: 60)
                                  .clipShape(.circle)
                          } } else {
                              Image(.player0)
                          }
                      Text(player.wrappedName)
                          .frame(width: 100, alignment: .leading)
                      
                          HStack {
                              VStack {
                                  Text("Score")
                                      .font(.subheadline)
                                  Picker("Score", selection: Binding(
                                    get: { scoreMap[player.wrappedName] ?? 21 },
                                    set: { scoreMap[player.wrappedName] = $0 }
                                  )) {
                                      ForEach(0..<31, id: \.self) { int in
                                          Text("\(int)")
                                      }
                                  }
                                  .pickerStyle(WheelPickerStyle())
                                  .labelsHidden()
                              }
                              Button {
                                  
                                  clickState[player.wrappedName, default: false].toggle()
                                  if clickState[player.wrappedName] == true {
                                      playersPlayedScore[player] = 0
                                  }
                                  else {
                                      playersPlayedScore.removeValue(forKey: player)
                                  }
                                  
                                  
                              } label: {
                                  
                                  Image(systemName: clickState[player.wrappedName, default: false] ? "person.fill.checkmark" : "person.slash.fill")
                                  
                              }
                              .buttonStyle(.plain)
                              .frame(width: 33, height: 33)
                              .disabled(clickState[player.wrappedName, default: false] == false && clickState.values.filter { $0 }.count >= 2)
                          }
//                          .frame(width: 180)
                      
                    
                  }
              }
          
      }
        
    }
}

//#Preview {
//    MatchesPlayedView()
//}
