//
//  MatchEditingView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 22/01/2025.
//
import CoreData
import SwiftUI

struct MatchEditingView: View {
    
    @Environment(\.dismiss)      var dismiss
    @StateObject private var viewModel: MatchEditingViewModel
    
    @State var players         = [Player]()
    @State private var score   = [Int]()
    @State private var isATie  = false
    
    init(dataController: DataControllerProtocol, match: Match) {
        _viewModel =  StateObject(wrappedValue: MatchEditingViewModel(dataController: dataController, match: match))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List() {
                    ForEach(viewModel.match.wrappedPoints.sorted { $0.points > $1.points }, id: \.self) { matchPoints in
                        HStack {
                            HStack {
                                let image = viewModel.dc.decodeImage(for: matchPoints.wrappedPlayer)
                                PlayerImageView(image: image)
                                Text(matchPoints.wrappedPlayer.wrappedName)
                                    .frame(width: 100, alignment: .leading)
                                Picker("Score", selection: Binding(
                                    get: { Int(matchPoints.points) },
                                    set: { matchPoints.points = Int16($0)
                                        viewModel.dc.saveData()
                                    }
                                )) {
                                    ForEach(0..<31, id: \.self) { int in
                                        Text("\(int)")
                                    }
                                }
                                    .pickerStyle(WheelPickerStyle())
                                    .labelsHidden()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Edit score in match number \(Int(viewModel.match.matchNumber))")
        .navigationBarTitleDisplayMode(.inline)
        .alert("It's a tie", isPresented: $isATie) {
            Button("Ok") { }
        } message: {
            Text("In badminton, there are no ties – someone must win by a two-point advantage or be the first to score 30 points.")
        }
    }
}
