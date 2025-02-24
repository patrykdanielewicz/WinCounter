//
//  MatchWinners+CoreDataProperties.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 20/02/2025.
//
//

import Foundation
import CoreData


extension MatchWinners {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MatchWinners> {
        return NSFetchRequest<MatchWinners>(entityName: "MatchWinners")
    }

    @NSManaged public var points: Int16
    @NSManaged public var match: Match?
    @NSManaged public var player: Player?

    public var wrappedPlayer: Player {
        return player ?? Player()
    }
    
}

extension MatchWinners : Identifiable {

}
