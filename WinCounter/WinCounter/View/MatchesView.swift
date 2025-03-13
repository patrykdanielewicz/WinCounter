//
//  MatchesView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 31/12/2024.
//
import CoreData
import SwiftUI

struct MatchesView: View {
    
    @StateObject var viewModel: MatchesViewModel

    init(dataController: DataControllerProtocol, sparring: Sparring) {
        _viewModel = StateObject(wrappedValue: MatchesViewModel(dataController: dataController, sparring: sparring))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List {
                        if viewModel.sparring.isSparringEnded == false {
                            VStack {
                                VStack {
                                    ForEach(viewModel.sparring.wrappedPlayers, id: \.id) { player in
                                        HStack {
                                            let uiImage = viewModel.dc.decodeImage(for: player)
                                            PlayerImageView(image: uiImage)
                                            Text(player.wrappedName)
                                                .frame(width: 100, alignment: .leading)
                                            HStack {
                                                VStack {
                                                    Text("Score")
                                                        .font(.subheadline)
                                                    Picker("Score", selection: Binding(
                                                        get: { viewModel.scoreMap[player.wrappedName] ?? 21 },
                                                        set: { viewModel.scoreMap[player.wrappedName] = $0 }
                                                    )) {
                                                        ForEach(0..<31, id: \.self) { int in
                                                            Text("\(int)")
                                                        }
                                                    }
                                                        .pickerStyle(WheelPickerStyle())
                                                        .labelsHidden()
                                                }
                                                Button {
                                                    viewModel.addingPlayerOrTeamToMatch(player: player)
                                                } label: {
                                                    Image(systemName: viewModel.clickState[player.wrappedName, default: false] ? "person.fill.checkmark" : "person.slash.fill")
                                                }
                                                    .buttonStyle(.plain)
                                                    .frame(width: 33, height: 33)
                                                    .disabled(viewModel.clickState[player.wrappedName, default: false] == false && viewModel.clickState.values.filter { $0 }.count >= 2)
                                            }
                                        }
                                    }
                                }
                            }
                            Button("Add new player or team") {
                                viewModel.addingNewPlayerOrTeam()
                            }
                                .buttonStyle(.borderless)
                        }
                        Section("Matches played") {
                            ForEach(viewModel.matches.sorted {$0.matchNumber > $1.matchNumber }, id: \.id) { match in
                                NavigationLink {
                                    MatchEditingView(dataController: viewModel.dc, match: match)
                                } label: {
                                    VStack(alignment: .leading) {
                                        Text("Match nr \(Int(match.matchNumber))")
                                            .font(.headline)
                                        ForEach(match.wrappedPoints.sorted { $0.points > $1.points }, id: \.id) { points in
                                            let player = points.wrappedPlayer
                                            Text("\(player.wrappedName): \(Int(points.points)) points")
                                                .fontWeight(match.winner?.player == player ? .bold : .regular)
                                        }
                                    }
                                }
                                .swipeActions {
                                    Button("Delete", role: .destructive) {
                                        viewModel.dc.deleteData(match)
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                        Button() {
                            viewModel.endingSparring()
                        } label: {
                            Text(viewModel.sparring.isSparringEnded ? "Edit sparring" : "End sparring")
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                        }
                            .buttonStyle(.borderless)
                    }
                }
                if viewModel.showCheckmark {
                    VStack {
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.brandPrimary)
                            .transition(.scale)
                            .animation(.easeInOut, value: viewModel.showCheckmark)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut, value: viewModel.showCheckmark)
                }
            }
        }
            .navigationTitle("Matches")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        viewModel.saveMatch()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                viewModel.showCheckmark = false
                            }
                       
                    }
                }
            }
            .sheet(isPresented: $viewModel.addNewPlayerOrTeam, content: {
                    AddNewSparring(dataController: viewModel.dc, sparring: viewModel.sparring)
            })
            .alert("Not enought players", isPresented: $viewModel.notEnoughtPlayersAllert) {
                Button("Ok") { }
                } message: {
                    Text("There are not enough players to play the match - please mark at least 2 players")
                }
            .alert("Is's a tie", isPresented: $viewModel.isATie) {
                Button("Ok") { }
                } message: {
                    Text("In badminton, there are no ties – someone must win by a two-point advantage or be the first to score 30 points.")
                }
        }
    }
        
    

    
    //#Preview {
    //    MatchesView()
    //}

