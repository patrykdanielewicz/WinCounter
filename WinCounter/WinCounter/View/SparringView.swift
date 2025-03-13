//
//  SparringView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 18/12/2024.
//
import CoreData
import SwiftUI

struct SparringView: View {

    @StateObject private var viewModel: SparringViewModel
    
    init(dataController: DataControllerProtocol) {
        _viewModel = StateObject(wrappedValue: SparringViewModel(dataController: dataController))
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sparrings, id: \.id) { sparring in
                    NavigationLink {
                        MatchesView(dataController: viewModel.dc, sparring: sparring)
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
                if let lastSparring = viewModel.sparrings.last {
                    MatchesView(dataController: viewModel.dc, sparring: lastSparring)
                }
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
                AddNewSparring(dataController: viewModel.dc)
            }
        }
    }
}
