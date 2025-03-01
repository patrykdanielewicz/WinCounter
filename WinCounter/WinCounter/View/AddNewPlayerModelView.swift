//
//  AddNewPlayerModelView.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 01/03/2025.
//
import SwiftUI
import Foundation

class AddNewPlayerViewModel: ObservableObject {
    
    let dc = DataController.shared
    
    @Published  var name: String = ""
    @Published var playersImage: UIImage? = UIImage(named: "addPicture")
    @Published var selectedNumber: Int = 0
    @Published  var showImageInsertOptions: Bool = false
    @Published  var notEnoughCaractersInName: Bool = false
    
    
}
