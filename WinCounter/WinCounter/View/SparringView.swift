//
//  MachesView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 18/12/2024.
//
import CoreData
import SwiftUI

struct SparringView: View {
    
    @StateObject private var viewModel = SparringViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sparrings, id: \.self) { sparring in
                    NavigationLink {
                        MatchesView(sparring: sparring)
                    } label: {
                        Text("\(sparring.wrappedDate, format: .dateTime.day().month(.wide).year())")
                    }
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            viewModel.dc.deleteData(sparring)
                        }
                        .tint(.red)
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.isNewSparringAdded) {
                MatchesView(sparring: viewModel.latestSparring())
                    
                }
                .navigationTitle("Sparrings")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add new sparring", systemImage: "plus") {
                            viewModel.addNewSparring()
                        }
                    }
                }
                .sheet(isPresented: $viewModel.isAddNewSparringPresented) {
                AddNewSparring()
            }
        }
    }
}
