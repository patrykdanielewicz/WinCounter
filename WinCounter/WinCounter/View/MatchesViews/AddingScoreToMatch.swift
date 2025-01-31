//
//  MatchesPlayedView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 21/01/2025.
//

import SwiftUI

struct AddingScoreToMatch: View {
    
    
    
    @State var sparring: Sparring
    
    @Binding var clickState:         [String: Bool]
    @Binding var playersPlayedScore: [String: Int] 
    @Binding var scoreMap:           [String: Int]
    
    var body: some View {

      VStack {
          if let players = sparring.players {
              ForEach(players.sorted { $0.name < $1.name }, id: \.self) { player in
                  HStack {
                      if let image = player.image {
                          if let uiImage = UIImage(data: image) {
                              Image(uiImage: uiImage)
                                  .resizable()
                                  .scaledToFill()
                                  .frame(width: 50, height: 50)
                                  .clipShape(.circle)
                          } } else {
                              Image(.player0)
                          }
                      Text(player.name)
//                      Spacer()
                      
                          HStack {
                              VStack {
                                  Text("Score")
                                      .font(.subheadline)
                                  Picker("Score", selection: Binding(
                                    get: { scoreMap[player.name] ?? 21 },
                                    set: { scoreMap[player.name] = $0 }
                                  )) {
                                      ForEach(0..<31, id: \.self) { int in
                                          Text("\(int)")
                                      }
                                  }
                                  .pickerStyle(WheelPickerStyle())
                                  .labelsHidden()
                              }
                              Button {
                                  
                                  clickState[player.name, default: false].toggle()
                                  if clickState[player.name] == true {
                                      playersPlayedScore[player.name] = 0
                                  }
                                  else {
                                      playersPlayedScore.removeValue(forKey: player.name)
                                  }
                                  
                                  
                              } label: {
                                  
                                  Image(systemName: clickState[player.name, default: false] ? "person.fill.checkmark" : "person.slash.fill")
                                  
                              }
                              .buttonStyle(.plain)
                              .frame(width: 33, height: 33)
                              .disabled(clickState[player.name, default: false] == false && clickState.values.filter { $0 }.count >= 2)
                          }
//                          .frame(width: 180)
                      
                    
                  }
              }
          }
      }
        
    }
}

//#Preview {
//    MatchesPlayedView()
//}
