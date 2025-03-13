//
//  ContentView.swift
//  WatchWinCounter Watch App
//
//  Created by Patryk Danielewicz on 21/01/2025.
//
import CoreData
import SwiftUI

struct SparringView: View {
    @StateObject private var viewModel: SparringViewViewModel
    
    init(dataController:DataControllerProtocol) {
        _viewModel = StateObject(wrappedValue: SparringViewViewModel(dataController: dataController))
    }
    
    var body: some View {
    
        NavigationStack {
            NavigationLink("Add sparring") {
                AddNewSparring(dataController: viewModel.dc)
            }
            List() {
                ForEach(viewModel.sparrings) { sparring in
                    if !sparring.isSparringEnded {
                        NavigationLink {
                            
                                AddNewMatchView(dataController: viewModel.dc, sparring: sparring)
                            
                        } label: {
                            Text("\(sparring.wrappedDate, format: .dateTime.day().month(.wide).year())")
                        }
                    }
                }
                .listItemTint(.brand)
            }
            .listStyle(.carousel)
            .frame(maxHeight: .infinity)
            .navigationTitle("Sparrings")
            .navigationBarTitleDisplayMode(.inline)
        }
   
       
    }
}

//#Preview {
//    ContentView()
//}
