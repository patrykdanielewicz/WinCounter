//
//  MatchPoints+CoreDataProperties.swift
//  WinCounter
//
//  Created by Patryk Danielewicz on 11/03/2025.
//
//

import Foundation
import CoreData


extension MatchPoints {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MatchPoints> {
        return NSFetchRequest<MatchPoints>(entityName: "MatchPoints")
    }

    @NSManaged public var points: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var match: Match?
    @NSManaged public var player: Player?

    public var wrappedPlayer: Player {
        return player ?? Player()
    }
    
    public var wrappedMatch: Match {
        return match ?? Match()
    }
    
}

extension MatchPoints : Identifiable {

}
